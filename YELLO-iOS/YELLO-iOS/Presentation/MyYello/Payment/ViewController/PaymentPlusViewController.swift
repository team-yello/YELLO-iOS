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
    let paymentPlusView = UIView()
    
    override func setLayout() {
        view.addSubviews(paymentPlusView)
        
        paymentPlusView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
