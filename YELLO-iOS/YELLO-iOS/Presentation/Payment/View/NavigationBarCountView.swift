//
//  NavigationBarCountView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2/16/24.
//

import UIKit

import SnapKit
import Then

final class NavigationBarCountView: UIView {
    // MARK: - Variables
    // MARK: Component
    let iconImageView = UIImageView()
    let countLabel = UILabel()
    
    // MARK: - Function
    // MARK: LifeCycle
    init(image: UIImage, count: String) {
        super.init(frame: .zero)
        iconImageView.image = image
        countLabel.text = count
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
        self.do {
            $0.backgroundColor = .grayscales900
            $0.makeCornerRound(radius: 16.adjustedHeight)
        }
        
        countLabel.do {
            $0.font = .uiBodySmall
            $0.textColor = .white
        }
        
    }
    
    private func setLayout() {
        self.addSubviews(iconImageView,
                         countLabel)
        
        self.snp.makeConstraints {
            $0.width.equalTo(countLabel.snp.width).offset(45.adjustedWidth)
            $0.height.equalTo(32.adjustedHeight)
        }
        
        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10.adjustedWidth)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconImageView.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(10.adjustedWidth)
        }
    }
}
