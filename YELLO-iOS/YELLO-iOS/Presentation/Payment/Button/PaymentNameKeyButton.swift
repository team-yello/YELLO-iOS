//
//  PaymentNameKeyButton.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/11.
//

import UIKit

import SnapKit
import Then

final class PaymentNameKeyButton: UIButton {
    
    enum KeyCount {
        case one
        case two
        case five
    }
    
    let nameKeyTitleLabel = UILabel()
    let keyImageView = UIImageView()
    let priceView = UIView(frame: CGRect(x: 0, y: 0, width: 78.adjustedWidth, height: 30.adjustedHeight))
    let priceLabel = UILabel()
    
    let discountLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 35.adjustedWidth, height: 21.adjustedHeight))
    let priceBeforeLabel = UILabel()
    let priceBeforeView = UIView()
    
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
    
    init(state: KeyCount) {
        super.init(frame: CGRect())
        setUI()
        setButtonState(state: state)
    }
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.makeBorder(width: 1, color: .purpleSub700)
        self.makeCornerRound(radius: 10.adjustedHeight)
        self.backgroundColor = .black
        
        nameKeyTitleLabel.do {
            $0.font = .uiBodyMedium
            $0.textColor = .purpleSub100
            $0.isUserInteractionEnabled = false
        }
        
        priceView.do {
            $0.makeCornerRound(radius: 15.adjustedHeight)
            $0.applyGradientBackground(topColor: UIColor(hex: "D96AFF"), bottomColor: UIColor(hex: "7C57FF"), startPointY: 0.5, endPointY: 0.5)
            $0.isUserInteractionEnabled = false
        }
        
        priceLabel.do {
            $0.textColor = .white
            $0.font = .uiBodyLarge
            $0.isUserInteractionEnabled = false
        }
        
        discountLabel.do {
            $0.text = StringLiterals.MyYello.Payment.discount
            $0.font = .uiLabelMedium
            $0.textColor = .white
            $0.roundCorners(cornerRadius: 10.adjustedHeight, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMaxYCorner])
            $0.backgroundColor = .purpleSub800
            $0.isUserInteractionEnabled = false
        }
        
        priceBeforeLabel.do {
            $0.font = .uiBody02
            $0.textColor = .grayscales400
            $0.isUserInteractionEnabled = false
        }
        
        priceBeforeView.do {
            $0.backgroundColor = .grayscales400
            $0.isUserInteractionEnabled = false
        }
    }
    
    private func setLayout() {
        self.addSubviews(nameKeyTitleLabel,
                         keyImageView,
                         priceView,
                         discountLabel,
                         priceBeforeLabel)
        
        priceView.addSubview(priceLabel)
        priceBeforeLabel.addSubviews(priceBeforeView)
        
        self.snp.makeConstraints {
            $0.width.equalTo(343.adjustedWidth)
            $0.height.equalTo(60.adjustedHeight)
        }
        
        nameKeyTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
        }
        
        keyImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(nameKeyTitleLabel.snp.trailing).offset(5.adjustedWidth)
        }
        
        priceView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(13.adjustedWidth)
            $0.height.equalTo(30.adjustedHeight)
            $0.width.equalTo(78.adjustedWidth)
        }
        
        priceLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        discountLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.height.equalTo(21.adjustedHeight)
            $0.width.equalTo(35.adjustedWidth)
        }
        
        priceBeforeLabel.snp.makeConstraints {
            $0.trailing.equalTo(priceView.snp.leading).offset(-6.adjustedWidth)
            $0.centerY.equalToSuperview()
        }
        
        priceBeforeView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    func setButtonState(state: KeyCount) {
        switch state {
        case .one:
            nameKeyTitleLabel.text = StringLiterals.MyYello.Payment.nameKeyOne
            keyImageView.image = ImageLiterals.Payment.imgNameKeyOne
            priceLabel.text = StringLiterals.MyYello.Payment.nameKeyOneSalePrice
            priceBeforeLabel.text = StringLiterals.MyYello.Payment.nameKeyOnePrice
            
        case .two:
            nameKeyTitleLabel.text = StringLiterals.MyYello.Payment.nameKeyTwo
            keyImageView.image = ImageLiterals.Payment.imgNameKeyTwo
            priceLabel.text = StringLiterals.MyYello.Payment.nameKeyTwoSalePrice
            priceBeforeLabel.text = StringLiterals.MyYello.Payment.nameKeyTwoPrice

        case .five:
            nameKeyTitleLabel.text = StringLiterals.MyYello.Payment.nameKeyFive
            keyImageView.image = ImageLiterals.Payment.imgNameKeyFive
            priceLabel.text = StringLiterals.MyYello.Payment.nameKeyFivePrice
            priceBeforeLabel.text = StringLiterals.MyYello.Payment.nameKeyFivePriceBefore
        }
    }
}
