//
//  ProfileSettingView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import Amplitude
import SnapKit
import Then

// MARK: - Protocol
protocol HandleWithdrawalButtonDelegate: AnyObject {
    func withdrawalButtonTapped()
}

final class ProfileSettingView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    weak var handleWithdrawalButtonDelegate: HandleWithdrawalButtonDelegate?
    
    // MARK: Component
    let settingNavigationBarView = SettingNavigationBarView()
    lazy var centerButton = SettingCustomButton()
    lazy var privacyButton = SettingCustomButton()
    lazy var serviceButton = SettingCustomButton()
    lazy var logoutButton = SettingCustomButton()
    let versionLabel = UILabel()
    lazy var withdrawalButton = UIButton()
    let currentProjectVersion = AppStoreCheck.appVersion ?? ""
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black
        
        centerButton.do {
            $0.updateTitle(text: StringLiterals.Profile.Setting.center)
            $0.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        }
        
        privacyButton.do {
            $0.updateTitle(text: StringLiterals.Profile.Setting.privacy)
            $0.addTarget(self, action: #selector(privacyButtonTapped), for: .touchUpInside)
        }
        
        serviceButton.do {
            $0.updateTitle(text: StringLiterals.Profile.Setting.service)
            $0.addTarget(self, action: #selector(serviceButtonTapped), for: .touchUpInside)
        }
        
        logoutButton.do {
            $0.updateTitle(text: StringLiterals.Profile.Setting.logout)
        }
        
        versionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Setting.version + currentProjectVersion, lineHeight: 20.adjustedHeight)
            $0.textColor = .grayscales600
            $0.font = .uiBody02
        }
        
        withdrawalButton.do {
            $0.setTitle(StringLiterals.Profile.Setting.withdrawal, for: .normal)
            $0.setTitleColor(.grayscales600, for: .normal)
            $0.titleLabel?.font = .uiBody02
            $0.addTarget(self, action: #selector(withdrawalButtonTapped), for: .touchUpInside)
        }
    }

    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
                    .compactMap { $0 as? UIWindowScene }
                    .first?
                    .statusBarManager?
                    .statusBarFrame.height ?? 20
        
        self.addSubviews(settingNavigationBarView,
                         centerButton,
                         privacyButton,
                         serviceButton,
                         logoutButton,
                         versionLabel,
                         withdrawalButton)
        
        settingNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        centerButton.snp.makeConstraints {
            $0.top.equalTo(settingNavigationBarView.snp.bottom).offset(12.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(56.adjustedHeight)
        }
        
        privacyButton.snp.makeConstraints {
            $0.top.equalTo(centerButton.snp.bottom).offset(4.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(56.adjustedHeight)
        }
        
        serviceButton.snp.makeConstraints {
            $0.top.equalTo(privacyButton.snp.bottom).offset(4.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(56.adjustedHeight)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(serviceButton.snp.bottom).offset(4.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(56.adjustedHeight)
        }
        
        versionLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(27.adjustedHeight)
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
        }
        
        withdrawalButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20.adjustedHeight)
            $0.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.width.equalTo(49.adjustedWidth)
            $0.height.equalTo(36.adjustedHeight)
        }
    }
    
    // MARK: Objc Function
    @objc private func withdrawalButtonTapped() {
        Amplitude.instance().logEvent("click_profile_withdrawal", withEventProperties: ["withdrawal_button":"withdrawal1"])
        handleWithdrawalButtonDelegate?.withdrawalButtonTapped()
    }
    
    @objc private func centerButtonTapped() {
        // 고객센터 링크 연결
        let url = URL(string: "http://pf.kakao.com/_pcFzG/chat")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc private func privacyButtonTapped() {
        // 개인정보 처리방침 링크 연결
        let url = URL(string: "https://yell0.notion.site/97f57eaed6c749bbb134c7e8dc81ab3f")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
        
    @objc private func serviceButtonTapped() {
        // 이용약관 링크 연결
        let url = URL(string: "https://yell0.notion.site/2afc2a1e60774dfdb47c4d459f01b1d9")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
