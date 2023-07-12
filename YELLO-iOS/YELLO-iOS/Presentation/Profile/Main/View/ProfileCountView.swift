//
//  ProfileCountView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class FriendCountView: UIView {

    // MARK: - Variables
    // MARK: Component
    private let myFriendLabel = UILabel()
    private let friendNumberLabel = UILabel()
    private let friendCountLabel = UILabel()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - extension
extension FriendCountView {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        myFriendLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.FriendCount.myFriend, lineHeight: 22)
            $0.font = .uiSubtitle02
            $0.textColor = .white
        }
        
        friendNumberLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.FriendCount.friendNumber, lineHeight: 16)
            $0.font = .uiLabelLarge
            $0.textColor = .grayscales500
        }
        
        friendCountLabel.do {
            $0.setTextWithLineHeight(text: "10명", lineHeight: 16)
            $0.font = .uiLabelLarge
            $0.textColor = .grayscales300
            $0.asColor(targetString: "명", color: .grayscales500)
        }
    }
    
    private func setLayout() {
        self.addSubviews(myFriendLabel,
                         friendNumberLabel,
                         friendCountLabel)
        
        self.snp.makeConstraints {
            $0.height.equalTo(22.adjustedHeight)
            $0.width.equalTo(343.adjustedWidth)
        }
        
        myFriendLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        friendNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6.adjusted)
            $0.trailing.equalTo(friendCountLabel.snp.leading).offset(-4.adjusted)
        }
        
        friendCountLabel.snp.makeConstraints {
            $0.top.equalTo(friendNumberLabel)
            $0.trailing.equalToSuperview()
        }
    }
}
