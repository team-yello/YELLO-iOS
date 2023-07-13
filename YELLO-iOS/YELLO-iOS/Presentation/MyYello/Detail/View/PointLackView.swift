//
//  PointLackView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/13.
//

import UIKit

import SnapKit
import Then

final class PointLackView: BaseView {
    
    let contentsView = UIView()
    
    let closeButton = UIButton()
    
    let titleLabel = UILabel()
    
    let pointView = UIView()
    let pointImageView = UIImageView()
    let pointTitleLabel = UILabel()
    let pointLabel = UILabel()
    let pointTextLabel = UILabel()
    
    lazy var yelloButton = UIButton()
    // MARK: - Style
    
    override func setStyle() {
        self.backgroundColor = .black.withAlphaComponent(0.7)
        
        contentsView.makeCornerRound(radius: 12)
        contentsView.backgroundColor = .grayscales900
        
        closeButton.do {
            $0.setImage(ImageLiterals.InvitingPopUp.icClose, for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Alert.pointLack, lineHeight: 24)
            $0.textColor = .white
            $0.font = .uiSubtitle02
        }
        
        pointView.do {
            $0.backgroundColor = UIColor(hex: "293036")
            $0.makeCornerRound(radius: 8)
        }
        
        pointImageView.do {
            $0.image = ImageLiterals.MyYello.icPoint
        }
        
        pointTitleLabel.do {
            $0.text = StringLiterals.MyYello.Alert.myPoint
            $0.textColor = .white
            $0.font = .uiBodySmall
        }
        
        pointLabel.do {
            $0.setTextWithLineHeight(text: "2350", lineHeight: 20)
            $0.textColor = .white
            $0.font = .uiKeywordBold
        }
        
        pointTextLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Alert.point, lineHeight: 20)
            $0.textColor = .grayscales400
            $0.font = .uiBodySmall
        }
        
        yelloButton.do {
            $0.backgroundColor = .yelloMain500
            $0.layer.cornerRadius = 8
            $0.titleLabel?.font = .uiButton
            $0.setTitleColor(.black, for: .normal)
            $0.setTitle(StringLiterals.MyYello.Alert.yelloButton, for: .normal)
            $0.addTarget(self, action: #selector(yelloButtonTapped), for: .touchUpInside)
        }
    }
    
    // MARK: - Layout
    
    override func setLayout() {
        self.addSubview(contentsView)
        
        contentsView.addSubviews(closeButton,
                                 titleLabel,
                                 pointView,
                                 yelloButton)
        
        pointView.addSubviews(pointImageView,
                              pointTitleLabel,
                              pointLabel,
                              pointTextLabel)
        
        contentsView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(280)
            $0.height.equalTo(236)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        pointView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(18.adjusted)
            $0.top.equalTo(titleLabel.snp.bottom).offset(12.adjusted)
            $0.height.equalTo(52)
        }
        
        pointImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        pointTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(pointImageView)
            $0.leading.equalTo(pointImageView.snp.trailing).inset(-4)
        }
        
        pointLabel.snp.makeConstraints {
            $0.trailing.equalTo(pointTextLabel.snp.leading).inset(-4)
            $0.centerY.equalToSuperview()
        }
        
        pointTextLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        yelloButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().inset(32)
            $0.centerX.equalToSuperview()
        }
    }
}

extension PointLackView {
    
    @objc
    func closeButtonClicked() {
        self.isHidden = true
        self.removeFromSuperview()
    }
    
    @objc
    func yelloButtonTapped() {
        
    }
}
