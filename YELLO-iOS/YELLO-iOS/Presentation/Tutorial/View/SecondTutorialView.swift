//
//  SecondTutorialView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/15.
//

import UIKit

import SnapKit
import Then
import Lottie

final class SecondTutorialView: UIView {
    // MARK: - Variables
    // MARK: Component
    let tutorialImageView = UIImageView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        let screenHeight = UIScreen.main.bounds.height
        
        tutorialImageView.do {
            $0.contentMode = .scaleAspectFill
            if screenHeight < 812 {
                $0.image = ImageLiterals.Tutorial.tutorial2
            } else if screenHeight == 812 {
                $0.image = ImageLiterals.Tutorial.tutorialLong2
            } else {
                $0.image = ImageLiterals.Tutorial.tutorialMaxLong2
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
