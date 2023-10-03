//
//  KakaoConnectViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/15.
//

import UIKit

import Amplitude
import KakaoSDKUser
import KakaoSDKTalk

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
        baseView.privacyButton.addTarget(self, action: #selector(privacyButtonDidTap), for: .touchUpInside)
    }
    
    @objc func connectButtonDidTap() {
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
                self.navigationController?.pushViewController(SchoolSelectViewController(), animated: true)
            }
        }
        
    }
    
    @objc func privacyButtonDidTap() {
        guard let url = URL(string: "https://yell0.notion.site/97f57eaed6c749bbb134c7e8dc81ab3f") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
