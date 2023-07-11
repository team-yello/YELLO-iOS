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
    
    private let withdrawalCheckView = WithdrawalCheckView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

extension WithdrawalCheckViewController {
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        
        view.backgroundColor = .black
        withdrawalCheckView.withdrawalNavigationBarView.handleBackButtonDelegate = self
    }
    
    private func setLayout() {
        view.addSubview(withdrawalCheckView)
        
        withdrawalCheckView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension WithdrawalCheckViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}
