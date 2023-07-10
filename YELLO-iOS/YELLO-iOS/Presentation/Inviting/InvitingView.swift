//
//  BaseSharingView.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

final class InvitingView: BaseView {

    // 컴포넌트 위치 순서대로
    let closeButton = UIButton()

    let titleLabel = UILabel()
    let textLabel = UILabel()
    
    let backGroundView = UIView()
    let recommender = UILabel()
    let recommenderID = UILabel()
    
    let kakaoButton = UIButton()
    let copyButton = UIButton()
    
    // MARK: - Style
    
    override func setStyle() {
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
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Inviting.unLockedTitle, lineHeight: 24)
            $0.textColor = .black
            $0.font = .uiHeadline04
        }
        
        textLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Inviting.unLockedText, lineHeight: 20)
            $0.numberOfLines = 2
            $0.textColor = .grayscales600
            $0.font = .uiBody03
            $0.asColor(targetString: "바로 투표" , color: .black)
        }
        
        backGroundView.do {
            $0.backgroundColor = .grayscales50
            $0.makeCornerRound(radius: 8)
        }
        
        recommender.do {
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
    
    // MARK: - Layout
    
    override func setLayout() {
        self.addSubviews(closeButton,
                         titleLabel,
                         textLabel,
                         backGroundView,
                         kakaoButton,
                         copyButton)
        
        backGroundView.addSubviews(recommender,
                                   recommenderID)
        
        closeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(14.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        backGroundView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(14.adjusted)
            $0.top.equalToSuperview().inset(146.adjusted)
            $0.bottom.equalToSuperview().inset(120.adjusted)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        recommender.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(47.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        recommenderID.snp.makeConstraints {
            $0.top.equalTo(recommender.snp.bottom).offset(8.adjusted)
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