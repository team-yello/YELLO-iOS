//
//  FriendSearchTableViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/03.
//

import UIKit

import SnapKit
import Then

// MARK: - Protocol
protocol HandleSearchAddFriendButton: AnyObject {
    func addButtonTapped()
}

final class FriendSearchTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "FriendSearchTableViewCell"
    
    // MARK: Component
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let yelloIdLabel = UILabel()
    let schoolLabel = UILabel()
    let addButton = UIButton()
    let myFriendLabel = UILabel()
    
    weak var handleSearchAddFriendButton: HandleSearchAddFriendButton?
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - extension
extension FriendSearchTableViewCell {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
        
        separatorInset.left = 14
        separatorInset.right = 14
        selectionStyle = .default
        
        profileImageView.do {
            $0.image = ImageLiterals.Profile.imgDefaultProfile
            $0.contentMode = .scaleAspectFill
            $0.makeCornerRound(radius: 21)
        }
        
        nameLabel.do {
            $0.font = .uiSubtitle01
            $0.setTextWithLineHeight(text: "김옐로", lineHeight: 24)
            $0.textColor = .white
        }
        
        yelloIdLabel.do {
            $0.setTextWithLineHeight(text: "@qwerty", lineHeight: 15)
            $0.font = .uiLabelMedium
            $0.textColor = .yelloMain700
        }
        
        schoolLabel.do {
            $0.font = .uiLabelMedium
            $0.setTextWithLineHeight(text: "옐로대학교 옐로학과 23학번", lineHeight: 15)
            $0.textColor = .grayscales600
        }
        
        addButton.do {
            $0.setImage(ImageLiterals.Recommending.icAddFriendButton, for: .normal)
            $0.tintColor = .yellow
            $0.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        }
        
        myFriendLabel.do {
            $0.font = .uiButton02
            $0.setTextWithLineHeight(text: StringLiterals.Recommending.Search.myFriend, lineHeight: 16)
            $0.textColor = .grayscales600
            $0.isHidden = true
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(
            profileImageView,
            nameLabel,
            yelloIdLabel,
            schoolLabel,
            addButton,
            myFriendLabel
        )
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(8)
            $0.width.height.equalTo(42)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
        }
        
        yelloIdLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalTo(nameLabel)
        }
        
        schoolLabel.snp.makeConstraints {
            $0.top.equalTo(yelloIdLabel.snp.bottom).offset(4)
            $0.leading.equalTo(nameLabel)
        }
        
        addButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
        }
        
        myFriendLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(25)
        }
    }
    
    // MARK: Custom Function
    func configureFriendCell(_ model: FriendModel) {
        nameLabel.text = model.friends.name
        schoolLabel.text = model.friends.group
        if model.friends.profileImage != StringLiterals.Recommending.Title.defaultProfileImageLink {
            profileImageView.kfSetImage(url: model.friends.profileImage)
        }
    }
    
    func updateAddButtonImage() {
        
    }
    
    // MARK: Objc Function
    @objc private func addButtonTapped(_ sender: UIButton) {
        addButton.isHidden = true
        myFriendLabel.isHidden = false
        handleSearchAddFriendButton?.addButtonTapped()
    }
}
