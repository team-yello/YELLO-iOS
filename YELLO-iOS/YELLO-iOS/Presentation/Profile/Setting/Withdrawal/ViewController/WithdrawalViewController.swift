//
//  WithdrawalViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class WithdrawalViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    private let withdrawalView = WithdrawalView()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        
        view.backgroundColor = .black
        withdrawalView.withdrawalNavigationBarView.handleBackButtonDelegate = self
        withdrawalView.handleBackButtonDelegate = self
        withdrawalView.handleKeepButtonDelegate = self

    }
    
    override func setLayout() {
        view.addSubview(withdrawalView)
        
        withdrawalView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: HandleBackButtonDelegate
extension WithdrawalViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: HandleKeepButtonDelegate
extension WithdrawalViewController: HandleKeepButtonDelegate {
    func keepButtonTapped() {
        let withdrawalCheckViewController = WithdrawalCheckViewController()
        navigationController?.pushViewController(withdrawalCheckViewController, animated: true)
    }
}
