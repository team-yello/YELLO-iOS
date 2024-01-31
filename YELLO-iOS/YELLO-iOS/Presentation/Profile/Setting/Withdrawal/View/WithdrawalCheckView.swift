//
//  WithdrawalCheckView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import Amplitude
import SnapKit
import Then

final class WithdrawalCheckView: BaseView {
    
    // MARK: - Variables
    let withdrawalNavigationBarView = SettingNavigationBarView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let withdrawalImageView = UIImageView()
    
    private let captionLabel = UILabel()
    lazy var withdrawalButton = UIButton(frame: CGRect(x: 0, y: 0, width: 343.adjustedWidth, height: 48.adjustedHeight))
    
    private var withdrawalAlertView: WithdrawalAlertView?

    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        withdrawalAlertView = WithdrawalAlertView()
        self.backgroundColor = .black
        
        withdrawalNavigationBarView.do {
            $0.titleLabel.setTextWithLineHeight(text: StringLiterals.Profile.WithdrawalCheck.withdrawal, lineHeight: 24.adjustedHeight)
        }
        
        titleLabel.do {
            $0.text = StringLiterals.Profile.WithdrawalCheck.title
            $0.textColor = .white
            $0.font = .uiHeadline00
        }
        
        descriptionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.WithdrawalCheck.description, lineHeight: 20.adjustedHeight)
            $0.textColor = .grayscales500
            $0.font = .uiBodySmall
        }
        
        withdrawalImageView.do {
            $0.image = ImageLiterals.Withdrawal.imgWithdrawalCheck
            $0.contentMode = .scaleAspectFit
        }
        
        captionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.WithdrawalCheck.caption, lineHeight: 15.adjustedHeight)
            $0.font = .uiLabelMedium
            $0.textColor = .grayscales600
            $0.numberOfLines = 0
        }
        
        withdrawalButton.do {
            $0.backgroundColor = .clear
            $0.layer.borderColor = UIColor.grayscales700.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 24.adjustedHeight
            $0.titleLabel?.font = .uiBodyMedium
            $0.setTitleColor(.semanticStatusRed500, for: .normal)
            $0.setTitle(StringLiterals.Profile.WithdrawalCheck.confirm, for: .normal)
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
                         captionLabel,
                         withdrawalButton)
        
        withdrawalNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(withdrawalNavigationBarView.snp.bottom).offset(39.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        withdrawalImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(27.adjustedHeight)
            $0.width.equalTo(260.adjustedWidth)
            $0.height.equalTo(246.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        captionLabel.snp.makeConstraints {
            $0.top.equalTo(withdrawalImageView.snp.bottom).offset(50.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        withdrawalButton.snp.makeConstraints {
            $0.top.equalTo(captionLabel.snp.bottom).offset(36.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(48.adjustedHeight)
            $0.width.equalTo(343.adjustedWidth)
        }
    }
}
