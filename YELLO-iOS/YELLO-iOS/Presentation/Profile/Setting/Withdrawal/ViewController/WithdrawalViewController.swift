//
//  WithdrawalViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class WithdrawalViewController: UIViewController {
    
    // MARK: - Variables
    // MARK: Component
    private let withdrawalView = WithdrawalView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

// MARK: - extension
extension WithdrawalViewController {
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    // MARK: Layout Helpers
    private func setStyle() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        
        view.backgroundColor = .black
        withdrawalView.withdrawalNavigationBarView.handleBackButtonDelegate = self
    }
    
    private func setLayout() {
        view.addSubview(withdrawalView)
        
        withdrawalView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: HandleBackButtonDelegate
extension WithdrawalViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}
