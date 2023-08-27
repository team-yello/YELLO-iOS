//
//  SubscriptionView.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/08/26.
//

import UIKit

import SnapKit
import Then

final class SubscriptionExtensionView: BaseView {
        
    let contentsView = UIView()

    // 컴포넌트 위치 순서대로
    let closeButton = UIButton()
    private let titleLabel = UILabel()
    private let dateOfTermination = UILabel()
    private let dateOfTerminationLabel = UILabel()
    private let unsubscribeLabel = UILabel()
    private let benefitImage = UIImageView()
    private let benefitLabel = UILabel()
    let subscriptionImage = UIImageView()
    let subscriptionButton = UIView()

    override func setStyle() {
        self.backgroundColor = .black.withAlphaComponent(0.5)

        contentsView.backgroundColor = .black
        
        closeButton.do {
            $0.setImage(ImageLiterals.SubscriptionExtension.icExit, for: .normal)
            $0.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        }
        
        titleLabel.do {
            $0.text = StringLiterals.SubscriptionExtension.titleLabel
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 32.adjusted)
            $0.textColor = .white
            $0.font = .uiHeadline01
            $0.textAlignment = .left
            $0.numberOfLines = 2
        }
        
        dateOfTermination.do {
            let today = Date()
            var dayComponent = DateComponents()
            dayComponent.day = 1  // 내일을 의미하므로 1을 추가

            if let tomorrow = Calendar.current.date(byAdding: dayComponent, to: today) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"  // 원하는 형식 설정
                let dateString = dateFormatter.string(from: tomorrow)
                $0.text = dateString
                print(dateString)
            }
            
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 24.adjusted)
            $0.textColor = .white
            $0.font = .uiSubtitle01
        }
        
        dateOfTerminationLabel.do {
            $0.text = StringLiterals.SubscriptionExtension.dateOfTerminationLabel
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 24.adjusted)
            $0.textColor = .white
            $0.font = .uiSubtitle01
        }
        
        unsubscribeLabel.do {
            $0.text = StringLiterals.SubscriptionExtension.unsubscribeLabel
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 24.adjusted)
            $0.textColor = .white
            $0.font = .uiSubtitle01
        }
        
        benefitImage.do {
            $0.image = ImageLiterals.SubscriptionExtension.imgBenefit
        }
        
        benefitLabel.do {
            $0.text = StringLiterals.SubscriptionExtension.benefitLabel
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 24.adjusted)
            $0.textColor = .white
            $0.font = .uiSubtitle01
            $0.textAlignment = .left
            $0.numberOfLines = 5
        }
        
        subscriptionButton.do {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(subscriptionButtonClicked))
            $0.addGestureRecognizer(tapGestureRecognizer)
        }
        
        subscriptionImage.do {
            $0.image = ImageLiterals.SubscriptionExtension.btnSubscriptionExtension
        }
    }
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        self.addSubview(contentsView)
        contentsView.addSubviews(closeButton,
                                 titleLabel,
                                 dateOfTermination,
                                 dateOfTerminationLabel,
                                 unsubscribeLabel,
                                 benefitImage,
                                 benefitLabel,
                                 subscriptionButton)
        
        subscriptionButton.addSubview(subscriptionImage)
       
        contentsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(statusBarHeight + 26.adjustedHeight)
            $0.trailing.equalToSuperview().inset(12.adjusted)
            $0.size.equalTo(40.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(statusBarHeight + 34.adjustedHeight)
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
        
        dateOfTermination.snp.makeConstraints {
            $0.top.equalToSuperview().inset(statusBarHeight + 128.adjustedHeight)
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
        
        dateOfTerminationLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateOfTermination)
            $0.leading.equalTo(dateOfTermination.snp.trailing).offset(4.adjusted)
        }
        
        unsubscribeLabel.snp.makeConstraints {
            $0.top.equalTo(dateOfTermination.snp.bottom)
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
        
        benefitImage.snp.makeConstraints {
            $0.top.equalTo(unsubscribeLabel.snp.bottom).offset(22.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
            $0.height.equalTo(160.adjusted)
        }
        
        benefitLabel.snp.makeConstraints {
            $0.top.equalTo(benefitImage.snp.bottom).offset(14.adjustedHeight)
            $0.leading.equalToSuperview().inset(16.adjusted)
            $0.trailing.equalToSuperview().inset(90.adjusted)
        }
        
        subscriptionButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(62.adjusted)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(51.adjustedHeight)
        }
        
        subscriptionImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SubscriptionExtensionView {
    @objc
    func closeButtonClicked() {
        self.isHidden = true
        self.removeFromSuperview()
    }
    
    @objc
    func subscriptionButtonClicked() {
        
        NotificationCenter.default.post(name: Notification.Name("goToShop"), object: nil)

        self.isHidden = true
        self.removeFromSuperview()
    }
}
