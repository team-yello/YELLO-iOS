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
    
    let paymentNavigationBarView = PaymentNavigationBarView(frame: CGRect(x: 0, y: 0, width: 343.adjustedWidth, height: 78.adjustedHeight))
    let paymentLabel = UILabel()
    let paymentView = PaymentView()
    lazy var paymentYelloPlusButton = PaymentYelloPlusButton()
    
    override func setStyle() {
        self.backgroundColor = .black
        
        paymentLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Payment.yelloPlusTitle, lineHeight: 28.adjustedHeight)
            $0.font = .uiHeadline03
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
                         paymentLabel,
                         paymentView,
                         paymentYelloPlusButton)
        
        paymentNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        paymentLabel.snp.makeConstraints {
            $0.top.equalTo(paymentNavigationBarView.snp.bottom).offset(10.adjustedHeight)
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
        }
        
        paymentView.snp.makeConstraints {
            $0.top.equalTo(paymentLabel
                .snp.bottom).offset(16.adjustedHeight)
            $0.leading.trailing.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(228.adjustedHeight)
        }
        
        paymentYelloPlusButton.snp.makeConstraints {
            $0.top.equalTo(paymentView.snp.bottom).offset(12.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(78.adjustedHeight)
            $0.width.equalTo(343.adjustedWidth)
        }
    }
}
