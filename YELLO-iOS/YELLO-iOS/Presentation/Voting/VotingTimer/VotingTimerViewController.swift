//
//  VotingTimerViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/08.
//

import UIKit

import SnapKit
import Then

final class VotingTimerViewController: BaseViewController {
    
    private let originView = BaseVotingETCView()
    private var invitingView = InvitingView()
    
    let myView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    let backgroundImage = ImageLiterals.Voting.imgTimerViewBackground
    
    // Timer 관련 컴포넌트
    private let timerBackGround = UIImageView()
    private let timerView = VotingTimerView()
    
    private let speechBubbleBackground = UIImageView()
    private let speechBubbleText = UILabel()
    
    override func loadView() {
        self.view = originView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Style
    
    override func setStyle() {
        
        myView.do {
            $0.backgroundColor = UIColor.clear
            $0.setBackgroundImageWithScaling(image: backgroundImage)
        }
        
        originView.titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Timer.title, lineHeight: 28)
        }
        
        originView.textLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Timer.text, lineHeight: 20)
        }
        
        timerBackGround.do {
            $0.image = ImageLiterals.Voting.imgTimerBackground
        }
        
        speechBubbleBackground.do {
            $0.image = ImageLiterals.Voting.lbSpeechBubble
        }
        
        speechBubbleText.do {
            $0.setTextWithLineHeight(text: "🤩 친구를 초대하면 바로 투표할 수 있어요!", lineHeight: 15)
            $0.textColor = .white
            $0.font = .uiLabelMedium
        }
        
        originView.yellowButton.do {
            $0.setTitle("기다리지 않고 바로 투표하기", for: .normal)
            $0.titleLabel?.font = .uiSubtitle04
            $0.addTarget(self, action: #selector(yellowButtonClicked), for: .touchUpInside)
        }
        
    }
    
    // MARK: - Layout
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        
        originView.addSubview(myView)
        myView.addSubviews(originView.topOfPointIcon,
                           originView.topOfMyPoint,
                           originView.titleLabel,
                           originView.textLabel,
                           timerBackGround,
                           speechBubbleBackground,
                           originView.yellowButton)
        
        timerBackGround.addSubview(timerView)
        speechBubbleBackground.addSubview(speechBubbleText)
        
        originView.topOfPointIcon.snp.makeConstraints {
            $0.centerY.equalTo(originView.topOfMyPoint)
            $0.trailing.equalTo(originView.topOfMyPoint.snp.leading).offset(-8.adjustedHeight)
        }
        
        originView.topOfMyPoint.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 47.adjustedHeight)
            $0.trailing.equalToSuperview().inset(16.adjusted)
        }
        
        originView.titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 100.adjustedHeight)
        }
        
        originView.textLabel.snp.makeConstraints {
            $0.top.equalTo(originView.titleLabel.snp.bottom).offset(2.adjustedHeight)
        }
        
        timerBackGround.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(250.adjusted)
        }
        
        timerView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        speechBubbleBackground.snp.makeConstraints {
            $0.bottom.equalTo(originView.yellowButton.snp.top).offset(-11.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        speechBubbleText.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        originView.yellowButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabBarHeight + 28.adjustedHeight)
        }
        
    }
    
    // MARK: - Objc Function

    @objc
    func yellowButtonClicked() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        invitingView.removeFromSuperview()
        invitingView = InvitingView()
        invitingView.frame = viewController.view.bounds
        invitingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        invitingView.updateText(title: StringLiterals.Inviting.unLockedTitle, text: StringLiterals.Inviting.unLockedText, targetString: "바로 투표")
        viewController.view.addSubview(invitingView)
    }
    
}
