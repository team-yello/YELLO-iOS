//
//  EditProfileHeaderView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 1/30/24.
//

import UIKit

import SnapKit
import Then
import KakaoSDKAuth
import KakaoSDKUser

final class EditProfileHeaderView: UITableViewHeaderFooterView {
    // MARK: - Variables
    static let reusableId = "EditProfileView"
    // MARK: Component
    let profileImageView = UIImageView()
    let kakaoSyncButton = UIButton()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        profileImageView.do {
            print("🥰🥰🥰🥰\(UserManager.shared.profileImage)")
            if UserManager.shared.profileImage == StringLiterals.Profile.EditProfile.KakaoDefaultProfileURL {
                $0.image = ImageLiterals.Profile.imgDefaultProfile
            } else {
                $0.kfSetImage(url: UserManager.shared.profileImage)
            }
            $0.makeCornerRound(radius: 36.adjusted)
            $0.contentMode = .scaleAspectFill
        }
        
        kakaoSyncButton.do {
            $0.setTitle(StringLiterals.Profile.EditProfile.kakaoSync, for: .normal)
            $0.setTitleColor(.grayscales400, for: .normal)
            $0.titleLabel?.font = .uiLabelSmall
            $0.setImage(ImageLiterals.Profile.icRotate, for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -3, bottom: 0, right: 0)
            $0.makeCornerRound(radius: 4.adjusted)
            $0.backgroundColor = .grayscales900
            $0.addTarget(self, action: #selector(kakaoSyncButtonDidTapped), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        self.addSubviews(profileImageView, kakaoSyncButton)
        
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(72.adjusted)
            $0.top.equalToSuperview().offset(32.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        kakaoSyncButton.snp.makeConstraints {
            $0.height.equalTo(22.adjustedHeight)
            $0.width.equalTo(94.adjustedWidth)
            $0.top.equalTo(profileImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    private func updateProfile() {
        let request = EditProfileRequestDTO(name: UserManager.shared.name,
                                            yelloID: UserManager.shared.yelloId,
                                            gender: UserManager.shared.gender,
                                            email: UserManager.shared.email,
                                            profileImageURL: UserManager.shared.profileImage,
                                            groupID: UserManager.shared.groupId,
                                            groupAdmissionYear: UserManager.shared.groupAdmissionYear)
        NetworkService.shared.profileService.editProfile(requestDTO: request) { result in
            switch result {
            case .success:
                break
            default:
                print("프로필 변경 통신 실패")
            }
        }
    }
    
    // MARK: Objc Function
    @objc func kakaoSyncButtonDidTapped() {
        AuthApi.shared.refreshToken(completion: {_, _ in })
        UserApi.shared.me () {(user, error) in
            if let error = error {
                print(error)
            } else {
                if let user {
                    if let kakaoAccount = user.kakaoAccount {
                        if let profileImage = kakaoAccount.profile?.profileImageUrl {
                            UserManager.shared.profileImage = profileImage.absoluteString
                            if profileImage.absoluteString == StringLiterals.Profile.EditProfile.KakaoDefaultProfileURL {
                                self.profileImageView.image = ImageLiterals.Profile.imgDefaultProfile
                            } else {
                                self.profileImageView.kfSetImage(url: profileImage.absoluteString)
                            }
                            self.updateProfile()
                        }
                    }
                }
            }
            
        }
    }
}
