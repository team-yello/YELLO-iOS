//
//  RecommendingNavigationBarView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/02.
//

import UIKit

import SnapKit
import Then

final class RecommendingNavigationBarView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    private let titleLabel = UILabel()
    lazy var searchButton = UIButton()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Recommending.Title.recommend, lineHeight: 28)
            $0.textColor = .white
            $0.font = .uiHeadline03
        }
        
        searchButton.do {
            $0.setImage(ImageLiterals.Recommending.icSearchWhite, for: .normal)
        }
    }
    
    override func setLayout() {
        self.addSubviews(titleLabel,
                         searchButton)
        
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
    }
}