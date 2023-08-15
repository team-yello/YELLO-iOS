//
//  SecondTutorialView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/15.
//

import UIKit

import SnapKit
import Then
import Lottie

final class SecondTutorialView: UIView {
    
    let tutorialImageView = UIImageView()
    let tutorialTitleLabel = UILabel()
    let tutorialImage = UIScreen.main.isWiderThan375pt ? ImageLiterals.Tutorial.tutorialLong2 : ImageLiterals.Tutorial.tutorial2
    let bottomMargin = UIScreen.main.isWiderThan375pt ? 370.adjusted : 313.adjusted
    
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
            $0.text = StringLiterals.Tutorial.secondTutorialText
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 28.adjustedHeight)
            $0.font = .uiHeadline02
            $0.numberOfLines = 2
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
    }
    
    private func setLayout() {
        self.addSubviews(tutorialImageView, tutorialTitleLabel)
        tutorialImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        tutorialTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(bottomMargin)
            $0.centerX.equalToSuperview()
        }

    }
}
