//
//  MyYelloDetailNavigationBarView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyYelloDetailNavigationBarView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    weak var handleBackButtonDelegate: HandleBackButtonDelegate?
    
    // MARK: Component
    lazy var backButton = UIButton()
    let titleLabel = UILabel()
    let pointView = UIView()
    let pointImageView = UIImageView()
    var pointLabel = UILabel()

    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .clear

        backButton.do {
            $0.setImage(ImageLiterals.Profile.icArrowLeftWhite, for: .normal)
            $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: "", lineHeight: 24)
            $0.font = .uiSubtitle05
            $0.textColor = .white
        }
        
        pointImageView.do {
            $0.image = ImageLiterals.MyYello.icPointWhite
        }
        
        pointLabel.do {
            $0.text = " "
            $0.font = .uiBodyMedium
            $0.textColor = .white
        }
    }
    
    override func setLayout() {
        self.addSubviews(backButton,
                         titleLabel,
                         pointImageView,
                         pointLabel)
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(backButton.snp.trailing).inset(-8)
        }
        
        pointImageView.snp.makeConstraints {
            $0.centerY.equalTo(backButton)
//            $0.trailing.equalToSuperview().inset(61)
        }
        
        pointLabel.snp.makeConstraints {
            $0.centerY.equalTo(backButton)
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.equalTo(pointImageView.snp.trailing).inset(-8)
        }
    }
}
// MARK: - extension
extension MyYelloDetailNavigationBarView {
    
    // MARK: Objc Function
    @objc private func backButtonDidTap() {
        self.handleBackButtonDelegate?.popView()
    }
}
