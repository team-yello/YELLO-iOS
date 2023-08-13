//
//  PaymentConfirmView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/11.
//

import UIKit

import SnapKit
import Then

protocol HandleConfirmPaymentButtonDelegate: AnyObject {
    func confirmPaymentButtonTapped()
}

final class PaymentConfirmView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    let contentsView = UIView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let paymentImageView = UIImageView()
    lazy var confirmButton = UIButton()
    
    // MARK: Property
    weak var handleConfirmPaymentButtonDelegate: HandleConfirmPaymentButtonDelegate?
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black.withAlphaComponent(0.7)
        
        contentsView.makeCornerRound(radius: 12)
        contentsView.backgroundColor = .grayscales900
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Payment.paymentAlertPlusTitle, lineHeight: 22)
            $0.textColor = .white
            $0.font = .uiSubtitle02
        }
        
        descriptionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Payment.paymentAlertPlusDescription, lineHeight: 15)
            $0.textColor = .grayscales400
            $0.font = .uiLabelMedium
        }
        
        confirmButton.do {
            $0.backgroundColor = .clear
            $0.titleLabel?.font = .uiButton
            $0.setTitleColor(.grayscales300, for: .normal)
            $0.setTitle(StringLiterals.MyYello.Alert.confirmButton, for: .normal)
            $0.addTarget(self, action: #selector(confirmPaymentButtonTapped), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        self.addSubview(contentsView)
        
        contentsView.addSubviews(titleLabel,
                                 descriptionLabel,
                                 paymentImageView,
                                 confirmButton)
        
        contentsView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(374)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(38)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        paymentImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(230)
            $0.height.equalTo(200)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(paymentImageView.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
            $0.width.equalTo(260)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
// MARK: - extension
extension PaymentConfirmView {
    
    // MARK: Objc Function
    @objc func confirmPaymentButtonTapped() {
        self.isHidden = true
        self.removeFromSuperview()
        handleConfirmPaymentButtonDelegate?.confirmPaymentButtonTapped()
    }
}
