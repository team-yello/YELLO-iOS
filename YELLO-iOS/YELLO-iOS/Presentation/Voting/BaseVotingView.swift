//
//  BaseVotingView.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

class BaseVotingView: BaseView {

    // 컴포넌트 위치 순서대로
    let topOfMyPoint = UIButton()
    
    let titleLabel = UILabel()
    let textLabel = UILabel()
    
    let plusPoint = UILabel()
    let yelloImage = UIImageView()
    
    let grayView = UIView()
    let myPointText = UIButton()
    let realMyPoint = UILabel()
    let engPoint = UILabel()
    
    let yellowButton = UIButton()
    
    override func setUI() {
        setStyle()
        setLayout()
    }
    
    // MARK: - Style
    
    private func setStyle() {
        topOfMyPoint.do {
            $0.setTitle("  2900", for: .normal)
            $0.setImage(ImageLiterals.Voting.icPoint, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.titleLabel?.font = .uiBodyMedium
            $0.contentHorizontalAlignment = .center
            $0.semanticContentAttribute = .forceLeftToRight
        }
        
        titleLabel.do {
            $0.textColor = .white
            $0.font = .uiHeadline03
        }
        
        textLabel.do {
            $0.textColor = .grayscales500
            $0.font = .uiBodySmall
        }
        
        plusPoint.do {
            $0.textColor = .white
            $0.font = .uiPointLabel
        }
        
        yelloImage.do {
            $0.makeBorder(width: 1, color: .grayscales700)
        }
        
        grayView.do {
            $0.backgroundColor = UIColor(hex: "293036")
            $0.makeCornerRound(radius: 8)
        }

        myPointText.do {
            $0.setTitle("  내 포인트", for: .normal)
            $0.setImage(ImageLiterals.Voting.icPoint, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.titleLabel?.font = .uiBodyMedium
            $0.contentHorizontalAlignment = .center
            $0.semanticContentAttribute = .forceLeftToRight
        }
        
        realMyPoint.do {
            $0.textColor = .white
            $0.font = .uiSubtitle03
        }
        
        engPoint.do {
            $0.textColor = .grayscales400
            $0.font = .uiBodyMedium
        }
        
        yellowButton.do {
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .uiSubtitle03
            $0.backgroundColor = .yelloMain500
            $0.makeCornerRound(radius: 8)
        }
    }
    
    // MARK: - Layout
    
    private func setLayout() {
        self.addSubviews(topOfMyPoint,
                         titleLabel,
                         textLabel,
                         plusPoint,
                         yelloImage,
                         grayView,
                         yellowButton)
        
        grayView.addSubviews(myPointText,
                             realMyPoint,
                             engPoint)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        plusPoint.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        yelloImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        grayView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        myPointText.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.adjusted)
            $0.centerY.equalToSuperview()
        }
    
        realMyPoint.snp.makeConstraints {
            $0.trailing.equalTo(engPoint.snp.leading).offset(-4.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        engPoint.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        yellowButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(343.adjusted)
            $0.height.equalTo(48.adjusted)
        }
    }
}
