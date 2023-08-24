//
//  TutorialView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/15.
//

import UIKit

import SnapKit
import Then
import Lottie

final class FirstTutorialView: UIView {
    
    let tutorialImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        let screenHeight = UIScreen.main.bounds.height
        
        tutorialImageView.do {
            $0.contentMode = .scaleAspectFill
            if screenHeight < 812 {
                $0.image = ImageLiterals.Tutorial.tutorial1
            } else if screenHeight == 812 {
                $0.image = ImageLiterals.Tutorial.tutorialLong1
            } else {
                $0.image = ImageLiterals.Tutorial.tutorialMaxLong1
            }
        }
    }
    
    private func setLayout() {
        self.addSubviews(tutorialImageView)
        tutorialImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
