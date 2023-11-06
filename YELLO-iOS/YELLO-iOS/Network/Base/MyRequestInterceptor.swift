//
//  MyRequestInterceptor.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/19.
//

import Foundation

import Alamofire
import UIKit
import KakaoSDKUser

final class MyRequestInterceptor: RequestInterceptor {
    private let maxRetryCount: Int = 3
    private var retryCount: Int = 0
    var isrefreshed = false
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("🐭🐭interceptor adapt 작동!!🐭🐭")
        /// request 될 때마다 실행됨
        let accessToken = KeychainHandler.shared.accessToken
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
    
    func refresh() {
        print("재발급 출발")
        if retryCount < maxRetryCount {
            
            NetworkService.shared.onboardingService.postRefreshToken() { result in
                switch result {
                case .success(let data):
                    guard let decodedData = data.data else { return }
                    if data.status == 201 {
                        KeychainHandler.shared.refreshToken = decodedData.refreshToken
                        KeychainHandler.shared.accessToken = decodedData.accessToken
                        self.isrefreshed = true
                        return
                    } else if data.status == 403 {
                        if data.message.contains("재로그인") {
                            self.logout()
                        }
                    }
                default:
                    self.logout()
                }
            }
        }
        self.retryCount += 1
    }
    
    func refreshToken(completion: @escaping (Bool) -> Void) {
        print("재발급 출발")
        
        NetworkService.shared.onboardingService.postRefreshToken() { result in
            switch result {
            case .success(let data):
                if data.status == 403 {
                    completion(false)
                    self.logout()
                }
                if data.status == 201 {
                    guard let data = data.data else { return }
                    KeychainHandler.shared.refreshToken = data.refreshToken
                    KeychainHandler.shared.accessToken = data.accessToken
                    self.isrefreshed = true
                    completion(true)
                    return
                }
                
            default:
                completion(false)
                self.logout()
            }
        }
        self.retryCount += 1
    }
    
    func logout() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print("kakao ERROR: \(error)")
            } else {
                
            }
            print("logout() success.")
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            
            User.shared.isResigned = false
            User.shared.isFirstUser = false
            
            UserDefaults.standard.removeObject(forKey: "isLoggined")
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: KakaoLoginViewController())
            
        }
    }
}
