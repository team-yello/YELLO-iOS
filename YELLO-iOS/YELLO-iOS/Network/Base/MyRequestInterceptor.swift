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
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(Config.baseURL) == true
        else {
            completion(.success(urlRequest))
            return
        }
        
        if !(KeychainHandler.shared.refreshToken.isEmpty) {
            NetworkService.shared.onboardingService.postRefreshToken { result in
                switch result {
                case .success (let data):
                    if data.status == 201 {
                        guard let data = data.data else { return }
                        KeychainHandler.shared.accessToken = data.accessToken
                        KeychainHandler.shared.refreshToken = data.refreshToken
                        print("====토큰 재발급 완료====")
                    } else if data.status == 403 {
                        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                        
                        UserDefaults.standard.removeObject(forKey: "isLoggined")
                       sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: KakaoLoginViewController())
                    }
                    
                default:
                    return
                }
            }
        }
        
        
        let accessToken = KeychainHandler.shared.accessToken
        UserDefaults.standard.setValue(accessToken, forKey: "accessToken")
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
