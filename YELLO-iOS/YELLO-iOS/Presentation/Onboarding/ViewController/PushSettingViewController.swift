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
    
    
    // MARK: - Function
    // MARK: Life Cycles
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(User.shared)
        setUI()
    }
    
    // MARK: Layout Helper
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
    
    // MARK: Custom Function
    // 사용자에게 알림 권한 요청
    func requestAuthNoti() {
        let notiAuthOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        userNotiCenter.requestAuthorization(options: notiAuthOptions) { (success, error) in
            if let error = error {
                print(#function, error)
            }
        }
        
        /// 알림 설정 시 추가 포인트 지급 -> 설정 여부 저장
    }
    
    // MARK: objc Function
    @objc func tapButton() {
        requestAuthNoti()
        navigationController?.pushViewController(onboardingEndViewController, animated: true)
    }

}
