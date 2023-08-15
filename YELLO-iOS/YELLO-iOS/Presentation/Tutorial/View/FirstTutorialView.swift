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
            $0.image = ImageLiterals.Tutorial.tutorial1
        }
        
        tutorialTitleLabel.do {
            $0.text = StringLiterals.Tutorial.firstTutorialText
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
            $0.edges.equalToSuperview()
        }

        tutorialTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(228.adjustedHeight)
            $0.centerX.equalToSuperview()
        }

        tutorialGuideLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(88.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
    }
}
