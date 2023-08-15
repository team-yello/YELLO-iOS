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
    var isRecommand = !(User.shared.recommendId.isEmpty)
    
    // MARK: Constants
    let buttonHeight = 48.adjustedHeight
    
    // MARK: Component
    let titleStackView = UIStackView()
    let titleIconImageView = UIImageView()
    let guideLabel = UILabel()
    
    let subGuideLabel = UILabel()
    let endingImageView = UIImageView()
    let subTitleLabel  = UILabel()
    let goToYelloButton = UIButton()
    
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
            $0.text = isRecommand ? StringLiterals.Onboarding.endingPlusTitle : StringLiterals.Onboarding.endingTitle
            $0.font = .uiHeadline03
            $0.textColor = .white
            $0.asColor(targetString: "+100포인트", color: .yelloMain500)
        }
        
        titleIconImageView.do {
            $0.image = ImageLiterals.OnBoarding.icSmallPoint
        }
        
        subGuideLabel.do {
            $0.text = StringLiterals.Onboarding.endingText
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 22)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales600
        }
        
        endingImageView.do {
            $0.image = isRecommand ? ImageLiterals.OnBoarding.subscriptionPointPlus : ImageLiterals.OnBoarding.subscriptionPoint
        }
        
        subTitleLabel.do {
            $0.text = StringLiterals.Onboarding.endingSubText
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 22)
            $0.textColor = .white
            $0.font = .uiSubtitle02
        }
        
        goToYelloButton.do {
            $0.backgroundColor = .yelloMain500
            $0.setImage(ImageLiterals.OnBoarding.icYelloFace, for: .normal)
            $0.semanticContentAttribute = .forceRightToLeft
            $0.setTitle(StringLiterals.Onboarding.endingButton, for: .normal)
            $0.titleLabel?.font = .uiSubtitle03
            $0.setTitleColor(.black, for: .normal)
            $0.makeCornerRound(radius: buttonHeight/2)
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
