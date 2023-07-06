//
//  BaseSharingView.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

final class BaseInvitingView: BaseView {

    let closeButton = UIButton()

    let blackLabel = UILabel()
    let grayLabel = UILabel()
    
    let purpleLabel = UILabel()
    let recommenderID = UILabel()
    
    let kakaoButton = UIButton()
    let copyButton = UIButton()
    
    override func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        
        self.makeCornerRound(radius: 10)
        self.backgroundColor = .white
        
        closeButton.do {
            $0.setTitle("닫기", for: .normal)
            $0.setImage(ImageLiterals.InvitingPopUp.icClose, for: .normal)
            $0.setTitleColor(.grayscales600, for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.titleLabel?.font = .uiLabelLarge
            $0.contentHorizontalAlignment = .center
            $0.semanticContentAttribute = .forceRightToLeft
        }
        
        blackLabel.do {
            $0.setTextWithLineHeight(text: "친구 초대하고 기다리지 않기", lineHeight: 24)
            $0.textColor = .black
            $0.font = .uiHeadline04
        }
        
        grayLabel.do {
            $0.setTextWithLineHeight(text: "친구가 내 추천인 코드로 가입하면\n기다리지 않고 바로 투표할 수 있어요!", lineHeight: 20)
            $0.numberOfLines = 2
            $0.textColor = .grayscales600
            $0.font = .uiBody03
            $0.asColor(targetString: "바로 투표" , color: .black)
        }
        
        purpleLabel.do {
            $0.setTextWithLineHeight(text: "내 추천인 코드", lineHeight: 20)
            $0.textColor = .purpleSub500
            $0.font = .uiBody04
        }
        
        recommenderID.do {
            $0.setTextWithLineHeight(text: "@nahyunyou", lineHeight: 32)
            $0.textColor = .black
            $0.font = .uiExtraLarge
        }
        
        kakaoButton.do {
            $0.setImage(ImageLiterals.InvitingPopUp.icKakaoShare, for: .normal)
        }
        
        copyButton.do {
            $0.setImage(ImageLiterals.InvitingPopUp.icLinkCopy, for: .normal)
        }
    }
    
    private func setLayout() {
        self.addSubviews(closeButton,
                         blackLabel,
                         grayLabel,
                         purpleLabel,
                         recommenderID,
                         kakaoButton,
                         copyButton)
        
        closeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(14.adjusted)
        }
        
        blackLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        grayLabel.snp.makeConstraints {
            $0.top.equalTo(blackLabel.snp.bottom).offset(12.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        purpleLabel.snp.makeConstraints {
            $0.top.equalTo(grayLabel.snp.bottom).offset(47.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        recommenderID.snp.makeConstraints {
            $0.top.equalTo(purpleLabel.snp.bottom).offset(8.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        kakaoButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(100.adjusted)
            $0.bottom.equalToSuperview().inset(50.adjusted)
        }
        
        copyButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(100.adjusted)
            $0.bottom.equalToSuperview().inset(50.adjusted)
        }
    }


}
