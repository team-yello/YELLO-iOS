//
//  KakaoLoginViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/15.
//

import UIKit

import KakaoSDKUser

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
                            let uuid = String(uuidInt)
                            
                            guard let kakaoUser = user.kakaoAccount else {return}
                            guard let email = kakaoUser.email else {return}
                            guard let profile = user.kakaoAccount?.profile?.profileImageUrl else {return}
                            User.shared.social = "KAKAO"
                            User.shared.uuid = uuid
                            User.shared.email = email
                            User.shared.name = kakaoUser.name ?? ""
                            User.shared.gender = kakaoUser.gender?.rawValue.uppercased() ?? ""
                            User.shared.profileImage = profile.absoluteString
                            
                        }
                    }
                    
                    let kakaoConnectViewController = (KakaoConnectViewController())
                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                    self.navigationController?.pushViewController(KakaoConnectViewController(), animated: true)
                } else if data.status == 201 {
                    guard let data = data.data else { return }
                    KeychainHandler.shared.accessToken = data.accessToken
                    KeychainHandler.shared.refreshToken = data.refreshToken
                    UserDefaults.standard.setValue(true, forKey: "isLoggined")
                    
                    var rootViewController: UIViewController = YELLOTabBarController()
                    User.shared.isResigned = data.isResigned
                    
                    print("isResigned: \(User.shared.isResigned)")
                    if User.shared.isResigned || isFirstTime() {
                        rootViewController = PushSettingViewController()
                    } else {
                        rootViewController = YELLOTabBarController()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: rootViewController)
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
        /// 카카오톡 실행 가능 여부 확인
        /// isKakaoTalkLoginAvailable() : 카톡 설치 되어있으면 true
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print("🚩🚩\(error)")
                } else {
                    print("----🚩카카오 톡으로 로그인 성공🚩----")
                    guard let kakaoToken = oauthToken?.accessToken else { return }
                    let queryDTO = KakaoLoginRequestDTO(accessToken: kakaoToken, social: "KAKAO", deviceToken: User.shared.deviceToken)

                    self.authNetwork(queryDTO: queryDTO)
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
                    let queryDTO = KakaoLoginRequestDTO(accessToken: kakaoToken, social: "KAKAO", deviceToken: User.shared.deviceToken)
                    self.authNetwork(queryDTO: queryDTO)
                }
            }
        }
        
    }
}
