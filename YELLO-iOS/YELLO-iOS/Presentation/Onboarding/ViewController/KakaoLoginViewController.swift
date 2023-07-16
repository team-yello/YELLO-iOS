//
//  KakaoLoginViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/15.
//

import UIKit
import KakaoSDKUser

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
    }
    
    @objc func kakaoLoginButtonDidTap() {
        /// 카카오톡 실행 가능 여부 확인
        /// isKakaoTalkLoginAvailable() : 카톡 설치 되어있으면 true
 
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 톡으로 로그인 성공")

                    _ = oauthToken
                    /// 로그인 관련 메소드 추가
                    self.navigationController?.pushViewController(KakaoConnectViewController(), animated: true)
                }
            }
        } else {

            // 카톡 없으면 -> 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 계정으로 로그인 성공")

                    _ = oauthToken
                    // 관련 메소드 추가
                    self.navigationController?.pushViewController(KakaoConnectViewController(), animated: true)
                }
            }
        }
    }
    
}
