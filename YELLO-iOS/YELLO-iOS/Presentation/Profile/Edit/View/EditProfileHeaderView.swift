//
//  EditProfileHeaderView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 1/30/24.
//

import UIKit

class EditProfileHeaderView: UIView {
    // MARK: - Variables
    // MARK: Component
    let profileImageView = UIImageView()
    let kakaoSyncButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        profileImageView.do {
            $0.image = ImageLiterals.Profile.imgDefaultProfile
            $0.makeCornerRound(radius: 36.adjusted)
        }
        
        kakaoSyncButton.do {
            $0.setTitle(StringLiterals.Profile.EditProfile.kakaoSync, for: .normal)
            $0.setTitleColor(.grayscales400, for: .normal)
            $0.titleLabel?.font = .uiLabelSmall
            $0.makeCornerRound(radius: 4.adjusted)
            $0.backgroundColor = .grayscales900
        }
    }
    
    private func setLayout() {
        <#code#>
    }
}
