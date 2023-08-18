//
//  SplashViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/14.
//

import UIKit

import Lottie
import SnapKit
import Then

class SplashViewController: BaseViewController {
    // MARK: - Variables
    // MARK: Component
    let splashTitleView = SplashTitleView()
    let yelloImageView = UIImageView()
    
    override func setStyle() {
        yelloImageView.do {
            $0.image = ImageLiterals.Splash.splashYelloFace
        }
    }
    
    override func setLayout() {
        view.addSubviews(splashTitleView, yelloImageView)
        
        splashTitleView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(yelloImageView.snp.top)
        }
        
        yelloImageView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
