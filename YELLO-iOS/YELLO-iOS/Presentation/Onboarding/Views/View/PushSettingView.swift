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
    let GuideLabel = UILabel()
    let subGuideLabel = UILabel()
    
    let endingImageView = UIImageView()
    
    let goToYelloButton = UIButton()
    
    let stackView = UIStackView()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        GuideLabel.do {
            $0.text = StringLiterals.Onboarding.pushNotiText
            $0.font = .uiHeadline03
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 28.adjusted)
            $0.textColor = .white
        }
        
        subGuideLabel.do {
            $0.text = StringLiterals.Onboarding.pushNotiHelper
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 22)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales600
        }
        
        endingImageView.do {
            $0.backgroundColor = .grayscales700
        }
        
        goToYelloButton.do {
            $0.backgroundColor = .yelloMain500
            $0.setTitle(StringLiterals.Onboarding.pushNotiButtonText, for: .normal)
            $0.titleLabel?.font = .uiSubtitle03
            $0.setTitleColor(.black, for: .normal)
            $0.makeCornerRound(radius: CGFloat(Constraints.buttonRound))
        }
    
        stackView.do {
            $0.addArrangedSubviews(GuideLabel,
                                   subGuideLabel,
                                   endingImageView)
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .center
        }
    }
    
    override func setLayout() {
        self.addSubviews(stackView, goToYelloButton)
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        goToYelloButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
            $0.bottom.equalToSuperview().inset(Constraints.bottomMargin)
            $0.height.equalTo(48)
        }
    }
    
}
