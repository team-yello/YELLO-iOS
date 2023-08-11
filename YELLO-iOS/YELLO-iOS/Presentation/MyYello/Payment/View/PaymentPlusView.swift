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
                               nameKeyFiveButton)
        
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
            $0.bottom.equalToSuperview().inset(31.adjustedHeight)
        }
    }
}
