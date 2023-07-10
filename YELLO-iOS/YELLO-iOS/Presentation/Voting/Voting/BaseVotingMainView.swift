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
        
        button.do {
            $0.setTitle("클릭", for: .normal)
        }

    }
    
    override func setLayout() {

        self.addSubviews(yelloBalloon,
                         yelloProgress,
                         button)
        
        yelloBalloon.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        yelloProgress.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
}
