//
//  VotingViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

import SnapKit
import Then

final class VotingViewController: BaseViewController {
    
    private let originView = BaseVotingMainView()
    
    override func loadView() {
        self.view = originView
    }
    
    static var pushCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
    }
    
    override func setStyle() {
        view.backgroundColor = .black
        
        originView.button.do {
            $0.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        originView.yelloBalloon.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 4.adjusted)
        }
        
        originView.yelloProgress.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 60.adjusted)
        }
        
    }
    
    @objc
    func clicked() {
        var viewController = UIViewController()
        // pushCount가 10 이상이면 투표 끝난 것이므로 포인트뷰컨으로 push
        if VotingViewController.pushCount >= 10 {
            viewController = VotingPointViewController()
        } else {
            viewController = VotingViewController()
        }
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}

extension VotingViewController: UINavigationControllerDelegate {
    /// 뷰 컨트롤러가 푸시될 때마다 호출
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // 현재 뷰 컨트롤러가 자기 자신인 경우에만 pushCount를 증가
        
        if VotingViewController.pushCount < 10 {
            let dummy = VotingDummy.dummy()
            self.originView.yelloBalloon.image = dummy[VotingViewController.pushCount].yelloBalloon
            self.originView.yelloProgress.image =
                dummy[VotingViewController.pushCount].yelloProgress
        }
        
        if viewController == self {
            VotingViewController.pushCount += 1
        } else {
            // 다른 뷰 컨트롤러로 이동하는 경우 pushCount를 초기화
            VotingViewController.pushCount = 0
            tabBarController?.tabBar.isHidden = false

        }
    }
}
