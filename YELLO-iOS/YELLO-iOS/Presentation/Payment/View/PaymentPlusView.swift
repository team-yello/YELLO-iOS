//
//  PaymentPlusView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/10.
//

import UIKit

import SnapKit
import Then

final class PaymentPlusView: BaseView {
    
    let scrollView = UIScrollView()
    let paymentNavigationBarView = PaymentNavigationBarView(frame: CGRect(x: 0, y: 0, width: 343.adjustedWidth, height: 48.adjustedHeight))
    let paymentLabel = UILabel()
    let paymentView = PaymentView()
    lazy var paymentYelloPlusButton = PaymentYelloPlusButton()
    let nameKeyLabel = UILabel()
    
    lazy var nameKeyOneButton = PaymentNameKeyButton(state: .one)
    lazy var nameKeyTwoButton = PaymentNameKeyButton(state: .two)
    lazy var nameKeyFiveButton = PaymentNameKeyButton(state: .five)
    
    let descriptionLabel = UILabel()
    let descriptionStackView = UIStackView()
    let serviceButton = UIButton()
    let seperateLine = UIView()
    let privacyButton = UIButton()

    override func setStyle() {
        self.backgroundColor = .black
        
        scrollView.do {
            $0.isScrollEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
        }
        
        paymentLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Payment.yelloPlusTitle, lineHeight: 28.adjustedHeight)
            $0.font = .uiHeadline03
            $0.textColor = .white
        }
        
        nameKeyLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Payment.paymentSender, lineHeight: 24.adjustedHeight)
            $0.font = .uiSubtitle01
            $0.textColor = .white
        }
        
        nameKeyOneButton.do {
            $0.makeShadow(radius: 8, color: UIColor(hex: "6437FF", alpha: 0.25), offset: CGSize(width: 0, height: 0), opacity: 0.25)
        }
        
        nameKeyTwoButton.do {
            $0.makeShadow(radius: 8, color: UIColor(hex: "6437FF", alpha: 0.25), offset: CGSize(width: 0, height: 0), opacity: 0.25)
        }
        
        nameKeyFiveButton.do {
            $0.makeShadow(radius: 8, color: UIColor(hex: "6437FF", alpha: 0.25), offset: CGSize(width: 0, height: 0), opacity: 0.25)
        }
        
        descriptionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Payment.descriptionLabel, lineHeight: 16.adjustedHeight)
            $0.font = .uiLabelLarge
            $0.asFont(targetString: "옐로플러스 구독안내", font: .uiBody05)
            $0.numberOfLines = 3
            $0.textAlignment = .left
            $0.textColor = .grayscales300
        }
        
        serviceButton.do {
            $0.setTitle(StringLiterals.MyYello.Payment.serviceButton, for: .normal)
            $0.titleLabel?.font = .uiLabelMedium
            $0.titleLabel?.textColor = .white
        }
        
        seperateLine.do {
            $0.backgroundColor = .grayscales500
        }
        
        privacyButton.do {
            $0.setTitle(StringLiterals.MyYello.Payment.privacyButton, for: .normal)
            $0.titleLabel?.font = .uiLabelMedium
            $0.setTitleColor(.white, for: .normal)
        }
        
        descriptionStackView.do {
            $0.axis = .horizontal
            $0.spacing = 6.adjustedWidth
            $0.addArrangedSubviews(serviceButton, seperateLine, privacyButton)
            $0.alignment = .center
        }
    }
    
    override func setLayout() {
        
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        self.addSubviews(paymentNavigationBarView,
                         scrollView)
        
        scrollView.addSubviews(paymentLabel,
                               paymentView,
                               paymentYelloPlusButton,
                               nameKeyLabel,
                               nameKeyOneButton,
                               nameKeyTwoButton,
                               nameKeyFiveButton,
                               descriptionLabel,
                               descriptionStackView
        )
        
        paymentNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(paymentNavigationBarView.snp.bottom)
            $0.leading.trailing.bottom.width.equalToSuperview()
        }
        
        paymentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10.adjustedHeight)
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
        }
        
        paymentView.snp.makeConstraints {
            $0.top.equalTo(paymentLabel.snp.bottom).offset(16.adjustedHeight)
            $0.leading.trailing.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(228)
        }
        
        paymentYelloPlusButton.snp.makeConstraints {
            $0.top.equalTo(paymentView.snp.bottom).offset(12.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(78.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.width.equalTo(343.adjustedWidth)
        }
        
        nameKeyLabel.snp.makeConstraints {
            $0.top.equalTo(paymentYelloPlusButton.snp.bottom).offset(34.adjustedHeight)
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
        }
        
        nameKeyOneButton.snp.makeConstraints {
            $0.top.equalTo(nameKeyLabel.snp.bottom).offset(12.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        nameKeyTwoButton.snp.makeConstraints {
            $0.top.equalTo(nameKeyOneButton.snp.bottom).offset(10.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        nameKeyFiveButton.snp.makeConstraints {
            $0.top.equalTo(nameKeyTwoButton.snp.bottom).offset(10.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameKeyFiveButton.snp.bottom).offset(36.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        descriptionStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(26.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(58.adjustedHeight)
            $0.width.equalTo(162.adjustedWidth)
            $0.height.equalTo(15.adjustedHeight)
        }
        
        seperateLine.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4.adjustedHeight)
            $0.width.equalTo(1.adjustedWidth)
        }
    }
}
