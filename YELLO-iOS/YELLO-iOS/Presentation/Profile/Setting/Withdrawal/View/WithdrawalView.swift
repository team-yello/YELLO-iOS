//
//  WithdrawalView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import Amplitude
import SnapKit
import Then

// MARK: - Protocol
protocol HandleKeepButtonDelegate: AnyObject {
    func keepButtonTapped()
}

final class WithdrawalView: BaseView {

    // MARK: - Variables
    // MARK: Component
    weak var handleKeepButtonDelegate: HandleKeepButtonDelegate?
    weak var handleBackButtonDelegate: HandleBackButtonDelegate?
    
    // MARK: Property
    let withdrawalNavigationBarView = SettingNavigationBarView()
    let scrollView = UIScrollView()
    private let warningImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let warningView = UIView()
    private let warningTitle = UILabel()
    private let warningPointImageView = UIImageView()
    private let warningDescription = UILabel()
    
    private let moreView = UIView()
    private let firstLabel = UILabel()
    private let firstImageView = UIImageView()
    private let secondLabel = UILabel()
    private let secondImageView = UIImageView()
    private let thirdLabel = UILabel()
    private let thirdImageView = UIImageView()
    
    lazy var keepButton = UIButton(frame: CGRect(x: 0, y: 0, width: 343.adjustedWidth, height: 48.adjustedHeight))
    lazy var backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 343.adjustedWidth, height: 48.adjustedHeight))
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black
        
        scrollView.do {
            $0.isScrollEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
        }
        
        withdrawalNavigationBarView.do {
            $0.titleLabel.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.withdrawal, lineHeight: 24.adjustedHeight)
        }
        
        warningImageView.do {
            $0.image = ImageLiterals.Withdrawal.imgWarning
            $0.contentMode = .scaleAspectFit
        }
        
        titleLabel.do {
            $0.text = StringLiterals.Profile.Withdrawal.title
            $0.font = .uiHeadline00
            $0.textColor = .yelloMain500
        }
        
        descriptionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.description, lineHeight: 20.adjustedHeight)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales500
        }
        
        warningView.do {
            $0.backgroundColor = .grayscales900
            $0.makeCornerRound(radius: 12.adjustedHeight)
        }
        
        warningTitle.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.warningTitle, lineHeight: 24.adjustedHeight)
            $0.font = .uiSubtitle01
            $0.textColor = .white
        }
        
        warningPointImageView.do {
            $0.image = ImageLiterals.Withdrawal.imgWithdrawalPoint
            $0.contentMode = .scaleAspectFit
        }
        
        warningDescription.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.warningDescription, lineHeight: 15.adjustedHeight)
            $0.font = .uiLabelMedium
            $0.textColor = .white
        }
        
        moreView.do {
            $0.backgroundColor = .grayscales900
            $0.makeCornerRound(radius: 12.adjustedHeight)
        }
        
        firstLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.first, lineHeight: 24.adjustedHeight)
            $0.font = .uiSubtitle01
            $0.textColor = .white
        }
        
        firstImageView.do {
            $0.image = ImageLiterals.Withdrawal.imgWithdrawalFirst
            $0.contentMode = .scaleAspectFit
        }
        
        secondLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.second, lineHeight: 24.adjustedHeight)
            $0.font = .uiSubtitle01
            $0.textColor = .white
        }
        
        secondImageView.do {
            $0.image = ImageLiterals.Withdrawal.imgWithdrawalSecond
            $0.contentMode = .scaleAspectFit
        }
        
        thirdLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Withdrawal.third, lineHeight: 24.adjustedHeight)
            $0.font = .uiSubtitle01
            $0.textColor = .white
        }
        
        thirdImageView.do {
            $0.image = ImageLiterals.Withdrawal.imgWithdrawalThird
            $0.contentMode = .scaleAspectFit
        }
        
        keepButton.do {
            $0.backgroundColor = .clear
            $0.layer.borderColor = UIColor.grayscales700.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 24.adjustedHeight
            $0.titleLabel?.font = .uiBodyMedium
            $0.setTitleColor(.grayscales500, for: .normal)
            $0.setTitle(StringLiterals.Profile.Withdrawal.keep, for: .normal)
            $0.addTarget(self, action: #selector(keepButtonTapped), for: .touchUpInside)
        }
        
        backButton.do {
            $0.backgroundColor = .grayscales800
            $0.layer.cornerRadius = 24.adjustedHeight
            $0.titleLabel?.font = .uiBodyMedium
            $0.setTitleColor(.yelloMain500, for: .normal)
            $0.setTitle(StringLiterals.Profile.Withdrawal.back, for: .normal)
            $0.addTarget(self, action: #selector(popView), for: .touchUpInside)
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
        
        scrollView.addSubviews(warningImageView,
                               titleLabel,
                               descriptionLabel,
                               warningView,
                               moreView,
                               keepButton,
                               backButton)
        
        warningView.addSubviews(warningTitle,
                                warningPointImageView,
                                warningDescription)
        
        moreView.addSubviews(firstLabel,
                             firstImageView,
                             secondLabel,
                             secondImageView,
                             thirdLabel,
                             thirdImageView)
        
        withdrawalNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(withdrawalNavigationBarView.snp.bottom)
            $0.leading.trailing.bottom.width.equalToSuperview()
        }
        
        warningImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(warningImageView.snp.bottom).offset(10.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(9.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        warningView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(40.adjustedHeight)
            $0.height.equalTo(174.adjustedHeight)
            $0.width.equalTo(343.adjustedWidth)
            $0.centerX.equalToSuperview()
        }
        
        warningTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        warningPointImageView.snp.makeConstraints {
            $0.top.equalTo(warningTitle.snp.bottom).offset(18.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(38.adjustedHeight)
        }
        
        warningDescription.snp.makeConstraints {
            $0.top.equalTo(warningPointImageView.snp.bottom).offset(12.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        moreView.snp.makeConstraints {
            $0.top.equalTo(warningView.snp.bottom).offset(20.adjustedHeight)
            $0.height.equalTo(551.adjustedHeight)
            $0.width.equalTo(343.adjustedWidth)
            $0.centerX.equalToSuperview()
        }
        
        firstLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(36.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        firstImageView.snp.makeConstraints {
            $0.top.equalTo(firstLabel.snp.bottom).offset(12.adjustedHeight)
            $0.width.equalTo(252.adjustedWidth)
            $0.height.equalTo(51.adjustedWidth)
            $0.centerX.equalToSuperview()
        }
        
        secondLabel.snp.makeConstraints {
            $0.top.equalTo(firstImageView.snp.bottom).offset(50.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        secondImageView.snp.makeConstraints {
            $0.top.equalTo(secondLabel.snp.bottom).offset(12.adjustedHeight)
            $0.width.equalTo(252.adjustedWidth)
            $0.height.equalTo(95.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        thirdLabel.snp.makeConstraints {
            $0.top.equalTo(secondImageView.snp.bottom).offset(60.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        thirdImageView.snp.makeConstraints {
            $0.top.equalTo(thirdLabel.snp.bottom).offset(10.adjustedHeight)
            $0.width.equalTo(252.adjustedWidth)
            $0.height.equalTo(69.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        keepButton.snp.makeConstraints {
            $0.top.equalTo(moreView.snp.bottom).offset(60.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(48.adjustedHeight)
            $0.width.equalTo(343.adjustedWidth)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(keepButton.snp.bottom).offset(8.adjustedHeight)
            $0.bottom.equalToSuperview().inset(34.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(48.adjustedHeight)
            $0.width.equalTo(343.adjustedWidth)
        }
    }
    
    @objc private func keepButtonTapped() {
        Amplitude.instance().logEvent("click_profile_withdrawal", withEventProperties: ["withdrawal_button":"withdrawal2"])
        handleKeepButtonDelegate?.keepButtonTapped()
    }
    
    @objc private func popView() {
        handleBackButtonDelegate?.popView()
    }
}
