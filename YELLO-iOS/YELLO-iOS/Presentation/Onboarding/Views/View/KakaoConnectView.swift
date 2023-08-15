//
//  KakaoConnectView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/15.
//

import UIKit

final class KakaoConnectView: BaseView {
    
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let imageView = UIImageView()
    let kakaoConnectButton = UIButton()
    
    let stackView = UIStackView()
    
    override func setStyle() {
        
        self.backgroundColor = .black
        
        titleLabel.do {
            $0.text = "나의 Yell:o 친구는 어디있을까?"
            $0.textColor = .white
            $0.font = .uiHeadline03
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 28)
        }
        
        subTitleLabel.do {
            $0.text = "친구 목록을 불러와봐요!"
            $0.font = .uiBodySmall
            $0.textColor = .grayscales500
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 22)
        }
        
        imageView.do {
            $0.image = ImageLiterals.OnBoarding.addFriends
        }
        
        stackView.do {
            $0.addArrangedSubviews(titleLabel, subTitleLabel, imageView)
            $0.axis = .vertical
            $0.setCustomSpacing(8, after: subTitleLabel)
            $0.setCustomSpacing(6, after: subTitleLabel)
            $0.alignment = .center
        }
        
        kakaoConnectButton.do {
            $0.backgroundColor = UIColor(hex: "FEE500")
            $0.setTitle("카카오톡 친구 연결하기", for: .normal)
            $0.titleLabel?.font = .uiBody01
            $0.setTitleColor(UIColor(hex: "191600"), for: .normal)
            $0.makeCornerRound(radius: 8)
        }
        
    }
    
    override func setLayout() {
        
        self.addSubviews(titleLabel,
                         subTitleLabel,
                         imageView,
                         kakaoConnectButton)
        
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
        
        kakaoConnectButton.snp.makeConstraints {
            $0.height.equalTo(48.adjustedHeight)
            $0.bottom.equalToSuperview().inset(91.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
        }
    }
}
