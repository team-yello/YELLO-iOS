//
//  FriendTableViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

// MARK: - Protocol
protocol HandleAddFriendButton: AnyObject {
    func addButtonTapped(sender: UIButton)
}

final class FriendTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "FriendTableViewCell"
    
    // MARK: Component
    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 42.adjusted, height: 42.adjusted))
    let nameLabel = UILabel()
    let schoolLabel = UILabel()
    lazy var addButton = FriendAddButton()
    let separatorLine = UIView()
    var isTapped: Bool = false
    var friendId: Int = -1
    
    weak var handleAddFriendButton: HandleAddFriendButton?
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        schoolLabel.text = nil
        isTapped = false
        separatorLine.isHidden = false
        addButton.isHidden = true
        profileImageView.image = ImageLiterals.Profile.imgDefaultProfile
    }
}

// MARK: - extension
extension FriendTableViewCell {
    
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
            $0.makeCornerRound(radius: 21.adjusted)
        }
        
        nameLabel.do {
            $0.font = .uiSubtitle01
            $0.setTextWithLineHeight(text: "김옐로", lineHeight: 24.adjustedHeight)
            $0.numberOfLines = 0
            $0.textColor = .white
        }
        
        schoolLabel.do {
            $0.font = .uiLabelMedium
            $0.setTextWithLineHeight(text: "옐로대학교 옐로학과 23학번", lineHeight: 15.adjustedHeight)
            $0.numberOfLines = 0
            $0.textColor = .grayscales600
            $0.lineBreakMode = .byCharWrapping
            $0.textAlignment = .left
        }
        
        addButton.do {
            $0.setImage(ImageLiterals.Recommending.icAddFriendButton, for: .normal)
            $0.tintColor = .yellow
            $0.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            $0.isHidden = false
        }
        
        separatorLine.do {
            $0.backgroundColor = .grayscales800
        }
    }
    
    private func setLayout() {
        
        contentView.addSubviews(profileImageView,
                                nameLabel,
                                schoolLabel,
                                addButton,
                                separatorLine)
        
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8.adjustedWidth)
            $0.width.height.equalTo(42.adjusted)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17.adjustedHeight)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12.adjustedWidth)
        }
        
        schoolLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4.adjustedHeight)
            $0.leading.equalTo(nameLabel)
            $0.width.equalTo(184.adjustedWidth)
        }
        
        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8.adjustedWidth)
            $0.centerY.equalToSuperview()
        }
        
        separatorLine.snp.makeConstraints {
            $0.top.equalTo(schoolLabel.snp.bottom).offset(16.adjustedHeight)
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    func configureFriendCell(_ model: FriendModel) {
        friendId = model.friends.id
        addButton.isHidden = false
        nameLabel.text = model.friends.name
        schoolLabel.text = model.friends.group
        if model.friends.profileImage != StringLiterals.Recommending.Title.defaultProfileImageLink {
            profileImageView.kfSetImage(url: model.friends.profileImage)
        }
        isTapped = model.isButtonSelected
        updateAddButtonImage()
    }
    
    func updateAddButtonImage() {
        addButton.setImage(isTapped ? ImageLiterals.Recommending.icAddFriendButtonTapped : ImageLiterals.Recommending.icAddFriendButton, for: isTapped ? .disabled : .normal)
    }
    
    // MARK: Objc Function
    @objc private func addButtonTapped(_ sender: UIButton) {
        self.isTapped = true
        updateAddButtonImage()
        handleAddFriendButton?.addButtonTapped(sender: sender)
    }
}
