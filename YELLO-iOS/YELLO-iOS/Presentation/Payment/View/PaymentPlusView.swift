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
    
    let subscribeView = UIView(frame: .init(x: 0, y: 0, width: 78.adjustedWidth, height: 30.adjustedHeight))
    let subscribeBackgroundView = UIView(frame: .init(x: 0, y: 0, width: 80.adjustedWidth, height: 32.adjustedHeight))
    let subscribeImageView = UIImageView()
    let subscribeLabel = UILabel()
    
    let nameKeyLabel = UILabel()
    let nameKeyButtonStackView = UIStackView()
    
    lazy var nameKeyOneButton = PaymentNameKeyButton(state: .one)
    lazy var nameKeyTwoButton = PaymentNameKeyButton(state: .two)
    lazy var nameKeyFiveButton = PaymentNameKeyButton(state: .five)
    
    let pointButtonStackView = UIStackView()
    lazy var votingPointButton = PointButton(reward: .voting)
    lazy var adPointButton = PointButton(reward: .ad)
    
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
        
        subscribeBackgroundView.do {
            $0.makeCornerRound(radius: 16.adjustedHeight)
            $0.applyGradientBackground(topColor: UIColor(hex: "D96AFF"), bottomColor: UIColor(hex: "7C57FF"), startPointY: 0.5, endPointY: 0.5)
            $0.layer.cornerCurve = .continuous
        }
        
        subscribeView.do {
            $0.backgroundColor = .grayscales900
            $0.makeCornerRound(radius: 15.adjustedHeight)
        }
        
        subscribeLabel.do {
            $0.textColor = .white
            $0.font = .uiBodySmall
            $0.text = StringLiterals.MyYello.Payment.subscribing
        }
        
        subscribeImageView.do {
            $0.image = ImageLiterals.Profile.icProfileStar
        }
        
        nameKeyLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Payment.sale + "\n" + StringLiterals.MyYello.Payment.paymentSender, lineHeight: 24.adjustedHeight)
            $0.textAlignment = .left
            $0.font = .uiHeadline03
            $0.textColor = .white
            $0.asCustomFont(targetString: StringLiterals.MyYello.Payment.sale, color: .yelloMain500, font: .uiHeadline03)
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
        
        nameKeyButtonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 10.adjustedWidth
            $0.alignment = .center
            $0.addArrangedSubviews(nameKeyOneButton, nameKeyTwoButton, nameKeyFiveButton)
        }
        
        pointButtonStackView.do {
            $0.axis = .vertical
            $0.spacing = 10.adjustedHeight
            $0.addArrangedSubviews(votingPointButton, adPointButton)
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
                               subscribeBackgroundView,
                               nameKeyLabel,
                               nameKeyButtonStackView,
                               pointButtonStackView,
                               descriptionLabel,
                               descriptionStackView
        )
        subscribeBackgroundView.addSubview(subscribeView)
        subscribeView.addSubviews(subscribeImageView, subscribeLabel)
        
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
            $0.height.equalTo(228.adjustedHeight)
        }
        
        paymentYelloPlusButton.snp.makeConstraints {
            $0.top.equalTo(paymentView.snp.bottom).offset(12.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(78.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.width.equalTo(343.adjustedWidth)
        }
        
        subscribeBackgroundView.snp.makeConstraints {
            $0.height.equalTo(32.adjustedHeight)
            $0.width.equalTo(80.adjustedWidth)
            
            $0.top.equalTo(paymentYelloPlusButton.snp.bottom).offset(8.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        subscribeView.snp.makeConstraints {
            $0.height.equalTo(30.adjustedHeight)
            $0.width.equalTo(78.adjustedWidth)
            
            $0.center.equalToSuperview()
        }
        
        subscribeImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10.adjustedWidth)
        }
        
        subscribeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(subscribeImageView.snp.trailing).offset(4.adjustedWidth)
        }
        
        nameKeyLabel.snp.makeConstraints {
            $0.top.equalTo(paymentYelloPlusButton.snp.bottom).offset(63.adjustedHeight)
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
        }
        
        nameKeyButtonStackView.snp.makeConstraints {
            $0.top.equalTo(nameKeyLabel.snp.bottom).offset(16.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
        }
        
        pointButtonStackView.snp.makeConstraints {
            $0.top.equalTo(nameKeyButtonStackView.snp.bottom).offset(12.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(pointButtonStackView.snp.bottom).offset(112.adjustedHeight)
            $0.leading.equalToSuperview().offset(18.adjustedWidth)
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
