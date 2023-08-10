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
    let backgroundImageView = UIImageView()
    
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
    }
    
    private func setLayout() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(paymentImageView)
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(192)
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        paymentImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    func configurePaymentCell(_ model: UIImage ) {
        paymentImageView.image = model
    }
}
