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
    let skipButton = UIButton()
    
    let button = UIButton()

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
        
        button.do {
            $0.setTitle("클릭", for: .normal)
        }

    }
    
    override func setLayout() {

        self.addSubviews(yelloBalloon,
                         yelloProgress,
                         numOfPage,
                         tenPage,
                         questionBackground,
                         button)
        
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
        
        button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
}
