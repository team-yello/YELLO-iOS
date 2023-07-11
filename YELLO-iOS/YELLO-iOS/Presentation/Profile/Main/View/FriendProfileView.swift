//
//  FriendProfileView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class FriendProfileView: BaseView {
    
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let instagramLabel = UILabel()
    private let schoolLabel = UILabel()
    private let messageCountView = CountCustomView()
    private let friendCountView = CountCustomView()
    let deleteButton = UIButton()
    private let groupView = UIView()
    
    override func setStyle() {
        self.backgroundColor = .black
        
        profileImageView.do {
            $0.image = UIImage(systemName: "circle.fill")
            $0.tintColor = .white            
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
}
