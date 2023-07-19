//
//  MyYelloNavigationBarView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyYelloNavigationBarView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    private let titleLabel = UILabel()
    private let yelloNumberLabel = UILabel()
    let yelloCountLabel = UILabel()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.NavigationBar.myYello, lineHeight: 28)
            $0.font = .uiHeadline03
            $0.textColor = .white
        }
        
        yelloNumberLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.NavigationBar.yelloNumber, lineHeight: 16)
            $0.font = .uiLabelLarge
            $0.textColor = .grayscales500
        }
        
        yelloCountLabel.do {
            $0.setTextWithLineHeight(text: "개", lineHeight: 16)
            $0.font = .uiLabelLarge
            $0.textColor = .grayscales200
            $0.asColor(targetString: "개", color: .grayscales500)
        }
    }
    
    override func setLayout() {
        self.addSubviews(titleLabel,
                         yelloNumberLabel,
                         yelloCountLabel)
        
        self.snp.makeConstraints {
            $0.height.equalTo(74)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
        }
        
        yelloNumberLabel.snp.makeConstraints {
            $0.centerY.equalTo(yelloCountLabel)
            $0.trailing.equalTo(yelloCountLabel.snp.leading).inset(-4.adjusted)
        }
        
        yelloCountLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(5.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjusted)
        }
    }

}
