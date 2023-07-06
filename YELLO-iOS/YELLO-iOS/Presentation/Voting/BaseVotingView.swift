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

    let whiteLabel = UILabel()
    let grayLabel = UILabel()
    let yelloImage = UIImageView()
    let yellowButton = UIButton()
    
    override func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        whiteLabel.do {
            $0.textColor = .white
            $0.font = .uiHeadline03
        }
        
        grayLabel.do {
            $0.textColor = .grayscales500
            $0.font = .uiBodySmall
        }
        
        yelloImage.do {
            $0.makeBorder(width: 1, color: .grayscales700)
        }
        
        yellowButton.do {
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .uiSubtitle03
            $0.backgroundColor = .yelloMain500
            $0.makeCornerRound(radius: 8)
            
        }
    }
    
    private func setLayout() {
        self.addSubviews(whiteLabel,
                         grayLabel,
                         yelloImage,
                         yellowButton)
        
        whiteLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        grayLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        yelloImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        yellowButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(343.adjusted)
            $0.height.equalTo(48.adjusted)
        }
    }

}
