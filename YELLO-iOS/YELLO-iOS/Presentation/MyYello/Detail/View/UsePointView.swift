//
//  UsePointView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/13.
//

import UIKit

import SnapKit
import Then

protocol HandleConfirmButtonDelegate: AnyObject {
    func confirmButtonTapped()
}

final class UsePointView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    let contentsView = UIView()
    let titleLabel = UILabel()
    let pointView = UIView()
    let pointImageView = UIImageView()
    let pointTitleLabel = UILabel()
    var pointLabel = UILabel()
    let pointTextLabel = UILabel()
    var getHintView: GetHintView?
    lazy var noButton = UIButton()
    lazy var confirmButton = UIButton()
    
    // MARK: Property
    weak var handleConfirmButtonDelegate: HandleConfirmButtonDelegate?
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black.withAlphaComponent(0.7)
        
        contentsView.makeCornerRound(radius: 12)
        contentsView.backgroundColor = .grayscales900
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: "100" + StringLiterals.MyYello.Alert.keywordPoint, lineHeight: 24)
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
        
        confirmButton.do {
            $0.backgroundColor = .yelloMain500
            $0.layer.cornerRadius = 8
            $0.titleLabel?.font = .uiButton
            $0.setTitleColor(.black, for: .normal)
            $0.setTitle(StringLiterals.MyYello.Alert.keywordButton, for: .normal)
            $0.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        }
        
        noButton.do {
            $0.backgroundColor = .clear
            $0.titleLabel?.font = .uiButton
            $0.setTitleColor(.grayscales500, for: .normal)
            $0.setTitle(StringLiterals.MyYello.Alert.noButton, for: .normal)
            $0.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        self.addSubview(contentsView)
        
        contentsView.addSubviews(noButton,
                                 titleLabel,
                                 pointView,
                                 confirmButton)
        
        pointView.addSubviews(pointImageView,
                              pointTitleLabel,
                              pointLabel,
                              pointTextLabel)
        
        contentsView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(280)
            $0.height.equalTo(252)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
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
        
        confirmButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().inset(40)
            $0.leading.equalTo(noButton.snp.trailing).inset(-8)
        }
        
        noButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.height.equalTo(40)
            $0.width.equalTo(90)
            $0.bottom.equalTo(confirmButton)
        }
    }
}

// MARK: - extension
extension UsePointView {
    
    // MARK: Objc Function
    @objc func noButtonTapped() {
        self.isHidden = true
        self.removeFromSuperview()
    }
    
    @objc func confirmButtonTapped() {
        noButtonTapped()
        handleConfirmButtonDelegate?.confirmButtonTapped()
    }
}
