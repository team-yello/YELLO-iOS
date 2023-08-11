//
//  VotingLockedViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

final class VotingLockedViewController: BaseViewController {
    
    private let originView = BaseVotingETCView()
    private var invitingView = InvitingView()
    
    override func loadView() {
        self.view = originView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getVotingAvailable()
    }
    
    // MARK: - Style
    
    override func setStyle() {
        view.backgroundColor = .black
        
        originView.titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Locked.title, lineHeight: 28)
        }
        
        originView.textLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Locked.text, lineHeight: 20)
            $0.numberOfLines = 2
        }
        
        originView.yelloImage.do {
            $0.image = ImageLiterals.Voting.imgVotingLocked
        }
        
        originView.yellowButton.do {
            $0.setTitle("친구 초대하기", for: .normal)
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
        
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 60
        let width = UIScreen.main.bounds.size.width
                
        originView.titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 100.adjustedHeight)
        }
        
        originView.textLabel.snp.makeConstraints {
            $0.top.equalTo(originView.titleLabel.snp.bottom).offset(24.adjustedHeight)
        }
        
        originView.yelloImage.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(41.5.adjusted)
            $0.width.equalTo(278.adjusted)
            $0.height.equalTo(264.adjusted)
            
        }
        
        originView.yellowButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabBarHeight + 28.adjustedHeight)
        }
        
        originView.yelloFace.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width/2 - 19.5)
            $0.trailing.equalToSuperview().inset(width/2 - 19)
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabBarHeight - 32)
        }
        
    }
    
    // MARK: - Objc Function

    @objc
    func yellowButtonClicked() {        
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        invitingView.removeFromSuperview()
        invitingView = InvitingView()
        invitingView.profileUserYelloId()
        invitingView.frame = viewController.view.bounds
        invitingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        invitingView.updateText(title: StringLiterals.Inviting.lockedTitle, text: StringLiterals.Inviting.lockedText, targetString: "투표를 시작")
        viewController.view.addSubview(invitingView)
    }
}

extension VotingLockedViewController {
    func getVotingAvailable() {
        NetworkService.shared.votingService.getVotingAvailable {
            result in
            switch result {
            case .success(let data):
                let status = data.status
                guard let data = data.data else { return }
                if status == 200 {
                    if data.isPossible {
                        let viewController = VotingStartViewController()
                        viewController.originView.yellowButton.isEnabled = false
                        viewController.myPoint = data.point
                        UIView.transition(with: self.navigationController?.view ?? UIView(), duration: 0.001, options: .transitionCrossDissolve, animations: {
                            // 전환 시 스르륵 바뀌는 애니메이션 적용
                            self.navigationController?.pushViewController(viewController, animated: false)
                        })
                    } else {
                        let viewController = VotingTimerViewController()
                        viewController.myPoint = data.point
                        UIView.transition(with: self.navigationController?.view ?? UIView(), duration: 0.001, options: .transitionCrossDissolve, animations: {
                            // 전환 시 스르륵 바뀌는 애니메이션 적용
                            self.navigationController?.pushViewController(viewController, animated: false)
                        })
                    }
                }
            default:
                print("network failure")
                return
            }
        }
    }
}
