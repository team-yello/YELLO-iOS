//
//  InfoView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 1/24/24.
//

import UIKit

import Then
import SnapKit

class InfoView: UIView {
    
    let infoLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI(){
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
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 30.adjustedHeight)
        }
        
        descriptionLabel.do {
            $0.font = .uiLabelMedium
            $0.textColor = .grayscales500
        }
    }
    
    private func setLayout() {
        self.addSubviews(infoLabel, descriptionLabel)
        
        self.snp.makeConstraints {
            $0.width.equalTo(109.adjustedWidth)
            $0.height.equalTo(68.adjustedHeight)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
    
}
