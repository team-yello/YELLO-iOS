//
//  WithdrawalCheckViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class WithdrawalCheckViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    private let withdrawalCheckView = WithdrawalCheckView()
    
    // MARK: - Function
    // MARK: - Layout
    override func setStyle() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        
        view.backgroundColor = .black
        withdrawalCheckView.withdrawalNavigationBarView.handleBackButtonDelegate = self
    }
    
    override func setLayout() {
        view.addSubview(withdrawalCheckView)
        
        withdrawalCheckView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: HandleBackButtonDelegate
extension WithdrawalCheckViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}
