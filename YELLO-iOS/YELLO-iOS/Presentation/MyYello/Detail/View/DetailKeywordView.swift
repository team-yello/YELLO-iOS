//
//  DetailKeywordView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class DetailKeywordView: BaseView {

    // MARK: - Variables
    // MARK: Component
    let nameKeywordLabel = UILabel()
    let keywordView = UIView()
    let keywordBackView = UIView(frame: CGRect(x: 0, y: 0, width: 143, height: 34))
    let keywordLabel = UILabel()
    let keywordHeadLabel = UILabel()
    let keywordFootLabel = UILabel()

    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black
        self.makeCornerRound(radius: 32)
        
        nameKeywordLabel.do {
            $0.setTextWithLineHeight(text: "", lineHeight: 24)
            $0.font = .uiLarge
            $0.textColor = .white
        }
        
        keywordBackView.do {
            $0.backgroundColor = UIColor(hex: "212529", alpha: 0.6)
            $0.makeCornerRound(radius: 6)
            $0.addDottedBorder()
        }
        
        keywordLabel.do {
            $0.backgroundColor = .yelloMain500
            $0.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -60)
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Detail.sender, lineHeight: 20)
            $0.font = .uiSenderLabel
            $0.textColor = UIColor(hex: "000000")
        }
        
        keywordHeadLabel.do {
            $0.text = ""
            $0.font = .uiLarge
            $0.textColor = .white
        }
        
        keywordFootLabel.do {
            $0.text = ""
            $0.font = .uiLarge
            $0.textColor = .white
        }
    }
    
    override func setLayout() {
        self.addSubviews(nameKeywordLabel,
                         keywordView)
        
        keywordView.addSubviews(keywordBackView,
                                keywordLabel,
                                keywordHeadLabel,
                                keywordFootLabel)
        
        nameKeywordLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36)
            $0.height.equalTo(32)
            $0.centerX.equalToSuperview()
        }
        
        keywordView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(36)
            $0.centerX.equalToSuperview()
        }
        
        keywordHeadLabel.snp.makeConstraints {
            $0.top.leading.equalTo(keywordView)
            $0.centerY.equalTo(keywordBackView)
            $0.trailing.equalTo(keywordBackView.snp.leading).offset(-10)
        }
        
        keywordBackView.snp.makeConstraints {
            $0.top.height.equalTo(keywordView)
            $0.width.equalTo(143)
            $0.height.equalTo(34)
        }
        
        keywordLabel.snp.makeConstraints {
            $0.center.equalTo(keywordBackView)
            $0.width.equalTo(143)
            $0.height.equalTo(30)
        }
        
        keywordFootLabel.snp.makeConstraints {
            $0.centerY.trailing.equalTo(keywordView)
            $0.leading.equalTo(keywordBackView.snp.trailing).inset(-10)
        }
    }
}
