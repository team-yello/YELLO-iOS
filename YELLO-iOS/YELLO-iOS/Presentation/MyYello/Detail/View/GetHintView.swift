//
//  GetHintView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/13.
//

import UIKit

import SnapKit
import Then

final class GetHintView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    let contentsView = UIView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let hintLabel = BasePaddingLabel()
    let pointView = UIView()
    let pointImageView = UIImageView()
    let pointTitleLabel = UILabel()
    let pointLabel = UILabel()
    let pointTextLabel = UILabel()
    lazy var confirmButton = UIButton()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black.withAlphaComponent(0.7)
        
        contentsView.makeCornerRound(radius: 12)
        contentsView.backgroundColor = .grayscales900
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Alert.keywordTitle, lineHeight: 24)
            $0.textColor = .white
            $0.font = .uiSubtitle02
        }
        
        descriptionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Alert.senderDescription, lineHeight: 15)
            $0.textColor = .grayscales400
            $0.font = .uiLabelMedium
        }
        
        hintLabel.do {
            $0.backgroundColor = .yelloMain500
            $0.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -60)
            $0.setTextWithLineHeight(text: "모르는 척 하고", lineHeight: 24)
            $0.font = .uiBodyLarge
            $0.textColor = UIColor(hex: "000000")
        }
        
        pointView.do {
            $0.backgroundColor = UIColor(hex: "293036")
            $0.makeCornerRound(radius: 8)
        }
        
        pointImageView.do {
            $0.image = ImageLiterals.MyYello.icPoint
        }
        
        pointTitleLabel.do {
            $0.text = StringLiterals.MyYello.Alert.afterPoint
            $0.textColor = .white
            $0.font = .uiBodySmall
        }
        
        pointLabel.do {
            $0.setTextWithLineHeight(text: "2050", lineHeight: 20)
            $0.textColor = .white
            $0.font = .uiKeywordBold
        }
        
        pointTextLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Alert.point, lineHeight: 20)
            $0.textColor = .grayscales400
            $0.font = .uiBodySmall
        }
        
        confirmButton.do {
            $0.backgroundColor = .clear
            $0.titleLabel?.font = .uiButton
            $0.setTitleColor(.grayscales300, for: .normal)
            $0.setTitle(StringLiterals.MyYello.Alert.confirmButton, for: .normal)
            $0.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        self.addSubview(contentsView)
        
        contentsView.addSubviews(titleLabel,
                                 descriptionLabel,
                                 hintLabel,
                                 pointView,
                                 confirmButton)
        
        pointView.addSubviews(pointImageView,
                              pointTitleLabel,
                              pointLabel,
                              pointTextLabel)
        
        contentsView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(280)
            $0.height.equalTo(270)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.centerX.equalToSuperview()
        }
        
        hintLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        pointView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(18.adjusted)
            $0.top.equalTo(hintLabel.snp.bottom).offset(36.adjusted)
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
        
        confirmButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(24)
            $0.width.equalTo(45)
            $0.bottom.equalToSuperview().inset(30)
        }
    }
}
// MARK: - extension
extension GetHintView {
    
    // MARK: Objc Function
    @objc func confirmButtonTapped() {
        self.isHidden = true
        self.removeFromSuperview()
    }
}
