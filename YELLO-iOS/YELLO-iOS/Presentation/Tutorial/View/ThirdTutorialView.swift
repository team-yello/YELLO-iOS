//
//  ThirdTutorialView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/15.
//

import UIKit

import SnapKit
import Then

final class ThirdTutorialView: UIView {
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
                $0.image = ImageLiterals.Tutorial.tutorial3
            } else if screenHeight == 812 {
                $0.image = ImageLiterals.Tutorial.tutorialLong3
            } else {
                $0.image = ImageLiterals.Tutorial.tutorialMaxLong3
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
