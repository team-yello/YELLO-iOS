//
//  EditProfileHeaderView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 1/30/24.
//

import UIKit

import SnapKit
import Then

class EditProfileHeaderView: UITableViewHeaderFooterView {
    // MARK: - Variables
    static let reusableId = "EditProfileView"
    // MARK: Component
    let profileImageView = UIImageView()
    let kakaoSyncButton = UIButton()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        profileImageView.do {
            $0.image = ImageLiterals.Profile.imgDefaultProfile
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
}
