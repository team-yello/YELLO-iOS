//
//  WithdrawalNoFriendView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 6/7/24.
//

import UIKit

import SnapKit
import Then

final class WithdrawalNoFriendView: BaseView {
    // MARK: - Variables
    // MARK: Property
    let contentsView = UIView()
    
    private let titleLabel = UILabel()
    private let noFriendImageView = UIImageView()
    let nextButton = UIButton()
    let wowButton = UIButton()
    
    override func setStyle() {
        // MARK: - Function
        // MARK: Layout Helpers
        self.backgroundColor = .black.withAlphaComponent(0.5)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(nextButtonTapped))
        self.addGestureRecognizer(tapGestureRecognizer)
        
        contentsView.do {
            $0.makeCornerRound(radius: 12.adjustedHeight)
            $0.backgroundColor = .grayscales900
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.WithdrawalNoFriend.title, lineHeight: 24.adjustedHeight)
            $0.font = .uiSubtitle01
            $0.textAlignment = .center
            $0.textColor = .white
        }
        
        noFriendImageView.do {
            $0.image = ImageLiterals.Withdrawal.imgWithdrawalNoFriend
        }
        
        nextButton.do {
            $0.setTitle(StringLiterals.Profile.WithdrawalNoFriend.nextLabel, for: .normal)
            $0.setTitleColor(.grayscales600, for: .normal)
            $0.titleLabel?.font = .uiButton
            $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        }
        
        wowButton.do {
            $0.setTitle(StringLiterals.Profile.WithdrawalNoFriend.wowLabel, for: .normal)
            $0.setTitleColor(.yelloMain500, for: .normal)
            $0.titleLabel?.font = .uiButton
            $0.addTarget(self, action: #selector(wowButtonTapped), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        self.addSubview(contentsView)
        
        contentsView.addSubviews(titleLabel,
                                 noFriendImageView,
                                 nextButton,
                                 wowButton)
        
        contentsView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(280.adjustedWidth)
            $0.height.equalTo(317.adjustedHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(44.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        noFriendImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100.adjusted)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(noFriendImageView.snp.bottom).offset(49.adjustedHeight)
            $0.leading.equalToSuperview().inset(38.adjustedWidth)
            $0.width.equalTo(80.adjustedWidth)
            $0.height.equalTo(40.adjustedHeight)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        wowButton.snp.makeConstraints {
            $0.top.bottom.equalTo(nextButton)
            $0.trailing.equalToSuperview().inset(38.adjustedWidth)
            $0.width.equalTo(81.adjustedWidth)
            $0.height.equalTo(40.adjustedHeight)
        }
    }
}

extension WithdrawalNoFriendView {
    @objc private func nextButtonTapped() {
        self.isHidden = true
        self.removeFromSuperview()
    }
    
    @objc private func wowButtonTapped() {
        self.isHidden = true
        self.removeFromSuperview()
        print("노티피케이션 추가")
    }
}
