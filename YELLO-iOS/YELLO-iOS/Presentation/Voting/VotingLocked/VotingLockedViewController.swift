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
    
    private let originView = BaseVotingView()
    
    override func loadView() {
        self.view = originView
    }
    
    override func setStyle() {
        view.backgroundColor = .black
        
        originView.whiteLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Locked.white, lineHeight: 28)
        }
        
        originView.grayLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Locked.gray, lineHeight: 20)
            $0.numberOfLines = 2
        }
        
        originView.yellowButton.do {
            $0.setTitle("친구 초대하기", for: .normal)
            $0.addTarget(self, action: #selector(yellowButtonClicked), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        
        originView.whiteLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100.adjusted)
        }
        
        originView.grayLabel.snp.makeConstraints {
            $0.top.equalTo(originView.whiteLabel.snp.bottom).offset(24)
        }
        
        originView.yelloImage.snp.makeConstraints {
            $0.size.equalTo(230.adjusted)
            $0.centerY.equalToSuperview().inset(15.adjusted)
        }
        
        originView.yellowButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(28.adjusted)
        }
        
    }
    
    @objc
    func yellowButtonClicked() {
        let nextViewController = BaseInvitingViewController()
        nextViewController.modalPresentationStyle = .formSheet
        self.present(nextViewController, animated: true)
    }

}