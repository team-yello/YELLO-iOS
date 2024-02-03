//
//  MyProfileHeaderView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import Amplitude
import SnapKit
import Then

final class MyProfileHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Variables
    // MARK: Property
    var userInfoList: [String?] = []
    // MARK: Component
    let myProfileView = MyProfileView()
    let friendCountView = FriendCountView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - extension
extension MyProfileHeaderView {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
        backgroundView?.backgroundColor = .clear
    }
    
    private func setLayout() {
        self.addSubviews(myProfileView,
                        friendCountView)
        
        myProfileView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12.adjustedHeight)
            $0.leading.trailing.equalToSuperview()
        }
        
        friendCountView.snp.makeConstraints {
            $0.top.equalTo(myProfileView.snp.bottom).offset(40.adjustedHeight)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8.adjustedHeight)
        }
    }
    
    // MARK: - Network
    func profileUser() {
        NetworkService.shared.profileService.profileUser { response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                
                if data.profileImageUrl != StringLiterals.Recommending.Title.defaultProfileImageLink {
                    self.myProfileView.mainProfileView.profileImageView.kfSetImage(url: data.profileImageUrl)
                } else {
                    self.myProfileView.mainProfileView.profileImageView.image = ImageLiterals.Profile.imgDefaultProfile
                }
                self.myProfileView.mainProfileView.nameLabel.text = data.name
                self.myProfileView.mainProfileView.instagramLabel.text = "@" + data.yelloId
                self.myProfileView.mainProfileView.schoolLabel.text = data.group
                self.myProfileView.messageInfoView.infoLabel.text = String(data.yelloCount)
                self.myProfileView.friendInfoView.infoLabel.text = String(data.friendCount)
                self.myProfileView.pointInfoView.infoLabel.text = String(data.point)
                
                self.friendCountView.friendCountLabel.text = String(data.friendCount) + "명"
                self.friendCountView.friendCountLabel.asColor(targetString: "명", color: .grayscales500)
                
                Amplitude.instance().setUserProperties(["user_friends": data.friendCount,
                                                        "user_message_received": data.yelloCount,
                                                        "user_name": data.name])
                self.userInfoList = [data.profileImageUrl, data.name, data.yelloId]
                /* v2로 변경 후
                 self.userInfoList = [data.profileImageUrl, data.name, data.yelloId, data.groupName, data.subGroupName, data.groupAdmissionYear]
                 */
                
                print("내 프로필 통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
}
