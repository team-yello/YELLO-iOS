//
//  InviteBannerView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class InviteBannerView: BaseView {
    
    private let inviteImageView = UIImageView()
    private let inviteLabel = UILabel()
    private let descriptionLabel = UILabel()
    private lazy var nextButton = UIButton()
    
    override func setStyle() {
        inviteImageView.do {
            $0.image = ImageLiterals.Recommending.imgBannerInvite
            $0.tintColor = .white
        }
        
        inviteLabel.do {
            $0.setTextWithLineHeight(text: "친구 초대하기", lineHeight: 22)
            $0.font = .uiBodyMedium
            $0.textColor = .white
        }
        
        descriptionLabel.do {
            $0.font = .uiLabelMedium
            $0.setTextWithLineHeight(text: "찾는 친구가 없다면 친구를 초대해 보세요!", lineHeight: 15)
            $0.textColor = .grayscales600
        }
        
        nextButton.do {
            $0.setImage(ImageLiterals.Recommending.icRight, for: .normal)
            $0.tintColor = .white
        }
    }
    
    override func setLayout() {
        self.addSubviews(inviteImageView,
                        inviteLabel,
                        descriptionLabel,
                        nextButton)
        
        inviteImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8.adjusted)
            $0.width.height.equalTo(42.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        inviteLabel.snp.makeConstraints {
            $0.leading.equalTo(inviteImageView.snp.trailing).offset(12.adjusted)
            $0.top.equalToSuperview().offset(18.adjusted)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(inviteLabel)
            $0.top.equalTo(inviteLabel.snp.bottom).offset(2.adjusted)
        }
        
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8.adjusted)
            $0.width.height.equalTo(24.adjusted)
            $0.centerY.equalToSuperview()
        }
    }
}
