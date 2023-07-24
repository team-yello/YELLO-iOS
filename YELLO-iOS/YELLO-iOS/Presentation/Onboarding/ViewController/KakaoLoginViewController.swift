//
//  KakaoLoginViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/15.
//

import UIKit

import KakaoSDKUser
import AuthenticationServices

class KakaoLoginViewController: BaseViewController {
    
    let baseView = KakaoLoginView()
    override func loadView() {
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
    }
    
    func addTarget() {
        baseView.kakaoButton.addTarget(self, action: #selector(kakaoLoginButtonDidTap), for: .touchUpInside)
        baseView.authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }
    
    @objc func kakaoLoginButtonDidTap() {
        /// 카카오톡 실행 가능 여부 확인
        /// isKakaoTalkLoginAvailable() : 카톡 설치 되어있으면 true
        
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print("🚩🚩\(error)")
                } else {
                    print("----🚩카카오 톡으로 로그인 성공🚩----")
                    
                    guard let kakaoToken = oauthToken?.accessToken else { return }
                    let queryDTO = KakaoLoginRequestDTO(accessToken: kakaoToken, social: "KAKAO")
                    
                    NetworkService.shared.onboardingService.postTokenChange(queryDTO: queryDTO) { result in
                        switch result {
                        case .success(let data):
                            if data.status == 403 {
                                UserApi.shared.me() {(user, error) in
                                    if let error = error {
                                        print(error)
                                    } else {
                                        print("me() success.")
                                        _ = user
                                        guard let user = user else { return }
                                        guard let uuidInt = user.id else { return }
                                        let uuid = String(uuidInt)
                                        
                                        guard let email = user.kakaoAccount?.email else { return }
                                        guard let profile = user.kakaoAccount?.profile?.profileImageUrl else {return}
                                        User.shared.social = "KAKAO"
                                        User.shared.uuid = uuid
                                        User.shared.email = email
                                        User.shared.profileImage = profile.absoluteString
                                        
                                    }
                                }
                                
                                let kakaoConnectViewController = (KakaoConnectViewController())
                                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                                self.navigationController?.pushViewController(KakaoConnectViewController(), animated: true)
                            } else if data.status == 201 {
                                guard let data = data.data else { return }
                                KeychainHandler.shared.accessToken = data.accessToken
                                UserDefaults.standard.setValue(true, forKey: "isLoggined")
                                self.navigationController?.pushViewController(YELLOTabBarController(), animated: true)
                            }
                        default:
                            print("network failure")
                            return
                        }
                    }
                    
                }
            }
        } else {
            // 카톡 없으면 -> 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 계정으로 로그인 성공")
                    
                    guard let kakaoToken = oauthToken?.accessToken else { return }
                    let queryDTO = KakaoLoginRequestDTO(accessToken: kakaoToken, social: "KAKAO")
                    
                    print(queryDTO)
                    
                    print(Config.baseURL)
                    
                    NetworkService.shared.onboardingService.postTokenChange(queryDTO: queryDTO) { result in
                        print(result)
                        switch result {
                        case .success(let data):
                            if data.status == 403 {
                                UserApi.shared.me() {(user, error) in
                                    if let error = error {
                                        print("🚩🚩\(error)")
                                    } else {
                                        print("me() success.")
                                        _ = user
                                        guard let user = user else { return }
                                        guard let uuidInt = user.id else { return }
                                        let uuid = String(uuidInt)
                                        
                                        guard let email = user.kakaoAccount?.email else { return }
                                        guard let profile = user.kakaoAccount?.profile?.profileImageUrl else {return}
                                        User.shared.social = "KAKAO"
                                        User.shared.uuid = uuid
                                        User.shared.email = email
                                        User.shared.profileImage = profile.absoluteString
                                        
                                    }
                                }
                                self.navigationController?.pushViewController(KakaoConnectViewController(), animated: true)
                            } else if data.status == 201 {
                                guard let data = data.data else { return }
                                KeychainHandler.shared.accessToken = data.accessToken
                                KeychainHandler.shared.refreshToken = data.refreshToken
                                UserDefaults.standard.setValue(true, forKey: "isLoggined")
                                self.navigationController?.pushViewController(YELLOTabBarController(), animated: true)
                            }
                        default:
                            print("network failure")
                            return
                        }
                    }
                    
                    _ = oauthToken
                    
                    // 관련 메소드 추가
                }
            }
        }
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let accessToken = appleIDCredential.authorizationCode
            print("-----🍎애플 로그인 성공!🍎------")
            
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
}

extension KakaoLoginViewController: ASAuthorizationControllerDelegate {
    
}

extension KakaoLoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
