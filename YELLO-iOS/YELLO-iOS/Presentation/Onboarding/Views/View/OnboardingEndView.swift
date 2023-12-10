//
//  OnboardingEndView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

import SnapKit
import Then
import Lottie

class OnboardingEndView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    var isRecommand = !(UserManager.shared.recommendId.isEmpty)
    
    // MARK: Constants
    let buttonHeight = 48.adjustedHeight
    
    // MARK: Component
    let titleStackView = UIStackView()
    let titleIconImageView = UIImageView()
    let guideLabel = UILabel()
    
    let subGuideLabel = UILabel()
    let endingImageView = UIImageView()
    let subTitleLabel  = UILabel()
    let goToYelloButton = YelloButton(buttonText: StringLiterals.Onboarding.End.endingButton,
                                      isEnabled: true)
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        
        titleStackView.do {
            $0.addArrangedSubviews(titleIconImageView, guideLabel)
            $0.spacing = 4
            $0.axis = .horizontal
            $0.alignment = .center
        }
        
        guideLabel.do {
            $0.text = StringLiterals.Onboarding.End.endingTitle
            $0.font = .uiHeadline00
            $0.textColor = .white
        }
        
        titleIconImageView.do {
            $0.image = ImageLiterals.OnBoarding.icSmallPoint
        }
        
        subGuideLabel.do {
            $0.text = StringLiterals.Onboarding.End.endingText
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 22)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales600
        }
        
        endingImageView.do {
            $0.image = isRecommand ? ImageLiterals.OnBoarding.subscriptionPointPlus : ImageLiterals.OnBoarding.subscriptionPoint
        }
        
        subTitleLabel.do {
            $0.text = StringLiterals.Onboarding.End.endingSubText
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 22)
            $0.textColor = .white
            $0.font = .uiSubtitle02
        }
        
        goToYelloButton.do {
            $0.setImage(ImageLiterals.OnBoarding.icYelloFace, for: .normal)
            $0.semanticContentAttribute = .forceRightToLeft
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8.adjusted, bottom: 0, right: 0)
        }
        
    }
    
    override func setLayout() {
        self.addSubviews(titleStackView,
                         subGuideLabel,
                         endingImageView,
                         subTitleLabel,
                         goToYelloButton)
        
        titleStackView.snp.makeConstraints {
            $0.height.equalTo(28.adjustedHeight)
            $0.bottom.equalTo(subGuideLabel.snp.top).offset(-10.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        titleIconImageView.snp.makeConstraints {
            $0.size.equalTo(28.adjusted)
        }
        
        subGuideLabel.snp.makeConstraints {
            $0.bottom.equalTo(endingImageView.snp.top).offset(-20.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        endingImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(goToYelloButton.snp.top).offset(-101.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        goToYelloButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.bottom.equalToSuperview().inset(34.adjustedHeight)
            $0.height.equalTo(buttonHeight)
        }
    }
    
}
