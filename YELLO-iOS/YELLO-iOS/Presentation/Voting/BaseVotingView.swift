//
//  BaseVotingView.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

final class BaseVotingView: BaseView {

    let titleLabel = UILabel()
    let textLabel = UILabel()
    let yelloImage = UIImageView()
    let yellowButton = UIButton()
    let grayView = UIView()
    
    override func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        titleLabel.do {
            $0.textColor = .white
            $0.font = .uiHeadline03
        }
        
        textLabel.do {
            $0.textColor = .grayscales500
            $0.font = .uiBodySmall
        }
        
        yelloImage.do {
            $0.makeBorder(width: 1, color: .grayscales700)
        }
        
        grayView.do {
            $0.backgroundColor = UIColor(hex: "293036")
            $0.makeCornerRound(radius: 8)
        }
        
        yellowButton.do {
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .uiSubtitle03
            $0.backgroundColor = .yelloMain500
            $0.makeCornerRound(radius: 8)
            
        }
    }
    
    private func setLayout() {
        self.addSubviews(titleLabel,
                         textLabel,
                         yelloImage,
                         grayView,
                         yellowButton)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        yelloImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        grayView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        yellowButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(343.adjustedWidth)
            $0.height.equalTo(48.adjustedHeight)
        }
    }

}
