//
//  InfoView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 1/24/24.
//

import UIKit

import Then
import SnapKit

final class InfoView: UIView {
    
    // MARK: - Variables
    // MARK: Component
    let infoLabel = UILabel()
    let descriptionLabel = UILabel()
    let stackView = UIStackView()
    
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
        self.do {
            $0.makeCornerRound(radius: 12.adjusted)
            $0.backgroundColor = .grayscales900
        }
        
        infoLabel.do {
            $0.font = .uiHeadline02
            $0.textColor = .white
        }
        
        descriptionLabel.do {
            $0.font = .uiLabelMedium
            $0.textColor = .grayscales500
        }
        
        stackView.do {
            $0.addArrangedSubviews(infoLabel, descriptionLabel)
            $0.axis = .vertical
            $0.alignment = .center
        }
    }
    
    private func setLayout() {
        self.addSubviews(stackView)
        
        self.snp.makeConstraints {
            $0.width.equalTo(109.adjustedWidth)
            $0.height.equalTo(68.adjustedHeight)
        }
        
        stackView.snp.makeConstraints {
            $0.height.equalTo(45.adjustedHeight)
            $0.center.equalToSuperview()
        }
    }
    
}
