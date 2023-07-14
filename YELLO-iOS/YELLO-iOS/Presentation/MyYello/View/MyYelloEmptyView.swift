//
//  MyYelloEmptyView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyYelloEmptyView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let emptyImageView = UIImageView()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Empty.title, lineHeight: 24)
            $0.font = .uiSubtitle01
            $0.textColor = .white
        }
        
        descriptionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Empty.description, lineHeight: 20)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales500
        }
        
        emptyImageView.do {
            $0.image = ImageLiterals.MyYello.imgMyYelloEmpty
        }
    }
    
    override func setLayout() {
        self.addSubviews(titleLabel,
                         descriptionLabel,
                         emptyImageView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        emptyImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(39.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(288.adjustedHeight)
            $0.height.equalTo(272.adjustedHeight)
        }
    }
}
