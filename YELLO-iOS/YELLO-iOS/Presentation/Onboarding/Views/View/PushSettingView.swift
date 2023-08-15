//
//  PushSettingView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/08.
//

import UIKit

import SnapKit
import Then
import Lottie

class PushSettingView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    let titleStackView = UIStackView()
    let guideLabel = UILabel()
    let iconImageView = UIImageView()
    
    let subGuideLabel = UILabel()
    
    let pushSettingImageView = UIImageView()
    
    let pushSettingButton = YelloButton(buttonText: StringLiterals.Onboarding.pushNotiButtonText,
                                        isEnabled: true )
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        
        titleStackView.do {
            $0.axis = .horizontal
            $0.addArrangedSubviews(guideLabel, iconImageView)
            $0.alignment = .center
            $0.spacing = 4.adjusted
        }
        
        iconImageView.do {
            $0.image = ImageLiterals.OnBoarding.icHeart
        }
        
        guideLabel.do {
            $0.text = StringLiterals.Onboarding.pushNotiText
            $0.font = .uiHeadline03
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 28.adjusted)
            $0.textColor = .white
        }
        
        subGuideLabel.do {
            $0.text = StringLiterals.Onboarding.pushNotiHelper
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 22.adjusted)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales600
        }
        
        pushSettingImageView.do {
            $0.image = ImageLiterals.OnBoarding.pushNotification
        }
        
    
    }
    
    override func setLayout() {
        self.addSubviews(titleStackView,
                         subGuideLabel,
                         pushSettingImageView,
                         pushSettingButton)
        
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(18.adjusted)
        }
        
        titleStackView.snp.makeConstraints {
            $0.bottom.equalTo(subGuideLabel.snp.top).offset(-8.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(28.adjustedHeight)
        }
        
        subGuideLabel.snp.makeConstraints {
            $0.bottom.equalTo(pushSettingImageView.snp.top).offset(-24.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        pushSettingImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        pushSettingButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.bottom.equalToSuperview().inset(34.adjustedHeight)
            $0.height.equalTo(48.adjustedHeight)
        }
    }
    
}
