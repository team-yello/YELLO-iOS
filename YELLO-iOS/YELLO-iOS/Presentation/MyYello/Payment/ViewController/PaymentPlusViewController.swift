//
//  PaymentPlusViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/10.
//

import UIKit

import SnapKit
import Then

final class PaymentPlusViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    let paymentPlusView = PaymentPlusView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setAddTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        paymentPlusView.paymentView.bannerTimer()
    }
    
    override func setLayout() {
        
        view.addSubviews(paymentPlusView)
        
        paymentPlusView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        paymentPlusView.paymentNavigationBarView.handleBackButtonDelegate = self
    }
    
    private func setAddTarget() {
        paymentPlusView.paymentYelloPlusButton.addTarget(self, action: #selector(paymentYelloPlusButtonTapped), for: .touchUpInside)
    }
}

// MARK: HandleMyYelloCellDelegate
extension PaymentPlusViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PaymentPlusViewController {
    @objc private func paymentYelloPlusButtonTapped() {
        print("옐로플러스 구독 결제 구현")
    }
}
