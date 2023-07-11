//
//  ProfileSettingViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class ProfileSettingViewController: UIViewController {
    
    private let profileSettingView = ProfileSettingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

extension ProfileSettingViewController {
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        
        view.backgroundColor = .black
        profileSettingView.settingNavigationBarView.handleBackButtonDelegate = self
        profileSettingView.handleWithdrawalButtonDelegate = self
    }
    
    private func setLayout() {
        view.addSubview(profileSettingView)
        
        profileSettingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ProfileSettingViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension ProfileSettingViewController: HandleWithdrawalButtonDelegate {
    func withdrawalButtonTapped() {
        let withdrawalCheckViewController = WithdrawalCheckViewController()
        navigationController?.pushViewController(withdrawalCheckViewController, animated: true)
    }
}