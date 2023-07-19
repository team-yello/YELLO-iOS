//
//  ProfileSettingViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then
import KakaoSDKUser

final class ProfileSettingViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Property
    private let profileSettingView = ProfileSettingView()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        
        view.backgroundColor = .black
        profileSettingView.settingNavigationBarView.handleBackButtonDelegate = self
        profileSettingView.handleWithdrawalButtonDelegate = self
        profileSettingView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    override func setLayout() {
        view.addSubview(profileSettingView)
        
        profileSettingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: HandleBackButtonDelegate
extension ProfileSettingViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: HandleWithdrawalButtonDelegate
extension ProfileSettingViewController: HandleWithdrawalButtonDelegate {
    func withdrawalButtonTapped() {
        let withdrawalCheckViewController = WithdrawalCheckViewController()
        navigationController?.pushViewController(withdrawalCheckViewController, animated: true)
    }
    
    @objc private func logoutButtonTapped() {
        // 로그아웃 로직 구현
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            } else {
                print("logout() success.")
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                
                UserDefaults.standard.removeObject(forKey: "isLoggined")
               sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: KakaoLoginViewController())
                
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        }
    }
}
