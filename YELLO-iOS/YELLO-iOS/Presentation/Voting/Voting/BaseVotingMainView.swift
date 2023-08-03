//
//  BaseVotingMainView.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class BaseVotingMainView: BaseView {
    let progressView = UIProgressView()
    let yelloBalloon = UIImageView()
    let yelloProgress = UIImageView()
    
    let yelloProgressBackGroundOne = UIImageView()
    let yelloProgressBackGroundTwo = UIImageView()
    let yelloProgressBackGroundThree = UIImageView()
    let yelloProgressBackGroundFour = UIImageView()
    
    let questionBackground = UIView()
    
    let nameOneButton = UIButton()
    let nameTwoButton = UIButton()
    let nameThreeButton = UIButton()
    let nameFourButton = UIButton()
    
    let keywordOneButton = UIButton()
    let keywordTwoButton = UIButton()
    let keywordThreeButton = UIButton()
    let keywordFourButton = UIButton()
    
    let suffleButton = UIButton()
    let suffleIcon = UIImageView()
    let suffleText = UILabel()
    let suffleNum = UILabel()
    let skipButton = UIButton()
        
    // MARK: - Style
    
    override func setStyle() {
        progressView.do {
            $0.progressViewStyle = .bar
            $0.progressTintColor = .white
            $0.trackTintColor = UIColor(hex: "FFFFFF", alpha: 0.35)
            $0.progress = 0.125
            $0.makeCornerRound(radius: 5)
            $0.clipsToBounds = true
            $0.layer.sublayers![1].cornerRadius = 5
            $0.subviews[1].clipsToBounds = true
        }
        
        yelloBalloon.do {
            $0.image = ImageLiterals.Voting.imgYelloBalloon1
        }
        
        yelloProgress.do {
            $0.image = ImageLiterals.Voting.imgFace1
        }
        
        yelloProgressBackGroundOne.do {
            $0.image = ImageLiterals.Voting.imgProgress1
            $0.alpha = 0.5
        }
        
        yelloProgressBackGroundTwo.do {
            $0.image = ImageLiterals.Voting.imgProgress1
            $0.alpha = 0.5
        }
        
        yelloProgressBackGroundThree.do {
            $0.image = ImageLiterals.Voting.imgProgress1
            $0.alpha = 0.5
        }
        
        yelloProgressBackGroundFour.do {
            $0.image = ImageLiterals.Voting.imgProgress1
            $0.alpha = 0.5
        }
        
        questionBackground.do {
            $0.backgroundColor = .black
            $0.makeCornerRound(radius: 32)
        }
        
        nameOneButton.do {
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
            $0.roundCorners(cornerRadius: 32, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        
        nameTwoButton.do {
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
        }
        
        nameThreeButton.do {
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
        }
        
        nameFourButton.do {
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
            $0.roundCorners(cornerRadius: 32, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }
        
        keywordOneButton.do {
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .uiBodyMedium
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
            $0.roundCorners(cornerRadius: 32, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        
        keywordTwoButton.do {
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .uiBodyMedium
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
        }
        
        keywordThreeButton.do {
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .uiBodyMedium
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
        }
        
        keywordFourButton.do {
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .uiBodyMedium
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
            $0.roundCorners(cornerRadius: 32, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }
        
        suffleButton.do {
            $0.makeCornerRound(radius: 23)
            $0.backgroundColor = UIColor(hex: "FFFFFF", alpha: 0.35)
        }
        
        suffleIcon.do {
            $0.image = ImageLiterals.Voting.icShuffle
        }
        
        suffleText.do {
            $0.text = "친구 셔플"
            $0.textColor = .black
            $0.font = .uiBodySmall
        }
        
        suffleNum.do {
            $0.text = "3/3"
            $0.textColor = .black
            $0.font = .uiBody05
        }
        
        skipButton.do {
            $0.setTitle("이 질문 건너뛰기 ", for: .normal)
            $0.setImage(ImageLiterals.Voting.icSkip, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.titleLabel?.font = .uiBodySmall
            $0.contentHorizontalAlignment = .center
            $0.semanticContentAttribute = .forceRightToLeft
            $0.makeCornerRound(radius: 23)
            $0.backgroundColor = UIColor(hex: "FFFFFF", alpha: 0.35)
        }
        
    }
    
    // MARK: - Layout
    
    override func setLayout() {
        let width = UIScreen.main.bounds.size.width
        
        self.addSubviews(progressView,
                         yelloBalloon,
                         yelloProgress,
                         yelloProgressBackGroundOne,
                         yelloProgressBackGroundTwo,
                         yelloProgressBackGroundThree,
                         yelloProgressBackGroundFour,
                         questionBackground,
                         nameOneButton,
                         nameTwoButton,
                         nameThreeButton,
                         nameFourButton,
                         keywordOneButton,
                         keywordTwoButton,
                         keywordThreeButton,
                         keywordFourButton,
                         suffleButton,
                         suffleNum,
                         skipButton)
    
        suffleButton.addSubviews(suffleIcon, suffleText, suffleNum)
        
        progressView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
            $0.top.equalToSuperview().inset(32.adjusted)
            $0.height.equalTo(6.adjusted)
        }
        
        yelloBalloon.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(progressView.snp.bottom).offset(6.adjusted)
        }
        
        yelloProgress.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(yelloBalloon.snp.bottom).offset(3.adjusted)
        }
        
        yelloProgressBackGroundOne.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(yelloBalloon.snp.bottom).offset(3.adjusted)
        }
        
        yelloProgressBackGroundTwo.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width / 5)
            $0.top.equalTo(yelloBalloon.snp.bottom).offset(3.adjusted)
        }
        
        yelloProgressBackGroundThree.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(width / 5)
            $0.top.equalTo(yelloBalloon.snp.bottom).offset(3.adjusted)
        }
        
        yelloProgressBackGroundFour.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(yelloBalloon.snp.bottom).offset(3.adjusted)
        }
        
        questionBackground.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
            $0.height.equalTo(154.adjusted)
            $0.top.equalTo(yelloProgress.snp.bottom).offset(7.adjusted)
        }
        
        nameOneButton.snp.makeConstraints {
            $0.top.equalTo(questionBackground.snp.bottom).offset(4.adjusted)
            $0.leading.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(148.adjusted)
            $0.height.equalTo(70.adjusted)
        }
        
        nameTwoButton.snp.makeConstraints {
            $0.top.equalTo(nameOneButton.snp.bottom)
            $0.leading.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(148.adjusted)
            $0.height.equalTo(70.adjusted)
        }
        
        nameThreeButton.snp.makeConstraints {
            $0.top.equalTo(nameTwoButton.snp.bottom)
            $0.leading.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(148.adjusted)
            $0.height.equalTo(70.adjusted)
        }
        
        nameFourButton.snp.makeConstraints {
            $0.top.equalTo(nameThreeButton.snp.bottom)
            $0.leading.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(148.adjusted)
            $0.height.equalTo(70.adjusted)
        }
        
        keywordOneButton.snp.makeConstraints {
            $0.top.equalTo(questionBackground.snp.bottom).offset(4.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(196.adjusted)
            $0.height.equalTo(70.adjusted)
        }
        
        keywordTwoButton.snp.makeConstraints {
            $0.top.equalTo(keywordOneButton.snp.bottom)
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(196.adjusted)
            $0.height.equalTo(70.adjusted)
        }
        
        keywordThreeButton.snp.makeConstraints {
            $0.top.equalTo(keywordTwoButton.snp.bottom)
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(196.adjusted)
            $0.height.equalTo(70.adjusted)
        }
        
        keywordFourButton.snp.makeConstraints {
            $0.top.equalTo(keywordThreeButton.snp.bottom)
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(196.adjusted)
            $0.height.equalTo(70.adjusted)
        }
        
        suffleButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(19.adjusted)
            $0.leading.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(148.adjusted)
            $0.height.equalTo(48.adjusted)
        }
        
        suffleIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        suffleText.snp.makeConstraints {
            $0.leading.equalTo(suffleIcon.snp.trailing).offset(4.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        suffleNum.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(25.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        skipButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(19.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(192.adjusted)
            $0.height.equalTo(48.adjusted)
        }
        
    }
}
