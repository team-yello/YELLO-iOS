//
//  OnboardingEndView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

import Lottie

class OnboardingEndView: BaseView {
    
    let GuideLabel = UILabel()
    let subGuideLabel = UILabel()
    
    let endingImageView = UIImageView()
    
    let goToYelloButton = UIButton()
    let animationView = LottieAnimationView(name: "SignAnimation")
    
    override func setStyle() {
        GuideLabel.do {
            $0.text = "회원가입이 끝났어요!"
            $0.font = .uiHeadline03
            $0.textColor = .white
        }
        
        subGuideLabel.do {
            $0.text = "지금 바로 친구들에게 옐로하러 가볼까요?"
            $0.font = .uiBodySmall
            $0.textColor = .grayscales600
        }
        
        animationView.do {
            $0.play()
            $0.loopMode = .loop
        }
        
        
        goToYelloButton.do {
            $0.backgroundColor = .yelloMain500
            $0.setImage(ImageLiterals.OnBoarding.icYelloFace, for: .normal)
            $0.semanticContentAttribute = .forceRightToLeft
            $0.setTitle("옐로하러 가기", for: .normal)
            $0.titleLabel?.font = .uiSubtitle03
            $0.setTitleColor(.black, for: .normal)
            $0.makeCornerRound(radius: CGFloat(Constraints.round))
        }
    
    }
    
    override func setLayout() {
        self.addSubviews(GuideLabel, subGuideLabel, animationView, goToYelloButton)
        
        GuideLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.topMargin.equalToSuperview().inset(60)
        }
        
        subGuideLabel.snp.makeConstraints {
            $0.top.equalTo(GuideLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        animationView.snp.makeConstraints {
            $0.top.equalTo(subGuideLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalToSuperview()
        }
        
        goToYelloButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
            $0.bottom.equalToSuperview().inset(Constraints.bottomMargin)
            $0.height.equalTo(48)
        }
    }
    
}
