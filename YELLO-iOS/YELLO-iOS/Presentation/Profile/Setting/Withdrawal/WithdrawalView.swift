//
//  WithdrawalView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class WithdrawalView: BaseView {

    let withdrawalNavigationBarView = SettingNavigationBarView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let firstLabel = UILabel()
    private let firstImageView = UIImageView()
    private let secondLabel = UILabel()
    private let secondImageView = UIImageView()
    private let thirdLabel = UILabel()
    private let thirdImageView = UIImageView()
    private let captionLabel = UILabel()
    lazy var withdrawalButton = UIButton()
    
    override func setStyle() {
        self.backgroundColor = .black
        
        withdrawalNavigationBarView.do {
            $0.titleLabel.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.withdrawal, lineHeight: 24)
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.title, lineHeight: 24)
            $0.font = .uiSubtitle01
            $0.textColor = .white
        }
        
        descriptionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.description, lineHeight: 20)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales500
        }
        
        firstLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.first, lineHeight: 24)
            $0.font = .uiBodyLarge
            $0.textColor = .white
        }
        
        firstImageView.do {
            $0.backgroundColor = .grayscales700
        }
        
        secondLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.second, lineHeight: 24)
            $0.font = .uiBodyLarge
            $0.textColor = .white
        }
        
        secondImageView.do {
            $0.backgroundColor = .grayscales700
        }
        
        thirdLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.third, lineHeight: 24)
            $0.font = .uiBodyLarge
            $0.textColor = .white
        }
        
        thirdImageView.do {
            $0.backgroundColor = .grayscales700
        }
        
        captionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.caption, lineHeight: 15)
            $0.font = .uiLabelMedium
            $0.textColor = .grayscales600
        }
        
        withdrawalButton.do {
            $0.backgroundColor = .clear
            $0.layer.borderColor = UIColor.grayscales700.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 8
            $0.titleLabel?.font = .uiBodyMedium
            $0.setTitleColor(.semanticStatusRed500, for: .normal)
            $0.setTitle(StringLiterals.Profile.Withdrawal.confirm, for: .normal)
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
                         firstLabel,
                         firstImageView,
                         secondLabel,
                         secondImageView,
                         thirdLabel,
                         thirdImageView,
                         captionLabel,
                         withdrawalButton)
        
        withdrawalNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(withdrawalNavigationBarView.snp.bottom).offset(40.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        firstLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        firstImageView.snp.makeConstraints {
            $0.top.equalTo(firstLabel.snp.bottom).offset(6.adjusted)
            $0.width.equalTo(276)
            $0.height.equalTo(118)
            $0.centerX.equalToSuperview()
        }
        
        secondLabel.snp.makeConstraints {
            $0.top.equalTo(firstImageView.snp.bottom).offset(40.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        secondImageView.snp.makeConstraints {
            $0.top.equalTo(secondLabel.snp.bottom).offset(6.adjusted)
            $0.width.equalTo(276)
            $0.height.equalTo(118)
            $0.centerX.equalToSuperview()
        }
        
        thirdLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        thirdImageView.snp.makeConstraints {
            $0.top.equalTo(thirdLabel.snp.bottom).offset(6.adjusted)
            $0.width.equalTo(276)
            $0.height.equalTo(118)
            $0.centerX.equalToSuperview()
        }
        
        captionLabel.snp.makeConstraints {
            $0.top.equalTo(thirdImageView.snp.bottom).offset(43)
            $0.centerX.equalToSuperview()
        }
        
        withdrawalButton.snp.makeConstraints {
            $0.top.equalTo(captionLabel.snp.bottom).inset(24.adjusted)
            $0.bottom.equalToSuperview().inset(34.adjusted)
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
            $0.height.equalTo(48)
        }
    }
}
