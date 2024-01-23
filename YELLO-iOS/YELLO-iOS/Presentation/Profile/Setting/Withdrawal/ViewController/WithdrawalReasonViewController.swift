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
    
    override func setStyle() {
        withdrawalReasonView.withdrawalNavigationBarView.handleBackButtonDelegate = self
    }
    
    override func setLayout() {
        view.addSubviews(withdrawalReasonView)
        
        withdrawalReasonView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension WithdrawalReasonViewController {
    // MARK: Objc Function
    @objc func showAlert() {
        Amplitude.instance().logEvent("click_profile_withdrawal", withEventProperties: ["withdrawal_button":"withdrawal3"])
//        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
//        
//        if let withdrawalAlertView = withdrawalAlertView {
//            withdrawalAlertView.removeFromSuperview()
//        }
//        
//        withdrawalAlertView = WithdrawalAlertView()
//        withdrawalAlertView?.frame = viewController.view.bounds
//        withdrawalAlertView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        
//        viewController.view.addSubview(withdrawalAlertView!)
//        
    }
}

// MARK: HandleBackButtonDelegate
extension WithdrawalReasonViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}
