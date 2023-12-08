//
//  KakaoLoginViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/15.
//

import UIKit

import Amplitude
import KakaoSDKUser
import KakaoSDKTalk

class KakaoLoginViewController: UIViewController {
    // MARK: - Variables
    // MARK: Component
    let baseView = KakaoLoginView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func loadView() {
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
    }
    
    // MARK: Custom Function
    func addTarget() {
        baseView.kakaoButton.addTarget(self, action: #selector(kakaoLoginButtonDidTap), for: .touchUpInside)
        baseView.privacyButton.addTarget(self, action: #selector(privacyButtonDidTap), for: .touchUpInside)
    }
    
    func authNetwork(queryDTO: KakaoLoginRequestDTO) {
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
                            guard let kakaoUser = user.kakaoAccount else {return}
                            guard let email = kakaoUser.email else {return}
                            guard let profile = user.kakaoAccount?.profile?.profileImageUrl else {return}
                            User.shared.social = "KAKAO"
                            User.shared.uuid = String(uuidInt)
                            User.shared.email = email
                            User.shared.name = kakaoUser.name ?? ""
                            User.shared.gender = kakaoUser.gender?.rawValue.uppercased() ?? ""
                            User.shared.profileImage = profile.absoluteString
                        }
                        
                        UserApi.shared.scopes(scopes: ["friends"]) { (scopeInfo, error) in
                            if let error = error {
                                print(error)
                            } else {
                                /// 동의항목 확인하기
                                guard let scopeInfo = scopeInfo else { return }
                                guard let allowList = scopeInfo.scopes else { return }
                                if allowList[0].agreed {
                                    Amplitude.instance().logEvent("click_onboarding_kakao_friends")
                                    TalkApi.shared.friends(limit: 100) {(friends, error) in
                                        if let error = error {
                                            print(error)
                                        } else {
                                            var allFriends: [String] = []
                                            friends?.elements?.forEach({
                                                guard let id = $0.id else { return }
                                                allFriends.append(String(id))
                                            })
                                            User.shared.kakaoFriends = allFriends
                                        }
                                    }
                                }
                                
                                /// 확인 후 플로우 변경
                                let nextViewController = allowList[0].agreed ? SchoolSelectViewController() : KakaoConnectViewController()
                                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                                self.navigationController?.pushViewController(nextViewController, animated: true)
                            }
                        }
                        
                    }
                } else if data.status == 201 {
                    guard let data = data.data else { return }
                    KeychainHandler.shared.accessToken = data.accessToken
                    KeychainHandler.shared.refreshToken = data.refreshToken
                    UserDefaults.standard.setValue(true, forKey: "isLoggined")
                    
                    User.shared.isResigned = data.isResigned
                    Amplitude.instance().logEvent("complete_onboarding_finish")
                    
                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                    
                    if isFirstTime() {
                        let rootViewController = PushSettingViewController()
                        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: rootViewController)
                    } else if User.shared.isResigned {
                        let rootViewController = TutorialViewController()
                        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: rootViewController)
                    } else {
                        let rootViewController = YELLOTabBarController()
                        let status = UserDefaults.standard.integer(forKey: "status")
                        rootViewController.startStatus = status
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: rootViewController)
                        }
                    }
                }
            default:
                print("network failure")
                return
            }
        }
    }
    
    // MARK: Objc Function
    @objc func kakaoLoginButtonDidTap() {
        baseView.kakaoButton.isEnabled = false
        Amplitude.instance().logEvent("click_onboarding_kakao")
        /// 카카오톡 실행 가능 여부 확인
        /// isKakaoTalkLoginAvailable() : 카톡 설치 되어있으면 true
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print("🚩🚩\(error)")
                } else {
                    print("----🚩카카오 톡으로 로그인 성공🚩----")
                    DispatchQueue.main.async {
                        self.baseView.kakaoButton.isEnabled = false
                        Amplitude.instance().logEvent("complete_onboarding_finish")
                        guard let kakaoToken = oauthToken?.accessToken else { return }
                        let queryDTO = KakaoLoginRequestDTO(accessToken: kakaoToken, social: "KAKAO", deviceToken: User.shared.deviceToken)
                        self.authNetwork(queryDTO: queryDTO)
                    }
                }
            }
        } else {
            /// 카톡 없으면 -> 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 계정으로 로그인 성공")
                    self.baseView.kakaoButton.isEnabled = false
                    Amplitude.instance().logEvent("complete_onboarding_finish")
                    guard let kakaoToken = oauthToken?.accessToken else { return }
                    let queryDTO = KakaoLoginRequestDTO(accessToken: kakaoToken, social: "KAKAO", deviceToken: User.shared.deviceToken)
                    self.authNetwork(queryDTO: queryDTO)
                }
            }
        }
    }
    
    @objc func privacyButtonDidTap() {
        guard let url = URL(string: "https://yell0.notion.site/97f57eaed6c749bbb134c7e8dc81ab3f") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
