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
    
    let yelloProgressBackGroundOne = UIImageView()
    let yelloProgressBackGroundTwo = UIImageView()
    let yelloProgressBackGroundThree = UIImageView()
    let yelloProgressBackGroundFour = UIImageView()

    let numOfPageLabel = UILabel()
    let tenPageLabel = UILabel()
    
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
        
        numOfPageLabel.do {
            $0.text = "1"
            $0.textColor = .black
            $0.font = .uiBody05
        }
        
        tenPageLabel.do {
            $0.text = "of 10"
            $0.textColor = .black
            $0.font = .uiLabelLarge
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
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        let width = UIScreen.main.bounds.size.width
        
        self.addSubviews(yelloBalloon,
                         yelloProgress,
                         yelloProgressBackGroundOne,
                         yelloProgressBackGroundTwo,
                         yelloProgressBackGroundThree,
                         yelloProgressBackGroundFour,
                         numOfPageLabel,
                         tenPageLabel,
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
        
        yelloBalloon.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.safeAreaInsets).inset(statusBarHeight + 4.adjusted)
        }
        
        yelloProgress.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.safeAreaInsets).inset(statusBarHeight + 60.adjusted)
        }
        
        yelloProgressBackGroundOne.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(self.safeAreaInsets).inset(statusBarHeight + 60.adjusted)
        }
        
        yelloProgressBackGroundTwo.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width / 5)
            $0.top.equalTo(self.safeAreaInsets).inset(statusBarHeight + 60.adjusted)
        }
        
        yelloProgressBackGroundThree.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(width / 5)
            $0.top.equalTo(self.safeAreaInsets).inset(statusBarHeight + 60.adjusted)
        }
        
        yelloProgressBackGroundFour.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(self.safeAreaInsets).inset(statusBarHeight + 60.adjusted)
        }
        
        numOfPageLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(307.adjusted)
            $0.top.equalTo(self.safeAreaInsets).inset(statusBarHeight + 40.adjusted)
        }
        
        tenPageLabel.snp.makeConstraints {
            $0.leading.equalTo(numOfPageLabel.snp.trailing).offset(4.adjusted)
            $0.centerY.equalTo(numOfPageLabel)
        }
        
        questionBackground.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
            $0.height.equalTo(154.adjusted)
            $0.top.equalTo(self.safeAreaInsets).inset(statusBarHeight + 132.adjusted)
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
            $0.top.equalTo(nameFourButton.snp.bottom).offset(10.adjusted)
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
            $0.top.equalTo(nameFourButton.snp.bottom).offset(10.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.width.equalTo(192.adjusted)
            $0.height.equalTo(48.adjusted)
        }
        
    }
}
