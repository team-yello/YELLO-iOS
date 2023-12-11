//
//  PushSettingViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/08.
//

import UIKit

import Amplitude

class PushSettingViewController: UIViewController {
    // MARK: - Variables
    // MARK: Component
    let baseView = PushSettingView()
    let userNotiCenter = UNUserNotificationCenter.current()
    
    // MARK: - Function
    // MARK: Life Cycles
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserManager.shared)
        setUI()
    }
    
    // MARK: Layout Helper
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        view.backgroundColor = .black
        
        baseView.pushSettingButton.do {
            $0.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        view.addSubview(baseView)
        baseView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: Custom Function
    // 사용자에게 알림 권한 요청
    func requestAuthNoti() {
        let notiAuthOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        userNotiCenter.requestAuthorization(options: notiAuthOptions) { (success, error) in
            if success {
                // 푸시 알림 권한 허용
                Amplitude.instance().logEvent("click_onboarding_notification")
                Amplitude.instance().setUserProperties(["user_pushnotification": "enable"])
            } else {
                Amplitude.instance().setUserProperties(["user_pushnotification": "disable"])
            }
            if let error = error {
                print(#function, error)
            }
            
        }
    }
    
    // MARK: objc Function
    @objc func tapButton() {
        requestAuthNoti()
        navigationController?.pushViewController(TutorialViewController(), animated: false)
    }

}
