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
    
    // MARK: - Style
    
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
            $0.setTextWithLineHeight(text: "2900", lineHeight: 22)
        }
        
        originView.yellowButton.do {
            $0.setTitle("확인", for: .normal)
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
        
        originView.topOfPointIcon.snp.makeConstraints {
            $0.centerY.equalTo(originView.topOfMyPoint)
            $0.trailing.equalTo(originView.topOfMyPoint.snp.leading).offset(-8.adjusted)
        }
        
        originView.topOfMyPoint.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 47.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjusted)
        }
                        
        originView.titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 100.adjusted)
        }
        
        originView.textLabel.snp.makeConstraints {
            $0.top.equalTo(originView.titleLabel.snp.bottom).offset(4.adjusted)
        }
        
        originView.plusPoint.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 198.adjusted)
        }
        
        originView.yelloImage.snp.makeConstraints {
            $0.width.equalTo(240.adjusted)
            $0.height.equalTo(160.adjusted)
            $0.top.equalTo(originView.plusPoint.snp.bottom).offset(12.adjusted)
        }
        
        originView.grayView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 422.adjusted)
            $0.width.equalTo(284.adjustedWidth)
            $0.height.equalTo(58.adjustedHeight)
        }
        
        originView.yellowButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 511.adjusted)
        }
    }
    
    // MARK: - 확인 버튼 클릭했을 때
    
    @objc
    func yellowButtonClicked() {
        let viewController = VotingTimerViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }

}
