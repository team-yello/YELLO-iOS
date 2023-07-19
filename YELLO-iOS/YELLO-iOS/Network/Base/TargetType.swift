//
//  TargetType.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/15.
//

import Foundation

import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
    var headerType: HTTPHeaderType { get }
}

extension TargetType {
    var baseURL: String {
        return Config.baseURL
    }
    var headers: [String: String]? {
        switch headerType {
        case .plain:
            return [
                HTTPHeaderFieldKey.contentType.rawValue: HTTPHeaderFieldValue.json.rawValue
            ]
        case .hasAccessToken:
            return [
                HTTPHeaderFieldKey.contentType.rawValue: HTTPHeaderFieldValue.json.rawValue,
                HTTPHeaderFieldKey.accessToken.rawValue: KeychainHandler.shared.accessToken
            ]
        }
    }
}
extension TargetType {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = try URLRequest(
            url: url.appendingPathComponent(path),
            method: method
        )
        
        switch headerType {
        case .plain:
            urlRequest.setValue(HTTPHeaderFieldValue.json.rawValue, forHTTPHeaderField: HTTPHeaderFieldKey.contentType.rawValue)
        case .hasAccessToken:
            urlRequest.setValue(HTTPHeaderFieldValue.json.rawValue, forHTTPHeaderField: HTTPHeaderFieldKey.contentType.rawValue)
            urlRequest.setValue(KeychainHandler.shared.accessToken, forHTTPHeaderField: HTTPHeaderFieldKey.authentication.rawValue)
        }

        switch parameters {
        case .requestWithBody(let request):
            let params = request?.toDictionary() ?? [:]
            
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        case .requestQuery(let request):
            let params = request?.toDictionary()
            let queryParams = params?.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
            var components = URLComponents(
                string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        case .requestQueryWithBody(let queryRequest, let bodyRequest):
            let params = queryRequest?.toDictionary()
            let queryParams = params?.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
            var components = URLComponents(
                string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
            
            let bodyParams = bodyRequest?.toDictionary() ?? [:]
            
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParams)
            
        case .requestPlain:
            break
        }
        return urlRequest
    }
}

@frozen
enum RequestParams {
    case requestPlain
    case requestWithBody(_ paramter: Encodable?)
    case requestQuery(_ parameter: Encodable?)
    case requestQueryWithBody(_ queryParameter: Encodable?, bodyParameter: Encodable?)
}

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let dictionaryData = jsonData as? [String: Any]
        else { return [:] }
        
        return dictionaryData
    }
}
