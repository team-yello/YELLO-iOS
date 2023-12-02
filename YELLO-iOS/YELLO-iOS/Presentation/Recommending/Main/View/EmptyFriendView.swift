//
//  EmptyFriendView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/10.
//

import UIKit

import Amplitude
import SnapKit
import Then

final class EmptyFriendView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    private let containView = UIView()
    private let emptyImageView = UIImageView()
    private let emptyDescriptionLabel = UILabel()
    lazy var inviteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 236.adjustedWidth, height: 48.adjustedHeight))
    
    var viewControllerName = ""
    private var invitingView = InvitingView()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black
        emptyImageView.do {
            $0.image = ImageLiterals.Recommending.imgBannerInvite
        }
        
        emptyDescriptionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Recommending.Empty.title, lineHeight: 24)
            $0.numberOfLines = 2
            $0.textColor = .grayscales300
            $0.font = .uiBodyLarge
        }
        
        inviteButton.do {
            $0.setTitle(StringLiterals.Recommending.Empty.inviteButton, for: .normal)
            $0.setTitleColor(.yelloMain500, for: .normal)
            $0.titleLabel?.font = .uiSubtitle04
            $0.backgroundColor = .grayscales800
            $0.makeCornerRound(radius: 24.adjustedHeight)
            $0.layer.cornerCurve = .continuous
            $0.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        self.addSubview(containView)
        containView.addSubviews(emptyImageView,
                                emptyDescriptionLabel,
                                inviteButton)
        
        self.snp.makeConstraints {
            $0.height.equalTo(272.adjustedHeight)
            $0.width.equalTo(236.adjustedWidth)
        }
        
        containView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(272.adjustedHeight)
            $0.width.equalTo(236.adjustedWidth)
        }
        
        emptyImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(130.adjusted)
        }
        
        emptyDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(emptyImageView.snp.bottom).offset(16.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        inviteButton.snp.makeConstraints {
            $0.top.equalTo(emptyDescriptionLabel.snp.bottom).offset(30.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(236.adjustedWidth)
            $0.height.equalTo(48.adjustedHeight)
        }
    }
    
    // MARK: Objc Function
    @objc func showAlert() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        var keyValue = ""
        
        invitingView.removeFromSuperview()
        invitingView = InvitingView()
        invitingView.profileUserYelloId()
        invitingView.frame = viewController.view.bounds
        invitingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.view.addSubview(invitingView)
        
        switch viewControllerName {
        case "kakaoFriend":
            invitingView.rootViewController = "KakaoFriendViewController"
            keyValue = "recommend_kakao_nofriend"
        case "schoolFriend":
            invitingView.rootViewController = "SchoolFriendViewController"
            keyValue = "recommend_school_nofriend"
        case "around":
            invitingView.rootViewController = "AroundViewController"
            keyValue = "timeline_0friend"
        default :
            return
        }
        
        Amplitude.instance().logEvent("click_invite", withEventProperties: ["invite_view": keyValue])
    }
}
