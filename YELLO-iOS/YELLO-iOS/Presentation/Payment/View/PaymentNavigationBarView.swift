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
    var keyCount = 0
    var point = 0
    weak var handleBackButtonDelegate: HandleBackButtonDelegate?
    
    // MARK: Component
    lazy var backButton = BaseIconButton()
    let titleLabel = UILabel()
    
    lazy var keyCountView = NavigationBarCountView(image: ImageLiterals.MyYello.icKey, count: String(keyCount))
    lazy var pointCountView = NavigationBarCountView(image: ImageLiterals.MyYello.icPoint, count: String(point))
    
    override func setStyle() {
        self.backgroundColor = .black
        
        backButton.do {
            $0.setImage(ImageLiterals.Profile.icArrowLeftWhite, for: .normal)
            $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        }
        
        titleLabel.do {
            $0.text = StringLiterals.MyYello.NavigationBar.shop
            $0.font = .uiSubtitle05
            $0.textColor = .white
        }
        
    }
    
    override func setLayout() {
        self.addSubviews(backButton,
                         titleLabel,
                         keyCountView,
                         pointCountView)
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(backButton.snp.trailing).offset(8.adjustedWidth)
        }
        
        pointCountView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16.adjustedWidth)
        }
        
        keyCountView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(pointCountView.snp.leading).offset(-4.adjustedWidth)
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
