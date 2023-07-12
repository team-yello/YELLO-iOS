//
//  WithdrawalCheckViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class WithdrawalCheckViewController: UIViewController {
    
    // MARK: - Variables
    // MARK: Component
    private let withdrawalCheckView = WithdrawalCheckView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

// MARK: - extension
extension WithdrawalCheckViewController {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        
        view.backgroundColor = .black
        withdrawalCheckView.withdrawalNavigationBarView.handleBackButtonDelegate = self
        withdrawalCheckView.handleKeepButtonDelegate = self
        withdrawalCheckView.handleBackButtonDelegate = self
    }
    
    private func setLayout() {
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

// MARK: HandleKeepButtonDelegate
extension WithdrawalCheckViewController: HandleKeepButtonDelegate {
    func keepButtonTapped() {
        let withdrawalViewController = WithdrawalViewController()
        navigationController?.pushViewController(withdrawalViewController, animated: true)
    }
}
