//
//  RecommendFriendProfileView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 12/30/23.
//

import UIKit

import Amplitude
import Kingfisher
import SnapKit
import Then

// MARK: - Protocol
protocol HandleAddFriendButtonDelegate: AnyObject {
    func addFriendButtonTapped(id: Int)
}

final class RecommendFriendProfileView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    weak var handleBottomSheetButtonDelegate: HandleBottomSheetButtonDelegate?
    weak var handleAddFriendButtonDelegate: HandleAddFriendButtonDelegate?
    var userId: Int = -1

    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 72.adjusted, height: 72.adjusted))
    let nameLabel = UILabel()
    let instagramLabel = UILabel()
    let schoolLabel = UILabel()
    let messageCountView = CountCustomView()
    let friendCountView = CountCustomView()
    let addButton = UIButton()
    private let groupView = UIView()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black
        
        profileImageView.do {
            $0.image = ImageLiterals.Profile.imgDefaultProfile
            $0.contentMode = .scaleAspectFill
            $0.makeCornerRound(radius: 36.adjusted)
        }
        
        nameLabel.do {
            $0.setTextWithLineHeight(text: "", lineHeight: 28.adjustedHeight)
            $0.font = .uiHeadline03
            $0.textColor = .white
        }
        
        instagramLabel.do {
            $0.setTextWithLineHeight(text: "", lineHeight: 16.adjustedHeight)
            $0.font = .uiLabelLarge
            $0.textColor = .yelloMain600
        }
        
        schoolLabel.do {
            $0.setTextWithLineHeight(text: "", lineHeight: 20.adjustedHeight)
            $0.font = .uiBody02
            $0.textColor = .grayscales500
            $0.textAlignment = .center
            $0.lineBreakMode = .byCharWrapping
        }
        
        messageCountView.do {
            $0.countLabel.text = ""
            $0.titleLabel.text = StringLiterals.Profile.Friend.message
        }
        
        friendCountView.do {
            $0.countLabel.text = ""
            $0.titleLabel.text = StringLiterals.Profile.Friend.friendNumber
        }
        
        addButton.do {
            $0.setImage(ImageLiterals.Recommending.btnAddFriend, for: .normal)
            $0.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        self.addSubviews(profileImageView,
                         groupView,
                         schoolLabel,
                         messageCountView,
                         friendCountView,
                         addButton)
        
        groupView.addSubviews(nameLabel,
                              instagramLabel)
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(72.adjusted)
        }
        
        groupView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(16.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(28.adjustedHeight)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
        }
        
        instagramLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9.adjustedHeight)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(8.adjustedWidth)
            $0.trailing.equalToSuperview()
        }
        
        schoolLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200.adjustedWidth)
            $0.height.equalTo(40.adjustedHeight)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(messageCountView.snp.bottom).offset(16.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        messageCountView.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.centerX).inset(6.adjustedWidth)
            $0.top.equalTo(schoolLabel.snp.bottom).offset(12.adjustedHeight)
        }
        
        friendCountView.snp.makeConstraints {
            $0.leading.equalTo(messageCountView.snp.trailing).offset(12.adjustedWidth)
            $0.bottom.equalTo(messageCountView)
        }
    }
    
    // MARK: Objc Function
    @objc private func addButtonTapped() {
        addButton.setImage(ImageLiterals.Recommending.icAddFriendButtonTapped, for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.dismissView()
            self.handleAddFriendButtonDelegate?.addFriendButtonTapped(id: self.userId)
        }
    }
    
    // MARK: Layout Helpers
    func configureMyProfileFriendDetailCell(_ model: ProfileFriendResponseDetail) {
        self.userId = model.userId
        if model.profileImageUrl != StringLiterals.Recommending.Title.defaultProfileImageLink {
            profileImageView.kfSetImage(url: model.profileImageUrl)
        } else {
            profileImageView.image = ImageLiterals.Profile.imgDefaultProfile
        }
        nameLabel.text = model.name
        instagramLabel.text = "@" + model.yelloId
        schoolLabel.text = model.group
        messageCountView.countLabel.text = String(model.yelloCount)
        friendCountView.countLabel.text = String(model.friendCount)
    }
    
    // MARK: Layout Helpers
    private func dismissView() {
        handleBottomSheetButtonDelegate?.dismissView()
    }
    
    func layoutChange() {
        addButton.setImage(ImageLiterals.Recommending.btnAddFriend, for: .normal)
    }
}
