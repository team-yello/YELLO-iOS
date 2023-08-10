//
//  PushSettingViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/08.
//

import UIKit

class PushSettingViewController: UIViewController {
    // MARK: - Variables
    // MARK: Component (button, label 등 코드로 만들때)
    let baseView = PushSettingView()
    let onboardingEndViewController = OnboardingEndViewController()
    let userNotiCenter = UNUserNotificationCenter.current()
    
    // MARK: Life Cycles
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(User.shared)
        setUI()
    }
    
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        view.backgroundColor = .black
        baseView.do {
            $0.goToYelloButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        view.addSubview(baseView)
        baseView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // 사용자에게 알림 권한 요청
    func requestAuthNoti() {
        let notiAuthOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        userNotiCenter.requestAuthorization(options: notiAuthOptions) { (success, error) in
            if let error = error {
                print(#function, error)
            }
        }
    }
    
    @objc func tapButton() {
        requestAuthNoti()
        navigationController?.pushViewController(onboardingEndViewController, animated: true)
    }

}