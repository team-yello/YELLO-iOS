//
//  VotingStartViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

final class VotingStartViewController: BaseViewController {

    private let originView = BaseVotingView()
    
    override func loadView() {
        self.view = originView
    }
    
    override func setStyle() {
        view.backgroundColor = .black
        
        originView.titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Start.title, lineHeight: 28)
        }
        
        originView.engPoint.do {
            $0.setTextWithLineHeight(text: "Point", lineHeight: 22)
        }
        
        originView.realMyPoint.do {
            $0.setTextWithLineHeight(text: "2500", lineHeight: 22)
        }
        
        originView.yellowButton.do {
            $0.setTitle("투표 시작!", for: .normal)
            $0.addTarget(self, action: #selector(yellowButtonClicked), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
                        
        originView.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(120.adjusted)
        }
        
        originView.yelloImage.snp.makeConstraints {
            $0.size.equalTo(230.adjusted)
            $0.top.equalTo(originView.titleLabel.snp.bottom).offset(28.adjusted)
        }
        
        originView.grayView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(438.adjusted)
            $0.width.equalTo(284.adjustedWidth)
            $0.height.equalTo(58.adjustedHeight)
        }
        
    }
    
    @objc
    func yellowButtonClicked() {
        let nextViewController = VotingViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }

    

}
