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

    // MARK: - Variables
    // MARK: Property
    let withdrawalNavigationBarView = SettingNavigationBarView()
    let scrollView = UIScrollView()
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
    
    private var withdrawalAlertView: WithdrawalAlertView?
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        withdrawalAlertView = WithdrawalAlertView()
        self.backgroundColor = .black
        
        scrollView.do {
            $0.isScrollEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
        }
        
        withdrawalNavigationBarView.do {
            $0.titleLabel.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.withdrawal, lineHeight: 24.adjustedHeight)
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.title, lineHeight: 24.adjustedHeight)
            $0.font = .uiSubtitle01
            $0.textColor = .white
        }
        
        descriptionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.description, lineHeight: 20.adjustedHeight)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales500
        }
        
        firstLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.first, lineHeight: 24.adjustedHeight)
            $0.font = .uiBodyLarge
            $0.textColor = .white
        }
        
        firstImageView.do {
            $0.image = ImageLiterals.Withdrawal.imgWithdrawalFirst
        }
        
        secondLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.second, lineHeight: 24.adjustedHeight)
            $0.font = .uiBodyLarge
            $0.textColor = .white
        }
        
        secondImageView.do {
            $0.image = ImageLiterals.Withdrawal.imgWithdrawalSecond
        }
        
        thirdLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.third, lineHeight: 24.adjustedHeight)
            $0.font = .uiBodyLarge
            $0.textColor = .white
        }
        
        thirdImageView.do {
            $0.image = ImageLiterals.Withdrawal.imgWithdrawalThird
        }
        
        captionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.caption, lineHeight: 15.adjustedHeight)
            $0.font = .uiLabelMedium
            $0.textColor = .grayscales600
            $0.numberOfLines = 3
        }
        
        withdrawalButton.do {
            $0.backgroundColor = .clear
            $0.layer.borderColor = UIColor.grayscales700.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 8
            $0.titleLabel?.font = .uiBodyMedium
            $0.setTitleColor(.semanticStatusRed500, for: .normal)
            $0.setTitle(StringLiterals.Profile.Withdrawal.confirm, for: .normal)
            $0.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        self.addSubviews(withdrawalNavigationBarView,
                         scrollView)
        
        scrollView.addSubviews(titleLabel,
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
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(withdrawalNavigationBarView.snp.bottom)
            $0.leading.trailing.bottom.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        firstLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(72.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        firstImageView.snp.makeConstraints {
            $0.top.equalTo(firstLabel.snp.bottom).offset(6.adjustedHeight)
            $0.width.equalTo(252)
            $0.height.equalTo(51)
            $0.centerX.equalToSuperview()
        }
        
        secondLabel.snp.makeConstraints {
            $0.top.equalTo(firstImageView.snp.bottom).offset(50.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        secondImageView.snp.makeConstraints {
            $0.top.equalTo(secondLabel.snp.bottom).offset(6.adjustedHeight)
            $0.width.equalTo(252)
            $0.height.equalTo(95)
            $0.centerX.equalToSuperview()
        }
        
        thirdLabel.snp.makeConstraints {
            $0.top.equalTo(secondImageView.snp.bottom).offset(50.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        thirdImageView.snp.makeConstraints {
            $0.top.equalTo(thirdLabel.snp.bottom).offset(6.adjustedHeight)
            $0.width.equalTo(252)
            $0.height.equalTo(69)
            $0.centerX.equalToSuperview()
        }
        
        captionLabel.snp.makeConstraints {
            $0.top.equalTo(thirdImageView.snp.bottom).offset(80.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        withdrawalButton.snp.makeConstraints {
            $0.top.equalTo(captionLabel.snp.bottom).offset(24.adjustedHeight)
            $0.bottom.equalToSuperview().inset(34.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(48.adjustedHeight)
        }
    }
    
    // MARK: Objc Function
    @objc func showAlert() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        if let withdrawalAlertView = withdrawalAlertView {
            withdrawalAlertView.removeFromSuperview()
        }
        
        withdrawalAlertView = WithdrawalAlertView()
        withdrawalAlertView?.frame = viewController.view.bounds
        withdrawalAlertView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.view.addSubview(withdrawalAlertView!)
        
    }
}
