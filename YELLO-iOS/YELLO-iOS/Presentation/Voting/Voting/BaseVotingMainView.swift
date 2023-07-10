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
    let yelloBalloon = UIImageView()
    let yelloProgress = UIImageView()
    let numOfPage = UILabel()
    let tenPage = UILabel()
    
    let questionBackground = UIView()
    
    let nameOne = UIButton()
    let nameTwo = UIButton()
    let nameThree = UIButton()
    let nameFour = UIButton()
    
    let keywordOne = UIButton()
    let keywordTwo = UIButton()
    let keywordThree = UIButton()
    let keywordFour = UIButton()
    
    let suffleButton = UIButton()
    let suffleIcon = UIImageView()
    let suffleText = UILabel()
    let suffleNum = UILabel()
    let skipButton = UIButton()
        
    override func setStyle() {
        yelloBalloon.do {
            $0.image = ImageLiterals.Voting.imgYelloBalloon1
        }
        
        yelloProgress.do {
            $0.image = ImageLiterals.Voting.imgFace1
        }
        
        numOfPage.do {
            $0.text = "1"
            $0.textColor = .black
            $0.font = .uiBody05
        }
        
        tenPage.do {
            $0.text = "of 10"
            $0.textColor = .black
            $0.font = .uiLabelLarge
        }
        
        questionBackground.do {
            $0.backgroundColor = .black
            $0.makeCornerRound(radius: 32)
        }
        
        nameOne.do {
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
            $0.roundCorners(cornerRadius: 32, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        
        nameTwo.do {
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
        }
        
        nameThree.do {
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
        }
        
        nameFour.do {
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
            $0.roundCorners(cornerRadius: 32, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }
        
        keywordOne.do {
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
            $0.roundCorners(cornerRadius: 32, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        
        keywordTwo.do {
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
        }
        
        keywordThree.do {
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
        }
        
        keywordFour.do {
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
    
    override func setLayout() {
        
        self.addSubviews(yelloBalloon,
                         yelloProgress,
                         numOfPage,
                         tenPage,
                         questionBackground,
                         nameOne,
                         nameTwo,
                         nameThree,
                         nameFour,
                         keywordOne,
                         keywordTwo,
                         keywordThree,
                         keywordFour,
                         suffleButton,
                         suffleNum,
                         skipButton)
        
        suffleButton.addSubviews(suffleIcon, suffleText, suffleNum)
        
        yelloBalloon.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        yelloProgress.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        numOfPage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(307.adjusted)
        }
        
        tenPage.snp.makeConstraints {
            $0.leading.equalTo(numOfPage.snp.trailing).offset(4.adjusted)
            $0.centerY.equalTo(numOfPage)
        }
        
        questionBackground.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
            $0.height.equalTo(154.adjusted)
        }
        
        nameOne.snp.makeConstraints {
            $0.top.equalTo(questionBackground.snp.bottom).offset(4.adjusted)
            $0.leading.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(148.adjusted)
            $0.height.equalTo(70.adjusted)
        }
        
        nameTwo.snp.makeConstraints {
            $0.top.equalTo(nameOne.snp.bottom)
            $0.leading.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(148.adjusted)
            $0.height.equalTo(70.adjusted)
        }
        
        nameThree.snp.makeConstraints {
            $0.top.equalTo(nameTwo.snp.bottom)
            $0.leading.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(148.adjusted)
            $0.height.equalTo(70.adjusted)
        }
        
        nameFour.snp.makeConstraints {
            $0.top.equalTo(nameThree.snp.bottom)
            $0.leading.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(148.adjusted)
            $0.height.equalTo(70.adjusted)
        }
        
        keywordOne.snp.makeConstraints {
            $0.top.equalTo(questionBackground.snp.bottom).offset(4.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(196.adjusted)
            $0.height.equalTo(70.adjusted)
        }
        
        keywordTwo.snp.makeConstraints {
            $0.top.equalTo(keywordOne.snp.bottom)
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(196.adjusted)
            $0.height.equalTo(70.adjusted)
        }
        
        keywordThree.snp.makeConstraints {
            $0.top.equalTo(keywordTwo.snp.bottom)
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(196.adjusted)
            $0.height.equalTo(70.adjusted)
        }
        
        keywordFour.snp.makeConstraints {
            $0.top.equalTo(keywordThree.snp.bottom)
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(196.adjusted)
            $0.height.equalTo(70.adjusted)
        }
        
        suffleButton.snp.makeConstraints {
            $0.top.equalTo(nameFour.snp.bottom).offset(10.adjusted)
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
            $0.top.equalTo(nameFour.snp.bottom).offset(10.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(192.adjusted)
            $0.height.equalTo(48.adjusted)
        }
        
    }
}
