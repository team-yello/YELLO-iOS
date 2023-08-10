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
    lazy var backButton = UIButton()
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
            
        }
    }
    
    override func setLayout() {
        self.addSubviews(backButton,
                         subscribeView)
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
        }
        
        subscribeView.snp.makeConstraints {
            
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
