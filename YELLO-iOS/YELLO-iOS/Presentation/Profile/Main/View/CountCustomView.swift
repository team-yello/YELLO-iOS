//
//  CountCustomView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class CountCustomView: UIView {
    
    // MARK: - Variables
    // MARK: Component
    var countLabel = UILabel()
    var titleLabel = UILabel()
    
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
extension CountCustomView {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        countLabel.do {
            $0.setTextWithLineHeight(text: "0", lineHeight: 30)
            $0.font = .uiHeadline02
            $0.textColor = .white
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Count.message, lineHeight: 15)
            $0.font = .uiLabelMedium
            $0.textColor = .grayscales500
        }
        
    }
    
    private func setLayout() {
        self.addSubviews(countLabel,
                        titleLabel)
        
        self.snp.makeConstraints {
            $0.height.equalTo(64.adjustedHeight)
            $0.width.equalTo(84.adjustedWidth)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(9.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(countLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
    }
}
