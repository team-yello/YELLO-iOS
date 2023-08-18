//
//  GetFullNameView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/06.
//

import UIKit

import SnapKit
import Then

final class GetFullNameView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    let contentsView = UIView()
    let titleLabel = UILabel()
    var hintLabel = BasePaddingLabel()
    let ticketView = UIView()
    
    let ticketFrontStackView = UIStackView()
    let ticketImageView = UIImageView()
    let ticketTitleLabel = UILabel()
    
    let ticketBackStackView = UIStackView()
    var ticketLabel = UILabel()
    let ticketTextLabel = UILabel()
    lazy var confirmButton = UIButton()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black.withAlphaComponent(0.7)
        
        contentsView.makeCornerRound(radius: 12)
        contentsView.backgroundColor = .grayscales900
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Alert.getNameTitle, lineHeight: 22)
            $0.textColor = .white
            $0.font = .uiSubtitle02
        }
        
        hintLabel.do {
            $0.backgroundColor = .yelloMain500
            $0.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -60)
            $0.setTextWithLineHeight(text: " ", lineHeight: 24)
            $0.numberOfLines = 1
            $0.font = .uiBodyLarge
            $0.textColor = .black
        }
        
        ticketView.do {
            $0.backgroundColor = UIColor(hex: "293036")
            $0.makeCornerRound(radius: 8)
        }
        
        ticketFrontStackView.do {
            $0.addArrangedSubviews(ticketImageView, ticketTitleLabel)
            $0.axis = .horizontal
            $0.spacing = 4
        }
        
        ticketImageView.do {
            $0.image = ImageLiterals.MyYello.icKeyWhite
        }
        
        ticketTitleLabel.do {
            $0.text = StringLiterals.MyYello.Alert.leftTicketCount
            $0.textColor = .white
            $0.font = .uiBodySmall
        }
        
        ticketBackStackView.do {
            $0.addArrangedSubviews(ticketLabel, ticketTextLabel)
            $0.axis = .horizontal
            $0.spacing = 2
        }
        
        ticketLabel.do {
            $0.textColor = .white
            $0.font = .uiKeywordBold
            $0.textAlignment = .right
        }
        
        ticketTextLabel.do {
            $0.text = StringLiterals.MyYello.Alert.count
            $0.textColor = .grayscales400
            $0.font = .uiBodySmall
        }
        
        confirmButton.do {
            $0.backgroundColor = .clear
            $0.titleLabel?.font = .uiButton
            $0.setTitleColor(.grayscales500, for: .normal)
            $0.setTitle(StringLiterals.MyYello.Alert.confirmButton, for: .normal)
            $0.addTarget(self, action: #selector(confirmTicketButtonTapped), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        self.addSubview(contentsView)
        
        contentsView.addSubviews(titleLabel,
                                 hintLabel,
                                 ticketView,
                                 confirmButton)
        
        ticketView.addSubviews(ticketFrontStackView,
                               ticketBackStackView)
        
        contentsView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(300)
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
        
        ticketView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.top.equalTo(hintLabel.snp.bottom).offset(44)
            $0.height.equalTo(40)
            $0.width.equalTo(170)
        }
        
        ticketFrontStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(14)
        }
        
        ticketBackStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(14)
        }
        
        confirmButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(244)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
// MARK: - extension
extension GetFullNameView {
    
    // MARK: Objc Function
    @objc func confirmTicketButtonTapped() {
        self.isHidden = true
        self.removeFromSuperview()
    }
}
