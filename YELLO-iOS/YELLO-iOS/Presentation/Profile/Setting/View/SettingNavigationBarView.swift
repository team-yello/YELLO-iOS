//
//  SettingNavigationBarView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

// MARK: - Protocol
protocol HandleBackButtonDelegate: AnyObject {
    func popView()
}

final class SettingNavigationBarView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    weak var handleBackButtonDelegate: HandleBackButtonDelegate?
    
    // MARK: Component
    lazy var backButton = UIButton()
    let titleLabel = UILabel()
    
    override func setStyle() {
        self.backgroundColor = .black
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Setting.setting, lineHeight: 24.adjustedHeight)
            $0.textColor = .white
            $0.font = .uiSubtitle05
        }
        
        backButton.do {
            $0.setImage(ImageLiterals.Profile.icArrowLeftWhite, for: .normal)
            $0.imageView?.tintColor = .white
            $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        self.addSubviews(backButton,
                         titleLabel)
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(backButton.snp.trailing).offset(8.adjustedWidth)
        }
    }
    
    // MARK: Objc Function
    @objc private func backButtonDidTap() {
        self.handleBackButtonDelegate?.popView()
    }
}
