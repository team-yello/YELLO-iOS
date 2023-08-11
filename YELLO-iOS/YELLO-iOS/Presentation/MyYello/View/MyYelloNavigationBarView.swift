//
//  MyYelloNavigationBarView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

protocol HandleShopButton: AnyObject {
    func shopButtonTapped()
}

final class MyYelloNavigationBarView: BaseView {
    
    private enum Color {
        static var gradientColors = [
            UIColor(hex: "D96AFF"),
            UIColor(hex: "7C57FF")
        ]
    }
    
    private enum Constants {
        static let gradientLocation = [Int](0..<Color.gradientColors.count)
            .map(Double.init)
            .map { $0 / Double(Color.gradientColors.count - 1) }
            .map(NSNumber.init)
    }
    
    // MARK: - Variables
    // MARK: Component
    private let titleLabel = UILabel()
    let yelloNumberLabel = UILabel()
    let yelloCountLabel = UILabel()
    lazy var shopButton = UIButton(frame: CGRect(x: 0, y: 0, width: 67.adjustedWidth, height: 28.adjustedHeight))
    let shopBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 71.adjustedWidth, height: 32.adjustedHeight))
    let countSkeletonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 70.adjustedWidth, height: 16.adjustedHeight))
    
    weak var handleShopButton: HandleShopButton?
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.NavigationBar.myYello, lineHeight: 28.adjustedHeight)
            $0.font = .uiHeadline03
            $0.textColor = .white
        }
        
        shopButton.do {
            $0.setImage(ImageLiterals.MyYello.icShop, for: .normal)
            $0.setTitle(StringLiterals.MyYello.NavigationBar.shop, for: .normal)
            $0.titleLabel?.font = .uiBodyMedium
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 5.adjustedWidth)
            $0.makeCornerRound(radius: 14.adjustedHeight)
            $0.layer.cornerCurve = .continuous
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .black
            $0.addTarget(self, action: #selector(shopButtonTapped), for: .touchUpInside)
        }
        
        shopBackgroundView.do {
            $0.applyGradientBackground(topColor: UIColor(hex: "D96AFF"), bottomColor: UIColor(hex: "7C57FF"))
            $0.makeCornerRound(radius: 16.adjustedHeight)
            $0.layer.cornerCurve = .continuous
//            $0.isUserInteractionEnabled = false
        }
        
        yelloNumberLabel.do {
            $0.text = StringLiterals.MyYello.NavigationBar.yelloNumber
            $0.font = .uiLabelLarge
            $0.textColor = .grayscales500
        }
        
        yelloCountLabel.do {
            $0.text = "0개"
            $0.font = .uiLabelLarge
            $0.textColor = .grayscales200
            $0.asColor(targetString: "개", color: .grayscales500)
        }
        
        countSkeletonLabel.do {
            $0.backgroundColor = .grayscales800
            $0.makeCornerRound(radius: 2.adjustedHeight)
            $0.isHidden = true
        }
    }
    
    override func setLayout() {
        self.addSubviews(titleLabel,
                         shopBackgroundView,
                         yelloNumberLabel,
                         yelloCountLabel,
                         countSkeletonLabel)
        
        shopBackgroundView.addSubview(shopButton)
        
        self.snp.makeConstraints {
            $0.height.equalTo(74.adjustedHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10.adjustedHeight)
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
        }
        
        shopBackgroundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(32.adjustedHeight)
            $0.width.equalTo(71.adjustedWidth)
        }
        
        yelloNumberLabel.snp.makeConstraints {
            $0.centerY.equalTo(yelloCountLabel)
            $0.leading.equalTo(titleLabel)
        }
        
        yelloCountLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(5.adjustedHeight)
            $0.leading.equalTo(yelloNumberLabel.snp.trailing).inset(-4.adjustedWidth)
        }
        
        countSkeletonLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20.adjustedHeight)
            $0.leading.equalTo(titleLabel)
            $0.height.equalTo(16.adjustedHeight)
            $0.width.equalTo(70.adjustedWidth)
        }
        
        shopButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.bottom.top.equalToSuperview().inset(2.adjustedWidth)
        }
    }
}

extension MyYelloNavigationBarView {
    @objc func shopButtonTapped() {
        handleShopButton?.shopButtonTapped()
    }
    
    func myYelloRefresh() {
        self.countSkeletonLabel.isHidden = false
        self.yelloNumberLabel.isHidden = true
        self.yelloCountLabel.isHidden = true
        self.countSkeletonLabel.animateShimmer()
    }
    
    func myYelloStopRefresh() {
        self.countSkeletonLabel.isHidden = true
        self.yelloNumberLabel.isHidden = false
        self.yelloCountLabel.isHidden = false
        self.countSkeletonLabel.stopShimmering()
    }
}
