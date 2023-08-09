//
//  MyProfileView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class MyProfileView: UIView {
    
    // MARK: - Variables
    // MARK: Component
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let instagramLabel = UILabel()
    let schoolLabel = UILabel()
    private let separateView = UIView()
    let messageView = CountCustomView()
    let friendView = CountCustomView()
    let pointView = CountCustomView()
    private let addGroupButton = UIButton(frame: CGRect(x: 0, y: 0, width: 303.adjustedWidth, height: 48.adjustedHeight))
    
    let nameSkeletonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 66.adjustedWidth, height: 16.adjustedHeight))
    let schoolSkeletonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 66.adjustedWidth, height: 16.adjustedHeight))
    
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
extension MyProfileView {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .grayscales900
        self.makeCornerRound(radius: 12)
        
        profileImageView.do {
            $0.backgroundColor = .grayscales800
            $0.contentMode = .scaleAspectFill
            $0.makeCornerRound(radius: 24.adjusted)
        }
        
        nameLabel.do {
            $0.setTextWithLineHeight(text: "", lineHeight: 30.adjustedHeight)
            $0.font = .uiHeadline02
            $0.textColor = .white
            $0.numberOfLines = 2
            $0.lineBreakMode = .byCharWrapping
        }
        
        instagramLabel.do {
            $0.setTextWithLineHeight(text: "", lineHeight: 20.adjustedHeight)
            $0.font = .uiBody02
            $0.textColor = .yelloMain500
        }
        
        schoolLabel.do {
            $0.setTextWithLineHeight(text: "", lineHeight: 16.adjustedHeight)
            $0.font = .uiLabelLarge
            $0.textColor = .grayscales400
        }
        
        separateView.do {
            $0.backgroundColor = .grayscales700
        }
        
        messageView.do {
            $0.countLabel.text = "0"
            $0.titleLabel.text = StringLiterals.Profile.Count.message
        }
        
        friendView.do {
            $0.countLabel.text = "0"
            $0.titleLabel.text = StringLiterals.Profile.Count.friend
        }
        
        pointView.do {
            $0.countLabel.text = "0"
            $0.titleLabel.text = StringLiterals.Profile.Count.point
        }
        
        addGroupButton.do {
            $0.backgroundColor = .grayscales800
            $0.makeCornerRound(radius: 24.adjustedHeight)
            $0.titleLabel?.font = .uiBodyMedium
            $0.setTitleColor(.yelloMain500, for: .normal)
            $0.setImage(ImageLiterals.Profile.icPlus, for: .normal)
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 4)
            $0.setTitle(StringLiterals.Profile.MyProfile.addGroup, for: .normal)
            $0.addTarget(self, action: #selector(addGroupButtonTapped), for: .touchUpInside)
        }
        
        nameSkeletonLabel.do {
            $0.backgroundColor = .grayscales800
            $0.makeCornerRound(radius: 2.adjustedHeight)
        }
        
        schoolSkeletonLabel.do {
            $0.backgroundColor = .grayscales800
            $0.makeCornerRound(radius: 2.adjustedHeight)
        }
        
    }
    
    private func setLayout() {
        self.addSubviews(profileImageView,
                         nameLabel,
                         instagramLabel,
                         schoolLabel,
                         separateView,
                         messageView,
                         friendView,
                         pointView,
                         addGroupButton,
                         nameSkeletonLabel,
                         schoolSkeletonLabel)
        
        self.snp.makeConstraints {
            $0.width.equalTo(343.adjustedWidth)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.adjustedHeight)
            $0.leading.equalToSuperview().inset(20.adjustedWidth)
            $0.width.height.equalTo(48.adjusted)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12.adjustedWidth)
        }
        
        instagramLabel.snp.makeConstraints {
            $0.bottom.equalTo(nameLabel).offset(-3.adjustedHeight)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(8.adjustedWidth)
        }
        
        schoolLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView).offset(14.adjustedHeight)
            $0.leading.equalTo(nameLabel)
        }
        
        separateView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(16.adjustedHeight)
            $0.height.equalTo(1.adjusted)
            $0.leading.trailing.equalToSuperview().inset(32.adjusted)
        }
        
        messageView.snp.makeConstraints {
            $0.top.equalTo(separateView.snp.bottom).offset(4.adjustedHeight)
            $0.trailing.equalTo(friendView.snp.leading).offset(-12.adjustedWidth)
            $0.height.equalTo(64.adjustedHeight)
            $0.width.equalTo(84.adjustedWidth)
        }
        
        friendView.snp.makeConstraints {
            $0.top.equalTo(messageView)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(64.adjustedHeight)
            $0.width.equalTo(84.adjustedWidth)
        }
        
        pointView.snp.makeConstraints {
            $0.top.equalTo(messageView)
            $0.leading.equalTo(friendView.snp.trailing).offset(12.adjustedWidth)
            $0.height.equalTo(64.adjustedHeight)
            $0.width.equalTo(84.adjustedWidth)
        }
        
        addGroupButton.snp.makeConstraints {
            $0.height.equalTo(48.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(20.adjustedWidth)
            $0.bottom.equalToSuperview().inset(20.adjustedHeight)
        }
        
        // TODO: 디자인 나오면 내 프로필 스켈레톤 UI 구현
//        nameSkeletonLabel.snp.makeConstraints {
//
//        }
//        
//        schoolSkeletonLabel.snp.makeConstraints {
//
//        }
    }
    
    // MARK: Objc Function
    @objc private func addGroupButtonTapped() {
        let url = URL(string: "https://bit.ly/44xDDqC")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    // MARK: - Network
    func profileUser() {
        NetworkService.shared.profileService.profileUser { response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                
                if data.profileImageUrl != StringLiterals.Recommending.Title.defaultProfileImageLink {
                    self.profileImageView.kfSetImage(url: data.profileImageUrl)
                } else {
                    self.profileImageView.image = ImageLiterals.Profile.imgDefaultProfile
                }
                self.nameLabel.text = data.name
                self.instagramLabel.text = "@" + data.yelloId
                self.schoolLabel.text = data.group
                self.messageView.countLabel.text = String(data.yelloCount)
                self.friendView.countLabel.text = String(data.friendCount)
                self.pointView.countLabel.text = String(data.point)
                
                print("내 프로필 통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
}
