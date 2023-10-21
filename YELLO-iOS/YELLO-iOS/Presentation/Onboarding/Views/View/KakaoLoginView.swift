//
//  KakaoLoginView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/15.
//

import UIKit

class KakaoLoginView: BaseView {

    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let imageView = UIImageView()
    let kakaoButton = UIButton()
    let privacyButton = UIButton()
    
    let stackView = UIStackView()
    
    override func setStyle() {
        self.backgroundColor = .black
        
        titleLabel.do {
            $0.text = "Yell:o에 오신 걸 환영해요!"
            $0.textColor = .white
            $0.font = .uiHeadline00
        }
        
        subTitleLabel.do {
            $0.text = "가입을 시작해볼까요?"
            $0.font = .uiBodySmall
            $0.textColor = .grayscales500
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 22)
        }
        
        imageView.do {
            $0.image = ImageLiterals.OnBoarding.onboardingStart
        }
        
        stackView.do {
            $0.addArrangedSubviews(titleLabel, subTitleLabel, imageView)
            $0.axis = .vertical
            $0.setCustomSpacing(8.adjustedHeight, after: subTitleLabel)
            $0.setCustomSpacing(6.adjustedHeight, after: subTitleLabel)
            $0.alignment = .center
        }
        
        kakaoButton.do {
            $0.backgroundColor = UIColor(hex: "FEE500")
            $0.setTitle("카카오로 시작하기", for: .normal)
            $0.titleLabel?.font = .uiBody01
            $0.setTitleColor(UIColor(hex: "191600"), for: .normal)
            $0.setImage(ImageLiterals.OnBoarding.icKakao, for: .normal)
            $0.makeCornerRound(radius: 8.adjusted)
        }
        
        privacyButton.do {
            $0.setImage(ImageLiterals.OnBoarding.icAlertCircle, for: .normal)
            $0.setTitle(StringLiterals.Onboarding.privacyButtonText, for: .normal)
            $0.setTitleColor(.grayscales500, for: .normal)
            $0.titleLabel?.font = .uiLabelLarge
            $0.setUnderline()
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 0)
        }
    }
    
    override func setLayout() {
        
        self.addSubviews(titleLabel,
                         subTitleLabel,
                         imageView,
                         kakaoButton,
                         privacyButton)
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(subTitleLabel.snp.top).offset(-8.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(imageView.snp.top).offset(-2.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        kakaoButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(91.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(48.adjustedHeight)
        }
        
        kakaoButton.imageView?.snp.makeConstraints({
            $0.leading.equalToSuperview().offset(28.adjustedHeight)
            $0.centerY.equalToSuperview()
        })
        
        privacyButton.snp.makeConstraints {
            $0.top.equalTo(kakaoButton.snp.bottom).offset(18.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
     
    }
}
