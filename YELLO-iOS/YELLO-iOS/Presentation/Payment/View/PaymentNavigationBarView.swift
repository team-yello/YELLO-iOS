//
//  PaymentNavigationBarView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/10.
//

import UIKit

import SnapKit
import Then

final class PaymentNavigationBarView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    weak var handleBackButtonDelegate: HandleBackButtonDelegate?
    
    // MARK: Component
    lazy var backButton = BaseIconButton()
    let subscribeView = UIView()
    let yelloPlusImageView = UIImageView()
    let yelloPlusLabel = UILabel()
    
    override func setStyle() {
        self.backgroundColor = .black
        
        backButton.do {
            $0.setImage(ImageLiterals.Profile.icArrowLeftWhite, for: .normal)
            $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        }
        
        subscribeView.do {
            $0.backgroundColor = .grayscales900
            $0.makeCornerRound(radius: 8.adjustedHeight)
            $0.isHidden = true
        }
        
        yelloPlusImageView.do {
            $0.image = ImageLiterals.Payment.imgYelloPlusStar
        }
        
        yelloPlusLabel.do {
            $0.text = StringLiterals.MyYello.Payment.subscribing
            $0.font = .uiBodySmall
            $0.textColor = .grayscales100
        }
    }
    
    override func setLayout() {
        self.addSubviews(backButton,
                         subscribeView)
        
        subscribeView.addSubviews(yelloPlusImageView,
                                  yelloPlusLabel)
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
        }
        
        subscribeView.snp.makeConstraints {
            $0.height.equalTo(32.adjustedHeight)
            $0.width.equalTo(144.adjustedWidth)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16.adjustedWidth)
        }
        
        yelloPlusImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10.adjustedWidth)
            $0.centerY.equalToSuperview()
        }
        
        yelloPlusLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10.adjustedWidth)
        }
    }
}

// MARK: - extension
extension PaymentNavigationBarView {
    
    // MARK: Objc Function
    @objc private func backButtonDidTap() {
        self.handleBackButtonDelegate?.popView()
    }
}
