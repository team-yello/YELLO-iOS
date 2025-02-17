//
//  PaymentFixViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2/16/25.
//

import UIKit

import SnapKit
import Then

final class PaymentFixViewController: BaseViewController {
    
    let fixLabel = UILabel()
    
    override func setLayout() {
        view.addSubviews(fixLabel)
        
        fixLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setStyle() {
        view.backgroundColor = .black
        
        fixLabel.do {
            $0.text = StringLiterals.MyYello.Payment.fix
            $0.textAlignment = .center
            $0.textColor = .white
            $0.font = .uiBody01
            $0.numberOfLines = 0
        }
    }
}
