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
    
    let name1 = UIButton()
    let name2 = UIButton()
    let name3 = UIButton()
    let name4 = UIButton()
    
    let keyword1 = UIButton()
    let keyword2 = UIButton()
    let keyword3 = UIButton()
    let keyword4 = UIButton()

    let suffleButton = UIButton()
    let skipButton = UIButton()
    
    let button = UIButton()

    override func setStyle() {
        yelloBalloon.do {
            $0.image = ImageLiterals.Voting.imgYelloBalloon1
        }
        button.do {
            $0.setTitle("클릭", for: .normal)
        }

    }
    
    override func setLayout() {

        self.addSubviews(yelloBalloon, button)
        
        yelloBalloon.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
}
