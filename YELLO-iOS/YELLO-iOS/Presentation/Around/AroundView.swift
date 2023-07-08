//
//  AroundView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/06.
//

import UIKit

import SnapKit
import Then

// MARK: - Around
final class AroundView: UIView {
    
    // MARK: - Variables
    // MARK: Component
    private let aroundLabel = UILabel()
    private let aroundDescriptionLabel = UILabel()
    private let aroundImageView = UIImageView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - extension
extension AroundView {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
        
        aroundLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Around.around, lineHeight: 28)
            $0.font = .uiHeadline03
            $0.textColor = .white
        }
        
        aroundDescriptionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Around.aroundDescription, lineHeight: 20)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales500
            $0.numberOfLines = 2
            $0.textAlignment = .center
        }
        
        aroundImageView.do {
            $0.makeBorder(width: 1, color: .grayscales700)
        }
    }
    
    private func setLayout() {
        self.addSubviews(
            aroundLabel,
            aroundDescriptionLabel,
            aroundImageView
        )
        
        aroundLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(120.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        aroundDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(aroundLabel.snp.bottom).offset(24.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        aroundImageView.snp.makeConstraints {
            $0.height.width.equalTo(230.adjusted)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(15.adjusted)
            
        }
        
    }
}
