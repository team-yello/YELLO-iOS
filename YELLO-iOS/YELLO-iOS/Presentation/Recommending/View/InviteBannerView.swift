//
//  InviteBannerView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/10.
//

import UIKit

import Amplitude
import SnapKit
import Then

final class InviteBannerView: BaseView {
    
    // MARK: - Variables
    var rootViewName = ""
    
    // MARK: Component
    private let inviteImageView = UIImageView()
    private let inviteLabel = UILabel()
    private let descriptionLabel = UILabel()
    lazy var nextButton = NextButton()
    private var invitingView = InvitingView()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        invitingView = InvitingView()
        
        inviteImageView.do {
            $0.image = ImageLiterals.Recommending.imgBannerInvite
            $0.tintColor = .white
        }
        
        inviteLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Recommending.Invite.invite, lineHeight: 22.adjustedHeight)
            $0.font = .uiBody01
            $0.textColor = .white
        }
        
        descriptionLabel.do {
            $0.font = .uiLabelMedium
            $0.setTextWithLineHeight(text: StringLiterals.Recommending.Invite.inviteDescription, lineHeight: 15.adjustedHeight)
            $0.textColor = .grayscales600
        }
        
        nextButton.do {
            $0.setImage(ImageLiterals.Recommending.icRight, for: .normal)
            $0.tintColor = .white
            $0.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        self.addSubviews(inviteImageView,
                         inviteLabel,
                         descriptionLabel,
                         nextButton)
        
        inviteImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8.adjustedWidth)
            $0.width.height.equalTo(42.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        inviteLabel.snp.makeConstraints {
            $0.leading.equalTo(inviteImageView.snp.trailing).offset(12.adjustedWidth)
            $0.top.equalToSuperview().offset(18.adjustedHeight)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(inviteLabel)
            $0.top.equalTo(inviteLabel.snp.bottom).offset(2.adjustedHeight)
        }
        
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8.adjustedWidth)
            $0.width.height.equalTo(24.adjusted)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: Objc Function
    @objc func showAlert() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        invitingView.removeFromSuperview()
        
        invitingView = InvitingView()
        invitingView.profileUserYelloId()
        invitingView.frame = viewController.view.bounds
        invitingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if rootViewName == "kakao" {
            Amplitude.instance().logEvent("click_invite", withEventProperties: ["invite_view": "recommend_kakao_yesfriend"])
        } else if rootViewName == "school" {
            Amplitude.instance().logEvent("click_invite", withEventProperties: ["invite_view": "recommend_school_yesfriend"])
        }
        invitingView.rootViewController = rootViewName
        viewController.view.addSubview(invitingView)
        
    }
}
