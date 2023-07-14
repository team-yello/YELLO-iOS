//
//  TitleView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/14.
//

import UIKit

import Lottie
import Then
import SnapKit

class SplashTitleView: BaseView {
    // MARK: - Variables
    // MARK: Component
    let animationView = LottieAnimationView(name: "splash")
    let subTitleView = UILabel()
    let stackView = UIStackView()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        animationView.do {
            $0.play()
            $0.loopMode = .loop
        }
        
        subTitleView.do {
            $0.text = "지금 누군가 당신을 생각하고 있어요!"
            $0.font = .uiBodySmall
            $0.textColor = .white
        }
        
        stackView.do {
            $0.addArrangedSubviews(animationView, subTitleView)
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 12
        }
    }
    
    override func setLayout() {
        self.addSubviews(stackView)
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
