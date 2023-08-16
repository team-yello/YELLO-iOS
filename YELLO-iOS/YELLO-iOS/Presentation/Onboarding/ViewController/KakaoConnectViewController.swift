//
//  KakaoConnectViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/15.
//

import UIKit

import KakaoSDKUser
import KakaoSDKTalk
import Amplitude

class KakaoConnectViewController: UIViewController {
    
    let baseView = KakaoConnectView()

    override func loadView() {
        navigationItem.title = ""
        view = baseView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
    }
    
    func addTarget() {
        baseView.kakaoConnectButton.addTarget(self, action: #selector(connectButtonDidTap), for: .touchUpInside)
    }
    
    @objc func connectButtonDidTap() {
        Amplitude.instance().logEvent("click_onboarding_next", withEventProperties: ["onboard_view": "student_type"] )
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
                self.navigationController?.pushViewController(UniversityViewController(), animated: true)
            }
        }
        
    }
    
}
