//
//  WithdrawalReasonViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 1/23/24.
//

import UIKit

import Amplitude
import SnapKit
import Then

final class WithdrawalReasonViewController: BaseViewController {
    
    private let withdrawalReasonView = WithdrawalReasonView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        withdrawalReasonView.setCollectionView()
        withdrawalReasonView.setNotificationCenter()
        self.setAddTarget()
    }
    
    override func setStyle() {
        withdrawalReasonView.withdrawalNavigationBarView.handleBackButtonDelegate = self
    }
    
    override func setLayout() {
        view.addSubviews(withdrawalReasonView)
        
        withdrawalReasonView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setAddTarget() {
        withdrawalReasonView.completeButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    }
}

extension WithdrawalReasonViewController {
    // MARK: Objc Function
    @objc func showAlert() {
//        Amplitude.instance().logEvent("click_profile_withdrawal", withEventProperties: ["withdrawal_button":"withdrawal3"])
        
        let withdrawalAlertView = WithdrawalAlertView()
        self.view.addSubview(withdrawalAlertView)
        withdrawalAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: HandleBackButtonDelegate
extension WithdrawalReasonViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}
