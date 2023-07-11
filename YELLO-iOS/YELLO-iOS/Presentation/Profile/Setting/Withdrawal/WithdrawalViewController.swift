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
    
    private let withdrawalView = WithdrawalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

extension WithdrawalViewController {
    private func setUI() {
        setStyle()
        setLayout()
    }
    
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

extension WithdrawalViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}
