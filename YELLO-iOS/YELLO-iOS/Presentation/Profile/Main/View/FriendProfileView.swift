//
//  FriendProfileView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import Kingfisher
import SnapKit
import Then

// MARK: - Protocol
protocol HandleBottomSheetButtonDelegate: AnyObject {
    func dismissView()
}

protocol HandleDeleteButtonDelegate: AnyObject {
    func deleteButtonTapped()
}

final class FriendProfileView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    weak var handleBottomSheetButtonDelegate: HandleBottomSheetButtonDelegate?
    weak var handleDeleteButtonDelegate: HandleDeleteButtonDelegate?
    
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let instagramLabel = UILabel()
    private let schoolLabel = UILabel()
    private let messageCountView = CountCustomView()
    private let friendCountView = CountCustomView()
    let deleteButton = UIButton()
    private let groupView = UIView()
    
    private let descriptionLabel = UILabel()
    private let cancelButton = UIButton()
    private let confirmButton = UIButton()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black
        
        profileImageView.do {
            $0.image = ImageLiterals.Profile.imgDefaultProfile
            $0.contentMode = .scaleAspectFill
            $0.makeCornerRound(radius: 20)
        }
        
        nameLabel.do {
            $0.setTextWithLineHeight(text: "정채은", lineHeight: 28)
            $0.font = .uiHeadline03
            $0.textColor = .white
        }
        
        instagramLabel.do {
            $0.setTextWithLineHeight(text: "@chaentopia", lineHeight: 16)
            $0.font = .uiLabelLarge
            $0.textColor = .yelloMain600
        }
        
        schoolLabel.do {
            $0.setTextWithLineHeight(text: "이화여자대학교 융합콘텐츠학과 20학번\n", lineHeight: 20)
            $0.font = .uiBody02
            $0.textColor = .grayscales500
            $0.textAlignment = .center
        }
        
        messageCountView.do {
            $0.countLabel.text = "31"
            $0.titleLabel.text = StringLiterals.Profile.Friend.message
        }
        
        friendCountView.do {
            $0.countLabel.text = "95"
            $0.titleLabel.text = StringLiterals.Profile.Friend.friendNumber
        }
        
        deleteButton.do {
            $0.setImage(ImageLiterals.Profile.btnDelete, for: .normal)
            $0.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        }
        
        descriptionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Friend.description, lineHeight: 22)
            $0.textColor = .white
            $0.font = .uiSubtitle02
        }
        
        cancelButton.do {
            $0.backgroundColor = .grayscales800
            $0.setTitle(StringLiterals.Profile.Friend.cancel, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .uiButton
            $0.makeCornerRound(radius: 8)
            $0.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        }
        
        confirmButton.do {
            $0.backgroundColor = .grayscales800
            $0.setTitle(StringLiterals.Profile.Friend.confirm, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .uiButton
            $0.makeCornerRound(radius: 8)
            $0.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        self.addSubviews(profileImageView,
                         groupView,
                         schoolLabel,
                         messageCountView,
                         friendCountView,
                         deleteButton)
        
        groupView.addSubviews(nameLabel,
                              instagramLabel)
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(72)
        }
        
        groupView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(16.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(28)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        instagramLabel.snp.makeConstraints {
            let font = UIFont.uiLabelLarge
            let fontDescender = font.descender
            
            $0.bottom.equalTo(nameLabel).offset(-3.adjusted + fontDescender)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(8.adjusted)
            $0.trailing.equalToSuperview()
        }
        
        schoolLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(messageCountView.snp.bottom).offset(16.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        messageCountView.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.centerX).inset(6.adjusted)
            $0.top.equalTo(schoolLabel.snp.bottom).offset(12.adjusted)
        }
        
        friendCountView.snp.makeConstraints {
            $0.leading.equalTo(messageCountView.snp.trailing).offset(12.adjusted)
            $0.bottom.equalTo(messageCountView)
        }
    }
    
    // MARK: Objc Function
    @objc private func deleteButtonTapped() {
        messageCountView.removeFromSuperview()
        friendCountView.removeFromSuperview()
        deleteButton.removeFromSuperview()
        
        self.addSubviews(descriptionLabel,
                         cancelButton,
                         confirmButton)
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(schoolLabel.snp.bottom).offset(30.adjusted)
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(28.adjusted)
            $0.trailing.equalTo(self.snp.centerX).offset(-2)
            $0.height.equalTo(42)
            $0.width.equalTo(146)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(cancelButton)
            $0.leading.equalTo(self.snp.centerX).offset(2)
            $0.height.equalTo(42)
            $0.width.equalTo(146)
        }
    }
    
    @objc private func cancelButtonTapped() {
        dismissView()
    }
    
    @objc private func confirmButtonTapped() {
        dismissView()
        self.showToast(message: StringLiterals.Profile.Friend.toastMessage)
        handleDeleteButtonDelegate?.deleteButtonTapped()
    }
    
    // MARK: Layout Helpers
    private func dismissView() {
        handleBottomSheetButtonDelegate?.dismissView()
    }
    
    func configureMyProfileFriendDetailCell(_ model: MyProfileFriendModel) {
        profileImageView.kfSetImage(url: model.friendProfileImage)
        nameLabel.text = model.friendName
        instagramLabel.text = model.yelloId
        schoolLabel.text = model.friendGroup
        messageCountView.countLabel.text = String(model.yelloCount)
        friendCountView.countLabel.text = String(model.friendCount)
    }
}
