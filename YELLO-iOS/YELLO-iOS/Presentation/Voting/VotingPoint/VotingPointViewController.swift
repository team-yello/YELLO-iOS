//
//  VotingPointViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/08.
//

import UIKit

import SnapKit
import Then

final class VotingPointViewController: BaseViewController {

    private let originView = BaseVotingView()
    
    override func loadView() {
        self.view = originView
    }
    
    override func setStyle() {
        view.backgroundColor = .black
        
        originView.titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Point.title, lineHeight: 28)
        }
        
        originView.textLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Point.text, lineHeight: 20)
        }
        
        originView.plusPoint.do {
            $0.setTextWithLineHeight(text: "+ 400 Point", lineHeight: 22)
            $0.asColor(targetString: "400", color: .yelloMain500)
        }
        
        originView.engPoint.do {
            $0.setTextWithLineHeight(text: "Point", lineHeight: 22)
        }
        
        originView.realMyPoint.do {
            $0.setTextWithLineHeight(text: "2500", lineHeight: 22)
        }
        
        originView.yellowButton.do {
            $0.setTitle("확인", for: .normal)
            $0.addTarget(self, action: #selector(yellowButtonClicked), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        
        originView.topOfMyPoint.snp.makeConstraints {
            $0.top.equalToSuperview().inset(67.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjusted)
        }
                        
        originView.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(120.adjusted)
        }
        
        originView.textLabel.snp.makeConstraints {
            $0.top.equalTo(originView.titleLabel.snp.bottom).offset(4.adjusted)
        }
        
        originView.plusPoint.snp.makeConstraints {
            $0.top.equalToSuperview().inset(218.adjusted)
        }
        
        originView.yelloImage.snp.makeConstraints {
            $0.width.equalTo(240.adjusted)
            $0.height.equalTo(160.adjusted)
            $0.top.equalTo(originView.plusPoint.snp.bottom).offset(12.adjusted)
        }
        
        originView.grayView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(442.adjusted)
            $0.width.equalTo(284.adjustedWidth)
            $0.height.equalTo(58.adjustedHeight)
        }
    }
    
    @objc
    func yellowButtonClicked() {
        let nextViewController = VotingTimerViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }

}
