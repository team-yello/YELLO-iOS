//
//  MyRequestInterceptor.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/19.
//

import UIKit

import Alamofire
import KakaoSDKUser

final class YelloRequestInterceptor: RequestInterceptor {
    
    private let maxRetryCount: Int = 3
    var isrefreshed = false
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("🐭interceptor adapt 작동!!")
        /// request 될 때마다 실행됨
        let accessToken = KeychainHandler.shared.accessToken
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for _: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("🐭🐭interceptor 작동!!")
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetryWithError(error))
            return
        }
        if request.retryCount < maxRetryCount {
            switch response.statusCode {
            case 503: // timeout
                if request.retryCount < maxRetryCount {
                    completion(.retry)
                } else {
                    topViewController()?.view.showToast(message: "네트워크 에러입니다. 잠시 후 다시 실행해주세요")
                    completion(.doNotRetry)
                }
            case 401: // unauthorized
                refreshToken { [weak self] isSuccess in
                    if isSuccess {
                        completion(.retry)
                    } else {
                        completion(.doNotRetry)
                    }
                }
            default:
                completion(.doNotRetry)
            }
        } else {
            topViewController()?.view.showToast(message: "네트워크 에러입니다. 잠시 후 다시 실행해주세요")
            completion(.doNotRetry)
        }
        
    }
    
    func refreshToken(completion: @escaping (Bool) -> Void) {
        print("토큰 재발급 시작")
        NetworkService.shared.onboardingService.postRefreshToken() { result in
            switch result {
            case .success(let data):
                if data.status == 403 {
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
    }
    
    func logout() {
        UserApi.shared.logout { (error) in
            if let error = error {
                print("kakao ERROR: \(error)")
            } else {
                DispatchQueue.main.async {
                    print("logout() success.")
                }
            }
        }
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        
        UserManager.shared.isResigned = false
        UserManager.shared.isFirstUser = false
        
        UserDefaults.standard.removeObject(forKey: "isLoggined")
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: KakaoLoginViewController())
    }
}
