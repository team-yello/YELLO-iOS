//
//  MyYelloViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

import SnapKit
import Then

final class MyYelloViewController: BaseViewController {
    
    private let myYelloView = MyYelloView()
    
    override func setStyle() {
        view.backgroundColor = .black
        
        myYelloView.myYelloListView.handleMyYelloCellDelegate = self
        myYelloView.unlockButton.addTarget(self, action: #selector(unlockButtonTapped), for: .touchUpInside)
    }
    
    override func setLayout() {
        view.addSubviews(myYelloView)
        
        let tabbarHeight = 60 + safeAreaBottomInset()

        myYelloView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(tabbarHeight)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension MyYelloViewController {
    @objc private func unlockButtonTapped() {
        let paymentViewController = PaymentViewController()
        navigationController?.pushViewController(paymentViewController, animated: true)
    }
}

// MARK: HandleMyYelloCellDelegate
extension MyYelloViewController: HandleMyYelloCellDelegate {
    func pushMyYelloDetailViewController() {
        let myYelloDetailViewController = MyYelloDetailViewController()
        navigationController?.pushViewController(myYelloDetailViewController, animated: true)
    }
}