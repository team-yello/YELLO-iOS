//
//  MyProfileView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import Amplitude
import SnapKit
import Then

final class MyProfileView: UIView {
    
    // MARK: - Variables
    // MARK: Property
    var redirectionURL: String = ""
    
    // MARK: Component
    let mainProfileView = MainProfileView()
    
    let messageInfoView = InfoView()
    let friendInfoView = InfoView()
    let pointInfoView = InfoView()
    
    let infoStackView = UIStackView()
    
    lazy var shopButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 44.adjustedHeight))
    let shopBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 343.adjustedWidth, height: 48.adjustedHeight))
    let saleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 22.adjustedHeight))
    
    let notificationImageView = UIImageView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadProfileNoti()
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom Function
    func loadProfileNoti() {
        NetworkService.shared.notificationService.userNotification(typeName: "PROFILE-BANNER") { result in
            switch result {
            case .success(let data):
                if let data = data.data {
                    self.notificationImageView.kfSetImage(url: data.imageUrl)
                    self.redirectionURL = data.redirectUrl
                }
            default:
                print("프로필 공지사항")
            }
        }
    }
    
}

// MARK: - extension
extension MyProfileView {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        messageInfoView.do {
            $0.descriptionLabel.text = StringLiterals.Profile.Count.message
        }
        
        friendInfoView.do {
            $0.descriptionLabel.text = StringLiterals.Profile.Count.friend
        }
        
        pointInfoView.do {
            $0.descriptionLabel.text = StringLiterals.Profile.Count.point
        }
        
        infoStackView.do {
            $0.addArrangedSubviews(messageInfoView, friendInfoView, pointInfoView)
            $0.spacing = 8.adjustedWidth
            $0.alignment = .fill
        }
        
        shopButton.do {
            $0.setImage(ImageLiterals.MyYello.icShop, for: .normal)
            $0.setTitle(StringLiterals.MyYello.NavigationBar.shop, for: .normal)
            $0.titleLabel?.font = .uiBodyMedium
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 5.adjustedWidth)
            $0.makeCornerRound(radius: 22.adjustedHeight)
            $0.layer.cornerCurve = .continuous
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .black
        }
        
        shopBackgroundView.do {
            $0.applyGradientBackground(topColor: UIColor(hex: "D96AFF"), bottomColor: UIColor(hex: "7C57FF"), startPointY: 0.5, endPointY: 0.5)
            $0.makeCornerRound(radius: 24.adjustedHeight)
            $0.layer.cornerCurve = .continuous
        }
        
        saleLabel.do {
            $0.backgroundColor = .purpleSub500
            $0.text = StringLiterals.MyYello.NavigationBar.sale
            $0.textColor = .white
            $0.font = .uiBodyMedium
            $0.makeCornerRound(radius: 4.adjustedHeight)
            $0.textAlignment = .center
        }
        
        notificationImageView.do {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapNotification))
            $0.makeCornerRound(radius: 12.adjusted)
            $0.addGestureRecognizer(tapGesture)
            $0.isUserInteractionEnabled = true
            $0.backgroundColor = .red
        }
    }
    
    private func setLayout() {
        self.addSubviews(
            mainProfileView,
            infoStackView,
            shopBackgroundView,
            saleLabel,
            notificationImageView)
        
        shopBackgroundView.addSubviews(shopButton)
        
        mainProfileView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(88.adjustedHeight)
        }
        
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(mainProfileView.snp.bottom).offset(8.adjustedHeight)
            $0.leading.trailing.equalToSuperview()
        }
        
        shopBackgroundView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
            $0.top.equalTo(infoStackView.snp.bottom).offset(12.adjustedHeight)
        }
        
        shopButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.bottom.top.equalToSuperview().inset(2.adjustedWidth)
            $0.height.equalTo(44.adjustedHeight)
        }
        
        saleLabel.snp.makeConstraints {
            $0.height.equalTo(22.adjustedHeight)
            $0.width.equalTo(48.adjustedWidth)
            $0.trailing.equalTo(shopBackgroundView).inset(6.adjustedWidth)
            $0.top.equalTo(infoStackView.snp.bottom).offset(4.adjustedHeight)
        }
        
        notificationImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(shopButton.snp.bottom).offset(10.adjusted)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(57.adjusted)
        }
    }
}
