//
//  FriendCountView.swift
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
    let countStackView = UIStackView()
    private let friendNumberLabel = UILabel()
    let friendCountLabel = UILabel()
    let skeletonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 65, height: 16.adjustedHeight))
    
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
            $0.setTextWithLineHeight(text: StringLiterals.Profile.FriendCount.myFriend, lineHeight: 22.adjustedHeight)
            $0.font = .uiSubtitle02
            $0.textColor = .white
        }
        
        countStackView.do {
            $0.addArrangedSubviews(friendNumberLabel, friendCountLabel)
            $0.axis = .horizontal
            $0.spacing = 4
        }
        
        friendNumberLabel.do {
            $0.text = StringLiterals.Profile.FriendCount.friendNumber
            $0.font = .uiLabelLarge
            $0.textColor = .grayscales500
        }
        
        friendCountLabel.do {
            $0.text = "0명"
            $0.font = .uiLabelLarge
            $0.textColor = .grayscales300
            $0.asColor(targetString: "명", color: .grayscales500)
        }

        skeletonLabel.do {
            $0.backgroundColor = .grayscales800
            $0.makeCornerRound(radius: 2.adjustedHeight)
        }
    }
    
    private func setLayout() {
        self.addSubviews(myFriendLabel,
                         countStackView,
                         skeletonLabel)
        
        self.snp.makeConstraints {
            $0.height.equalTo(22.adjustedHeight)
            $0.width.equalTo(343.adjustedWidth)
        }
        
        myFriendLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        countStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6.adjustedHeight)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(16.adjustedHeight)
        }
        
        skeletonLabel.snp.makeConstraints {
            $0.center.equalTo(countStackView)
            $0.height.equalTo(16.adjustedHeight)
            $0.width.equalTo(countStackView)
        }
    }
}
