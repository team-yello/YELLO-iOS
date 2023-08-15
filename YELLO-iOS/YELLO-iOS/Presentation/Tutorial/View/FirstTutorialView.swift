//
//  TutorialView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/15.
//

import UIKit

import SnapKit
import Then
import Lottie

final class FirstTutorialView: UIView {
    
    let tutorialImageView = UIImageView()
    let tutorialTitleLabel = UILabel()
    let tutorialGuideLabel = UILabel()
    
    let tutorialImage = UIScreen.main.isWiderThan375pt ? ImageLiterals.Tutorial.tutorialLong1 : ImageLiterals.Tutorial.tutorial1
    let bottomMargin = UIScreen.main.isWiderThan375pt ? 320.adjustedHeight : 228.adjustedHeight
    let guideBottomMargin = UIScreen.main.isWiderThan375pt ? 154.adjustedHeight : 88.adjustedHeight
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        tutorialImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.image = tutorialImage
        }
        
        tutorialTitleLabel.do {
            $0.text = StringLiterals.Tutorial.firstTutorialText
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 28.adjustedHeight)
            $0.font = .uiHeadline02
            $0.numberOfLines = 2
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        tutorialGuideLabel.do {
            $0.text = StringLiterals.Tutorial.firstGuideText
            $0.font = .uiBody03
            $0.textColor = .white
        }
    }
    
    private func setLayout() {
        self.addSubviews(tutorialImageView, tutorialTitleLabel, tutorialGuideLabel)
        tutorialImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }

        tutorialTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(bottomMargin)
            $0.centerX.equalToSuperview()
        }

        tutorialGuideLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(guideBottomMargin)
            $0.centerX.equalToSuperview()
        }
    }
}
