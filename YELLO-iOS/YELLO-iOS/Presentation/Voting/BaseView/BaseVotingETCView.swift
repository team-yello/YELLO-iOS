//
//  BaseVotingView.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

final class BaseVotingETCView: BaseView {
    // 컴포넌트 위치 순서대로
    let topOfPointIcon = UIImageView()
    let topOfMyPoint = UILabel()
    
    let balloonToday = UIImageView()
    let balloonWho = UIImageView()
    let balloonSend = UIImageView()
    
    let titleLabel = UILabel()
    let textLabel = UILabel()
    
    let plusPoint = UILabel()
    let yelloImage = UIImageView()
    
    let grayView = UIView()
    let myPointIcon = UIImageView()
    let myPointText = UILabel()
    let realMyPoint = UILabel()
    let engPoint = UILabel()
    
    let yelloFace = UIImageView()
    let yellowButton = UIButton()

    // MARK: - Style
    
    override func setStyle() {
        topOfPointIcon.do {
            $0.image = ImageLiterals.Voting.icPoint
        }
        
        topOfMyPoint.do {
            $0.text = "0"
            $0.textColor = .white
            $0.font = .uiBodyLarge
        }
        
        balloonToday.do {
            $0.image = ImageLiterals.Voting.imgVotingStartBalloon1
        }
        
        balloonWho.do {
            $0.image = ImageLiterals.Voting.imgVotingStartBalloon2
        }
        
        balloonSend.do {
            $0.image = ImageLiterals.Voting.imgVotingStartBalloon3
        }
        
        titleLabel.do {
            $0.textColor = .white
            $0.font = .uiHeadline03
        }
        
        textLabel.do {
            $0.textColor = .grayscales500
            $0.font = .uiBodySmall
        }
        
        plusPoint.do {
            $0.textColor = .white
            $0.font = .uiPointLabel
        }
        
        grayView.do {
            $0.backgroundColor = UIColor(hex: "293036")
            $0.makeCornerRound(radius: 8)
        }
        
        myPointIcon.do {
            $0.image = ImageLiterals.Voting.icPoint
        }

        myPointText.do {
            $0.text = "내 포인트"
            $0.textColor = .white
            $0.font = .uiBodyMedium
        }
        
        realMyPoint.do {
            $0.textColor = .white
            $0.font = .uiSubtitle03
        }
        
        engPoint.do {
            $0.textColor = .grayscales400
            $0.font = .uiBodyMedium
        }
        
        yelloFace.do {
            $0.image = ImageLiterals.TabBar.icHomeSelected
        }
        
        yellowButton.do {
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .uiSubtitle03
            $0.backgroundColor = .yelloMain500
        }
    }
    
    // MARK: - Layout
    
    override func setLayout() {
        self.addSubviews(topOfPointIcon,
                         topOfMyPoint,
                         balloonToday,
                         balloonWho,
                         balloonSend,
                         titleLabel,
                         textLabel,
                         plusPoint,
                         yelloImage,
                         grayView,
                         yellowButton,
                         yelloFace)
                
        grayView.addSubviews(myPointIcon,
                             myPointText,
                             realMyPoint,
                             engPoint)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        plusPoint.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        yelloImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        grayView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        myPointIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        myPointText.snp.makeConstraints {
            $0.leading.equalTo(myPointIcon.snp.trailing).offset(8.adjusted)
            $0.centerY.equalTo(myPointIcon.snp.centerY)
        }
    
        realMyPoint.snp.makeConstraints {
            $0.trailing.equalTo(engPoint.snp.leading).offset(-4.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        engPoint.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        yellowButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(343.adjusted)
        }
    }
}
