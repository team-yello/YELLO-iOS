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
    // MARK: - Variables
    // MARK: Enum
    enum KeyCount {
        case one
        case two
        case five
    }
    
    // MARK: Component
    let keyImageView = UIImageView()
    let infoContainerView = UIView()
    let nameKeyTitleLabel = UILabel()
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
        self.backgroundColor = .black
        
        infoContainerView.do {
            $0.isUserInteractionEnabled = true
            $0.makeBorder(width: 1, color: .purpleSub700)
            $0.makeCornerRound(radius: 10.adjustedHeight)
        }
        
        nameKeyTitleLabel.do {
            $0.font = .uiBodyMedium
            $0.textColor = .purpleSub100
            $0.numberOfLines = 2
            $0.textAlignment = .center
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Payment.nameKeyOne, lineHeight: 20.adjustedHeight)
            $0.isUserInteractionEnabled = false
        }
        
        priceView.do {
            $0.isUserInteractionEnabled = true
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
            $0.textAlignment = .center
            $0.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -60)
            $0.font = .uiLabelMedium
            $0.textColor = .white
            $0.backgroundColor = .purpleSub800
            $0.isUserInteractionEnabled = false
        }
        
        priceBeforeLabel.do {
            $0.font = .uiLabelSmall
            $0.textColor = .grayscales400
            $0.isUserInteractionEnabled = false
        }
        
        priceBeforeView.do {
            $0.backgroundColor = .grayscales400
            $0.isUserInteractionEnabled = false
        }
    }
    
    private func setLayout() {
        self.addSubviews(infoContainerView,
                         keyImageView)
        
        infoContainerView.addSubviews(nameKeyTitleLabel,priceView,discountLabel,priceBeforeLabel)
        priceView.addSubview(priceLabel)
        priceBeforeLabel.addSubviews(priceBeforeView)
        
        self.snp.makeConstraints {
            $0.height.equalTo(172.adjustedHeight)
            $0.width.equalTo(108.adjustedWidth)
        }
        
        infoContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        keyImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(infoContainerView.snp.top).offset(-10.adjusted)
        }
        
        nameKeyTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(keyImageView.snp.bottom).offset(10.adjustedHeight)
        }
        
        priceView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(priceBeforeLabel.snp.bottom).offset(24.adjustedHeight)
            $0.height.equalTo(30.adjustedHeight)
            $0.width.equalTo(78.adjustedWidth)
        }
        
        priceLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        discountLabel.snp.makeConstraints {
            $0.top.equalTo(priceView.snp.top).offset(-16.adjusted)
            $0.leading.equalToSuperview().offset(7.adjusted)
            $0.height.equalTo(21.adjustedHeight)
            $0.width.equalTo(35.adjustedWidth)
        }
        
        priceBeforeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameKeyTitleLabel.snp.bottom)
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
