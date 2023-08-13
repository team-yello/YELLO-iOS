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
    
    let stackView = UIStackView()
    
    override func setStyle() {
        self.backgroundColor = .black
        
        titleLabel.do {
            $0.text = "Yell:o에 오신 걸 환영해요!"
            $0.textColor = .white
            $0.font = .uiHeadline03
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 28)
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
            $0.setCustomSpacing(8, after: subTitleLabel)
            $0.setCustomSpacing(6, after: subTitleLabel)
            $0.alignment = .center
        }
        
        kakaoButton.do {
            $0.setImage(ImageLiterals.OnBoarding.btnKakaoLogin, for: .normal)
        }
    }
    
    override func setLayout() {
        
        self.addSubviews(titleLabel,
                         subTitleLabel,
                         imageView,
                         kakaoButton)
        
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
        }
    }
}
