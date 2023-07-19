//
//  MyRequestInterceptor.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/19.
//

import Foundation

import Alamofire

final class MyRequestInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(Config.baseURL) == true
               else {
                  completion(.success(urlRequest))
                  return
              }
        
        let accessToken = KeychainHandler.shared.accessToken
        
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
    }
}
