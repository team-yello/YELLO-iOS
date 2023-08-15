//
//  FourthTutorialView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/15.
//

import UIKit

import SnapKit
import Then

final class FourthTutorial: UIView {
    
    let tutorialImageView = UIImageView()
    let tutorialTitleLabel = UILabel()
    let tutorialGuideLabel = UILabel()
    let tutorialToastLabel = UILabel()
    let tutorialImage = UIScreen.main.isWiderThan375pt ? ImageLiterals.Tutorial.tutorialLong4 : ImageLiterals.Tutorial.tutorial4
    let bottomMargin = UIScreen.main.isWiderThan375pt ? 155.adjusted : 87.adjusted
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        tutorialImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.image = tutorialImage
        }
        
        tutorialTitleLabel.do {
            $0.text = StringLiterals.Tutorial.fourthTutorialText
            $0.font = .uiHeadline02
            $0.numberOfLines = 2
            $0.textColor = .white
            $0.textAlignment = .center
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 28.adjustedHeight)
        }
        
        tutorialGuideLabel.do {
            $0.text = StringLiterals.Tutorial.fourthSubText
            $0.font = .uiBody03
            $0.textColor = .grayscales500
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 20.adjustedHeight)
        }
        
        tutorialToastLabel.do {
            $0.text = StringLiterals.Tutorial.fourthToastText
            $0.font = .uiLabelLarge
            $0.textColor = .white
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 16.adjustedHeight)
            $0.backgroundColor = .grayscales900
            $0.makeCornerRound(radius: 4.adjusted)
            $0.asColor(targetString: "’이 질문 건너뛰기’", color: .yelloMain500)
        }
    }
    
    private func setLayout() {
        self.addSubviews(tutorialImageView,
                         tutorialToastLabel,
                         tutorialTitleLabel,
                         tutorialGuideLabel)
        
        tutorialImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
        tutorialToastLabel.snp.makeConstraints {
            $0.height.equalTo(55.adjustedHeight)
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(72.adjustedWidth)
        }
        
        tutorialGuideLabel.snp.makeConstraints {
            $0.bottom.equalTo(tutorialTitleLabel.snp.top).offset(-6.adjustedHeight)
            $0.leading.equalTo(tutorialTitleLabel.snp.leading)
        }

        tutorialTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(bottomMargin)
            $0.centerX.equalToSuperview()
        }

    }
}
