//
//  KakaoConnectViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/15.
//

import UIKit

import KakaoSDKUser
import KakaoSDKTalk

class KakaoConnectViewController: BaseViewController {
    
    let baseView = KakaoConnectView()

    override func loadView() {
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
    }
    
    func addTarget() {
        baseView.kakaoConnectButton.addTarget(self, action: #selector(connectButtonDidTap), for: .touchUpInside)
    }
    
    @objc func connectButtonDidTap() {
        TalkApi.shared.profile {(profile, error) in
            if let error = error {
                print(error)
            } else {
                _ = profile
                self.navigationController?.pushViewController(SchoolSearchViewController(), animated: true)
            }
        }
        
    }
    
}
