//
//  MyRequestInterceptor.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/19.
//

import Foundation

import Alamofire
import UIKit

final class MyRequestInterceptor: RequestInterceptor {
    private let maxRetryCount: Int = 3
    private var retryCount: Int = 0
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("🐭🐭interceptor adapt 작동!!🐭🐭")
        /// request 될 때마다 실행됨
        let accessToken = KeychainHandler.shared.accessToken
        let refreshToken = KeychainHandler.shared.refreshToken
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        /// 에러 발생 시에만 실행됨
        completion(.retry)
        print("🐭🐭interceptor 작동!!🐭🐭")
        guard
            let statusCode = request.response?.statusCode,
            statusCode == 401,
            request.retryCount < maxRetryCount
        else {
            return completion(.doNotRetry)
        }
        
        refreshToken { [weak self] isSuccess in
            if isSuccess {
                self?.retryCount += 1
                completion(.retry)
            } else {
                completion(.doNotRetry)
            }
        }
    }
    
    func refreshToken(completion: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-ACCESS-AUTH": "Bearer \(KeychainHandler.shared.accessToken)",
            "X-REFRESH-AUTH": "Bearer \(KeychainHandler.shared.refreshToken)"
        ]
        
        let dataTask = AF.request(
            Config.baseURL + "/auth/token/issue",
            method: .post,
            encoding: JSONEncoding.default,
            headers: headers
        )
        
        dataTask.responseData { responseData in
            switch responseData.result {
            case .success:
                guard let value = responseData.value else { return }
                
                guard let decodedData = try? JSONDecoder().decode(TokenRefreshResponseDTO.self, from: value) else {
                    print("decoding 실패")
                    return
                }
                if decodedData.status == 201 {
                    KeychainHandler.shared.refreshToken = decodedData.data.refreshToken
                    KeychainHandler.shared.accessToken = decodedData.data.accessToken
                    print("토큰 재발급 완료!")
                    completion(true)
                } else if decodedData.status == 403 {
                    KeychainHandler.shared.refreshToken = ""
                    KeychainHandler.shared.accessToken = ""
                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                    
                    UserDefaults.standard.removeObject(forKey: "isLoggined")
                    sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: KakaoLoginViewController())
                    
                    print(decodedData.message)
                    
                }
                
            case .failure:
                KeychainHandler.shared.refreshToken = ""
                KeychainHandler.shared.accessToken = ""
                completion(false)
            }
        }
    }
}
