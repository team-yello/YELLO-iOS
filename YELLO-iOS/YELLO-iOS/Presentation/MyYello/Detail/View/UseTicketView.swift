//
//  UseTicketView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/06.
//

import UIKit

import SnapKit
import Then

protocol HandleConfirmTicketButtonDelegate: AnyObject {
    func confirmTicketButtonTapped()
}

final class UseTicketView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    let contentsView = UIView()
    let titleLabel = UILabel()
    
    let ticketView = UIView()
    
    let ticketFrontStackView = UIStackView()
    let ticketImageView = UIImageView()
    let ticketTitleLabel = UILabel()
    
    let ticketBackStackView = UIStackView()
    var ticketLabel = UILabel()
    let ticketTextLabel = UILabel()
    
    var getFullNameView: GetFullNameView?
    
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
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Alert.useTicket, lineHeight: 22)
            $0.textAlignment = .center
            $0.textColor = .white
            $0.font = .uiSubtitle02
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
            $0.text = StringLiterals.MyYello.Alert.ticket
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
            $0.text =  StringLiterals.MyYello.Alert.count
            $0.textColor = .grayscales400
            $0.font = .uiBodySmall
        }
        
        confirmButton.do {
            $0.backgroundColor = .yelloMain500
            $0.layer.cornerRadius = 8
            $0.titleLabel?.font = .uiButton
            $0.setTitleColor(.black, for: .normal)
            $0.setTitle(StringLiterals.MyYello.Alert.ticketButton, for: .normal)
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
                                 ticketView,
                                 confirmButton)
        
        ticketView.addSubviews(ticketFrontStackView,
                               ticketBackStackView)
        
        contentsView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(280.adjustedWidth)
            $0.height.equalTo(252.adjustedHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        ticketView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(16.adjustedHeight)
            $0.width.equalTo(145.adjustedWidth)
            $0.height.equalTo(38.adjustedHeight)
        }
        
        ticketFrontStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(14.adjustedWidth)
        }
        
        ticketBackStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(14.adjustedWidth)
        }
        
        confirmButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18.adjustedWidth)
            $0.height.equalTo(40.adjustedHeight)
            $0.width.equalTo(146.adjustedWidth)
            $0.bottom.equalToSuperview().inset(40.adjustedHeight)
            $0.leading.equalTo(noButton.snp.trailing).inset(-8.adjustedWidth)
        }
        
        noButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18.adjustedWidth)
            $0.height.equalTo(40.adjustedHeight)
            $0.width.equalTo(90.adjustedWidth)
            $0.bottom.equalTo(confirmButton)
        }
    }
}

// MARK: - extension
extension UseTicketView {
    
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
