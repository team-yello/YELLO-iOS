//
//  ReasonCollectionViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 1/23/24.
//

import UIKit

import SnapKit
import Then

final class ReasonCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "ReasonCollectionViewCell"
    
    let reasonView = UIView()
    let unselectedView = UIView()
    let selectedView = UIView()
    let descriptionLabel = UILabel()
    let etcTextView = UITextView()
    
    var isReasonSelected = false {
        didSet {
            setButtonStyle()
        }
    }
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        reasonView.do {
            $0.makeCornerRound(radius: 8.adjustedHeight)
            $0.backgroundColor = .grayscales900
            $0.isUserInteractionEnabled = true
        }
        
        unselectedView.do {
            $0.makeCornerRound(radius: 9.adjusted)
            $0.makeBorder(width: 2, color: .grayscales700)
            $0.isUserInteractionEnabled = false
        }
        
        selectedView.do {
            $0.makeCornerRound(radius: 4.adjusted)
            $0.backgroundColor = .white
            $0.isHidden = true
            $0.isUserInteractionEnabled = false
        }
        
        descriptionLabel.do {
            $0.textColor = .white
            $0.font = .uiBodyLarge
            $0.isUserInteractionEnabled = false
        }
        
        etcTextView.do {
            $0.text = StringLiterals.Profile.WithdrawalReason.etcReason
            $0.font = .uiBody02
            $0.textColor = .grayscales600
            $0.textAlignment = .left
            $0.makeCornerRound(radius: 8.adjustedHeight)
            $0.backgroundColor = .grayscales800
            $0.isHidden = true
            $0.textContainerInset = UIEdgeInsets(top: 12.adjustedHeight, left: 14.adjustedWidth, bottom: 12.adjustedHeight, right: 14.adjustedWidth)
            $0.isUserInteractionEnabled = true
            $0.accessibilityRespondsToUserInteraction = true
        }
    }
    
    private func setLayout() {
        self.addSubviews(reasonView)
        reasonView.addSubviews(unselectedView,
                               descriptionLabel,
                               etcTextView)
        
        unselectedView.addSubview(selectedView)
        
        reasonView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width - 68.adjustedWidth)
            $0.height.equalTo(56.adjustedHeight)
        }
        
        unselectedView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.adjustedHeight)
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
            $0.width.height.equalTo(18.adjusted)
        }
        
        selectedView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(8.adjusted)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerY.equalTo(unselectedView)
            $0.leading.equalTo(unselectedView.snp.trailing).offset(8.adjustedWidth)
        }
        
        etcTextView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(45.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(76.adjustedHeight)
            $0.width.equalTo(275.adjustedWidth)
            $0.bottom.equalToSuperview().inset(20.adjustedHeight)
        }
    }
    
    private func setButtonStyle() {
        if isReasonSelected {
            reasonView.do {
                $0.backgroundColor = .black
                $0.makeBorder(width: 1, color: .white)
            }
            
            selectedView.isHidden = false
        } else {
            reasonView.do {
                $0.backgroundColor = .grayscales900
                $0.makeBorder(width: 0, color: .clear)
            }
            
            selectedView.isHidden = true
        }
    }
    
    func setTextView(isEtc: Bool) {
        etcTextView.isHidden = !isEtc
        if isEtc {
            reasonView.snp.updateConstraints {
                $0.width.equalTo(UIScreen.main.bounds.width - 68.adjustedWidth)
                $0.height.equalTo(141.adjustedHeight)
            }
            etcTextView.becomeFirstResponder()
            
        } else {
            reasonView.snp.updateConstraints {
                $0.width.equalTo(UIScreen.main.bounds.width - 68.adjustedWidth)
                $0.height.equalTo(56.adjustedHeight)
            }
        }
    }
    
    func dataBind(data: String) {
        self.descriptionLabel.text = data
    }
}
