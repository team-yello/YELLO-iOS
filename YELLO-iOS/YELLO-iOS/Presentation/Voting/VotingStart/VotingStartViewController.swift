//
//  VotingStartViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/07.
//

import UIKit

import Lottie
import SnapKit
import Then

final class VotingStartViewController: BaseViewController {
    
    private let originView = BaseVotingETCView()
    private var animationView: LottieAnimationView?
    
    override func loadView() {
        self.view = originView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animationView = .init(name: "VotingStart")
        animationView!.frame = originView.yelloImage.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 1.1
        
        originView.yelloImage.addSubview(animationView!)
        animationView!.play()
    }
    
    // MARK: - Style
    
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
    
    // MARK: - Layout
    
    override func setLayout() {
        
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
                
        originView.titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 100.adjusted)
        }
        
        originView.yelloImage.snp.makeConstraints {
            $0.size.equalTo(230.adjusted)
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 156.adjusted)
        }
        
        originView.grayView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 418.adjusted)
            $0.width.equalTo(284.adjusted)
            $0.height.equalTo(58.adjusted)
        }
        
        originView.yellowButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 511.adjusted)
        }
        
    }
    
    // MARK: - Objc Function
    
    @objc
    func yellowButtonClicked() {
        let viewController = VotingViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
