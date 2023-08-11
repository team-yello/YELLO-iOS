//
//  PaymentYelloPlusButton.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/10.
//

import UIKit

import SnapKit
import Then

final class PaymentYelloPlusButton: UIButton {
    
    private let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 400.adjustedWidth, height: 70.adjustedHeight))
    private let badgeImageView = UIImageView()
    private let buttonTitleLabel = UILabel()
    private let discountTitleLabel = UILabel()
    private let priceBeforeLabel = UILabel()
    private let priceBeforeView = UIView()
    private let priceLabel = UILabel()
    private let weekLabel = UILabel()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        
        self.isUserInteractionEnabled = true
        
        backgroundView.do {
            $0.applyGradientBackground(topColor: UIColor(hex: "D96AFF"), bottomColor: UIColor(hex: "7C57FF"))
            $0.makeCornerRound(radius: 8.adjustedHeight)
            $0.layer.cornerCurve = .continuous
            $0.isUserInteractionEnabled = true
        }
        
        badgeImageView.do {
            $0.image = ImageLiterals.Payment.imgYelloPlusBadge
            $0.isUserInteractionEnabled = true
        }
        
        buttonTitleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Payment.yelloPlusSubscribe, lineHeight: 24.adjustedHeight)
            $0.textColor = .white
            $0.font = .uiSubtitle01
        }
        
        discountTitleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Payment.discount50Percent, lineHeight: 14.adjustedHeight)
            $0.textColor = .yelloMain500
            $0.font = .uiLabelBoldSmall
        }
        
        priceBeforeLabel.do {
            $0.text = StringLiterals.MyYello.Payment.yelloPlusPriceBefore
            $0.textColor = .white
            $0.font = .uiLabelLarge
        }
        
        priceBeforeView.do {
            $0.backgroundColor = .white
        }
        
        priceLabel.do {
            $0.text = StringLiterals.MyYello.Payment.yelloPlusPrice
            $0.textColor = .yelloMain500
            $0.font = .uiSubtitle01
        }
        
        weekLabel.do {
            $0.text = StringLiterals.MyYello.Payment.forWeek
            $0.textColor = .purpleSub200
            $0.font = .uiBody06
        }
    }
    
    private func setLayout() {
        
        self.addSubviews(backgroundView,
                         badgeImageView)
        
        backgroundView.addSubviews(buttonTitleLabel,
                                   discountTitleLabel,
                                   priceBeforeLabel,
                                   priceLabel,
                                   weekLabel)
        
        priceBeforeLabel.addSubviews(priceBeforeView)
        
        backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(343.adjustedHeight)
            $0.height.equalTo(70.adjustedHeight)
            $0.leading.trailing.equalToSuperview()
        }
        
        badgeImageView.snp.makeConstraints {
            $0.leading.equalTo(backgroundView).inset(10.adjustedWidth)
            $0.bottom.equalTo(backgroundView.snp.top).offset(8.adjustedHeight)
        }
        
        buttonTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
            $0.top.equalToSuperview().inset(16.adjustedHeight)
        }
        
        discountTitleLabel.snp.makeConstraints {
            $0.top.equalTo(buttonTitleLabel.snp.bottom)
            $0.leading.equalTo(buttonTitleLabel)
        }
        
        weekLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.bottom.equalTo(discountTitleLabel).offset(1.adjustedHeight)
        }
        
        priceLabel.snp.makeConstraints {
            $0.trailing.equalTo(weekLabel.snp.leading).offset(-2.adjustedWidth)
            $0.bottom.equalTo(discountTitleLabel).offset(2.adjustedHeight)

        }
        
        priceBeforeLabel.snp.makeConstraints {
            $0.trailing.equalTo(priceLabel.snp.leading).offset(-4.adjustedWidth)
            $0.bottom.equalTo(discountTitleLabel)
        }
        
        priceBeforeView.snp.makeConstraints {
            $0.width.equalTo(priceBeforeLabel)
            $0.center.equalTo(priceBeforeLabel)
            $0.height.equalTo(1.adjustedHeight)
        }
        
    }
}
