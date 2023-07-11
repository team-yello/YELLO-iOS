//
//  WithdrawalCheckView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class WithdrawalCheckView: BaseView {
    
    let withdrawalNavigationBarView = SettingNavigationBarView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let withdrawalImageView = UIImageView()
    lazy var keepButton = UIButton()
    lazy var backButton = UIButton()
    
    override func setStyle() {
        self.backgroundColor = .black
        
        withdrawalNavigationBarView.do {
            $0.titleLabel.setTextWithLineHeight(text: StringLiterals.Profile.WithdrawalCheck.withdrawal, lineHeight: 24)
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.WithdrawalCheck.title, lineHeight: 24)
            $0.textColor = .white
            $0.font = .uiSubtitle01
        }
        
        descriptionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.WithdrawalCheck.description, lineHeight: 20)
            $0.textColor = .grayscales500
            $0.font = .uiBodySmall
        }
        
        withdrawalImageView.do {
            $0.backgroundColor = .grayscales600
        }
        
        keepButton.do {
            $0.backgroundColor = .clear
            $0.layer.borderColor = UIColor.grayscales700.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 8
            $0.titleLabel?.font = .uiBodyMedium
            $0.setTitleColor(.grayscales500, for: .normal)
            $0.setTitle(StringLiterals.Profile.WithdrawalCheck.keep, for: .normal)
        }
        
        backButton.do {
            $0.backgroundColor = .grayscales800
            $0.layer.cornerRadius = 8
            $0.titleLabel?.font = .uiBodyMedium
            $0.setTitleColor(.yelloMain500, for: .normal)
            $0.setTitle(StringLiterals.Profile.WithdrawalCheck.back, for: .normal)
        }
    }
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        self.addSubviews(withdrawalNavigationBarView,
                         titleLabel,
                         descriptionLabel,
                         withdrawalImageView,
                         keepButton,
                         backButton)
        
        withdrawalNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(withdrawalNavigationBarView.snp.bottom).offset(39.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        withdrawalImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(27.adjusted)
            $0.width.height.equalTo(230)
            $0.centerX.equalToSuperview()
        }
        
        keepButton.snp.makeConstraints {
            $0.bottom.equalTo(backButton.snp.top).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
            $0.height.equalTo(48)
        }
        
        backButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(34.adjusted)
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
            $0.height.equalTo(48)
        }
    }
}
