//
//  PaymentCollectionViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class PaymentCollectionViewCell: UICollectionViewCell {
    static let paymentIdentifier = "PaymentCollectionViewCell"
    
    let paymentImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .clear
        paymentImageView.do {
            $0.contentMode = .scaleAspectFit
        }
    }
    
    private func setLayout() {
        contentView.addSubview(paymentImageView)
        
        paymentImageView.snp.makeConstraints {
            $0.height.equalTo(219)
            $0.width.equalTo(375.adjustedWidth)
            $0.center.equalToSuperview()
        }
    }
    
    func configurePaymentCell(_ model: UIImage ) {
        paymentImageView.image = model
    }
}
