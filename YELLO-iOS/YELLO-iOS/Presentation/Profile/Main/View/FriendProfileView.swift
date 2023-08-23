//
//  FriendProfileView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import Amplitude
import Kingfisher
import SnapKit
import Then

// MARK: - Protocol
protocol HandleBottomSheetButtonDelegate: AnyObject {
    func dismissView()
}

protocol HandleDeleteFriendButtonDelegate: AnyObject {
    func deleteFriendButtonTapped()
}

final class FriendProfileView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    weak var handleBottomSheetButtonDelegate: HandleBottomSheetButtonDelegate?
    
    //    var indexNumber: Int = -1
    weak var handleDeleteFriendButtonDelegate: HandleDeleteFriendButtonDelegate?
    
    private let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 72.adjusted, height: 72.adjusted))
    private let nameLabel = UILabel()
    private let instagramLabel = UILabel()
    private let schoolLabel = UILabel()
    private let messageCountView = CountCustomView()
    private let friendCountView = CountCustomView()
    let deleteButton = UIButton()
    private let groupView = UIView()
    
    private let descriptionLabel = UILabel()
    private let cancelButton = UIButton(frame: CGRect(x: 0, y: 0, width: 146.adjustedWidth, height: 42.adjustedHeight))
    private let confirmButton = UIButton()
    
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
        
        deleteButton.do {
            $0.setImage(ImageLiterals.Profile.btnDelete, for: .normal)
            $0.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        }
        
        descriptionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Friend.description, lineHeight: 22.adjustedHeight)
            $0.textColor = .white
            $0.font = .uiSubtitle02
        }
        
        cancelButton.do {
            $0.backgroundColor = .grayscales800
            $0.setTitle(StringLiterals.Profile.Friend.cancel, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .uiButton
            $0.makeCornerRound(radius: 21.adjustedHeight)
            $0.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        }
        
        confirmButton.do {
            $0.backgroundColor = .grayscales800
            $0.setTitle(StringLiterals.Profile.Friend.confirm, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .uiButton
            $0.makeCornerRound(radius: 21.adjustedHeight)
            $0.addTarget(self, action: #selector(deleteFriendButtonTapped), for: .touchUpInside)
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
            $0.top.equalToSuperview().offset(40.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(72.adjusted)
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
        
        deleteButton.snp.makeConstraints {
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
    @objc private func deleteButtonTapped() {
        messageCountView.removeFromSuperview()
        friendCountView.removeFromSuperview()
        deleteButton.removeFromSuperview()
        
        self.addSubviews(descriptionLabel,
                         cancelButton,
                         confirmButton)
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(schoolLabel.snp.bottom).offset(30.adjustedHeight)
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(28.adjustedHeight)
            $0.trailing.equalTo(self.snp.centerX).offset(-2.adjustedWidth)
            $0.height.equalTo(42.adjustedHeight)
            $0.width.equalTo(146.adjustedWidth)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(cancelButton)
            $0.leading.equalTo(self.snp.centerX).offset(2.adjustedWidth)
            $0.height.equalTo(42.adjustedHeight)
            $0.width.equalTo(146.adjustedWidth)
        }
    }
    
    @objc private func cancelButtonTapped() {
        dismissView()
    }
    
    @objc private func deleteFriendButtonTapped() {
        dismissView()
        Amplitude.instance().logEvent("complete_profile_delete_friend")
        handleDeleteFriendButtonDelegate?.deleteFriendButtonTapped()
    }
    
    // MARK: Layout Helpers
    private func dismissView() {
        layoutChange()
        handleBottomSheetButtonDelegate?.dismissView()
    }
    
    func configureMyProfileFriendDetailCell(_ model: ProfileFriendResponseDetail) {
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
    
    func layoutChange() {
        self.addSubviews(messageCountView,
                         friendCountView,
                         deleteButton)
        
        deleteButton.snp.makeConstraints {
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
        
        descriptionLabel.removeFromSuperview()
        cancelButton.removeFromSuperview()
        confirmButton.removeFromSuperview()
    }
    
    // MARK: - Network
    func profileDeleteFriend(id: Int) {
        NetworkService.shared.profileService.profileDeleteFriend(id: id) { response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                dump(data)
                print("통신 성공")
                Amplitude.instance().logEvent("complete_profile_delete_friend")
            default:
                print("network fail")
                return
            }
        }
    }
}
