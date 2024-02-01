//
//  ReasonHeaderView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 1/25/24.
//

import UIKit

import SnapKit
import Then

final class ReasonHeaderView: UICollectionReusableView {
    static let identifier = "ReasonHeaderView"
    
    let titleLabel = UILabel()
    
    func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.WithdrawalReason.title, lineHeight: 32.adjustedHeight)
            $0.font = .uiHeadline01
            $0.textColor = .white
        }
    }
    
    private func setLayout() {
        self.addSubviews(titleLabel)
        
        self.snp.makeConstraints {
            $0.height.equalTo(91.adjustedHeight)
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(39.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
    }
}
