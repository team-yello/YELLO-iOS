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
    
    // MARK: - Variables
    // MARK: Component
    private let titleLabel = UILabel()
    let noticeButton = UIButton()
    let noticeButtonImageView = UIImageView()
    let noticeButtonLabel = UILabel()
    let clickMeButtonLabel = UILabel()
    let yelloNumberLabel = UILabel()
    let yelloCountLabel = UILabel()
    lazy var shopButton = UIButton(frame: CGRect(x: 0, y: 0, width: 67.adjustedWidth, height: 28.adjustedHeight))
    
    let saleView = UIView()
    let saleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 8.adjustedWidth, height: 22.adjustedHeight))
    let saleTriangle = UIImageView()
    
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
        
        noticeButton.do {
            $0.makeCornerRound(radius: 8.adjustedHeight)
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
        }
        
        noticeButtonImageView.do {
            $0.image = ImageLiterals.MyYello.icMegaphone
            $0.isUserInteractionEnabled = false
        }
        
        noticeButtonLabel.do {
            $0.textColor = .white
            $0.font = .uiLabelLarge
            $0.isUserInteractionEnabled = false
        }
        
        clickMeButtonLabel.do {
            $0.text = StringLiterals.MyYello.NavigationBar.clickMe
            $0.textColor = .yelloMain500
            $0.font = .uiLabelLarge
            $0.isUserInteractionEnabled = false
            $0.isHidden = true
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
            $0.applyGradientBackground(topColor: UIColor(hex: "D96AFF"), bottomColor: UIColor(hex: "7C57FF"), startPointY: 0.5, endPointY: 0.5)
            $0.makeCornerRound(radius: 16.adjustedHeight)
            $0.layer.cornerCurve = .continuous
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
        
        saleLabel.do {
            $0.backgroundColor = .purpleSub500
            $0.text = StringLiterals.MyYello.NavigationBar.sale
            $0.textColor = .white
            $0.font = .uiBodyMedium
            $0.makeCornerRound(radius: 4.adjustedHeight)
            $0.textAlignment = .center
        }
        
        saleTriangle.do {
            $0.image = ImageLiterals.MyYello.icSalePolygon
            $0.contentMode = .scaleAspectFill
        }
    }
    
    override func setLayout() {
        self.addSubviews(titleLabel,
                         shopBackgroundView,
                         noticeButton,
                         yelloNumberLabel,
                         yelloCountLabel,
                         countSkeletonLabel,
                         saleView)
        
        saleView.addSubviews(saleLabel,
                             saleTriangle)
        
        noticeButton.addSubviews(noticeButtonImageView,
                                 noticeButtonLabel,
                                 clickMeButtonLabel)
        
        shopBackgroundView.addSubview(shopButton)
        
        self.snp.makeConstraints {
            $0.height.equalTo(128.adjustedHeight)
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
        
        noticeButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(36.adjustedHeight)
        }
        
        noticeButtonImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8.adjustedWidth)
            $0.centerY.equalToSuperview()
        }
        
        noticeButtonLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(noticeButtonImageView.snp.trailing).offset(4.adjustedWidth)
        }
        
        clickMeButtonLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12.adjustedWidth)
        }
        
        yelloNumberLabel.snp.makeConstraints {
            $0.centerY.equalTo(yelloCountLabel)
            $0.leading.equalTo(titleLabel)
        }
        
        yelloCountLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10.adjustedHeight)
            $0.leading.equalTo(yelloNumberLabel.snp.trailing).inset(-4.adjustedWidth)
        }
        
        countSkeletonLabel.snp.makeConstraints {
            $0.top.equalTo(noticeButton.snp.bottom).offset(14.adjustedHeight)
            $0.leading.equalTo(titleLabel)
            $0.height.equalTo(16.adjustedHeight)
            $0.width.equalTo(70.adjustedWidth)
        }
        
        shopButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.bottom.top.equalToSuperview().inset(2.adjustedWidth)
        }
        
        saleView.snp.makeConstraints {
            $0.centerY.equalTo(shopBackgroundView)
            $0.trailing.equalTo(shopBackgroundView.snp.leading).offset(-6.adjustedHeight)
            $0.height.equalTo(22.adjustedHeight)
            $0.width.equalTo(55.adjustedWidth)
        }
        
        saleLabel.snp.makeConstraints {
            $0.height.equalTo(22.adjustedHeight)
            $0.width.equalTo(48.adjustedWidth)
        }
        
        saleTriangle.snp.makeConstraints {
            $0.width.height.equalTo(10.adjusted)
            $0.centerY.equalTo(saleLabel)
            $0.leading.equalTo(saleLabel.snp.trailing).offset(-3.adjustedWidth)
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
