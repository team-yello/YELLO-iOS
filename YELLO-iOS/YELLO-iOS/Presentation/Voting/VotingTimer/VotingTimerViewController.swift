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
    
    private let originView = BaseVotingView()
    
    private let speechBubbleBackground = UIImageView()
    private let speechBubbleText = UILabel()
    
    override func loadView() {
        self.view = originView
    }
    
    override func setStyle() {
        view.backgroundColor = UIColor(patternImage: ImageLiterals.Voting.imgTimerBackground)
        
        originView.titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Timer.title, lineHeight: 28)
        }
        
        originView.textLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Timer.text, lineHeight: 20)
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
    
    override func setLayout() {
            
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        originView.addSubview(speechBubbleBackground)
        speechBubbleBackground.addSubview(speechBubbleText)

        originView.topOfMyPoint.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 47.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjusted)
        }
                        
        originView.titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 100.adjusted)
        }
        
        originView.textLabel.snp.makeConstraints {
            $0.top.equalTo(originView.titleLabel.snp.bottom).offset(2.adjusted)
        }
        
        speechBubbleBackground.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 458.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        speechBubbleText.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        originView.yellowButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 511.adjusted)
        }
    
    }
    
    @objc
    func yellowButtonClicked() {
        let nextViewController = BaseInvitingViewController()
        nextViewController.modalPresentationStyle = .formSheet
        self.present(nextViewController, animated: true)
    }

}
