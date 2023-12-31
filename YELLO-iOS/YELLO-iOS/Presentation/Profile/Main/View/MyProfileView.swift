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
    // MARK: Component
    let mainProfileView = UIView()
    
    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 48
        .adjusted, height: 48.adjusted))
    let profileStarGradientView = UIView(frame: CGRect(x: 0, y: 0, width: 344.adjusted, height: 6.adjustedHeight))
    let profileStarImageView = UIImageView()
    
    let nameLabel = UILabel()
    let instagramLabel = UILabel()
    let schoolLabel = UILabel()
    private let separateView = UIView()
    let messageView = CountCustomView()
    let friendView = CountCustomView()
    let pointView = CountCustomView()
    
    private let addGroupButton = UIButton(frame: CGRect(x: 0, y: 0, width: 129.adjustedWidth, height: 48.adjustedHeight))
    lazy var shopButton = UIButton(frame: CGRect(x: 0, y: 0, width: 202.adjustedWidth, height: 44.adjustedHeight))
    let shopBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 206.adjustedWidth, height: 48.adjustedHeight))
    let saleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 48.adjustedWidth, height: 22.adjustedHeight))
    
    let nameSkeletonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 66.adjustedWidth, height: 16.adjustedHeight))
    let schoolSkeletonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 66.adjustedWidth, height: 16.adjustedHeight))
    
    // 옐로 플러스 여부에 따라서 달라짐
    var isYelloPlus: Bool = false {
        didSet {
            updateProfileView()
        }
    }
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        mainProfileView.do {
            $0.backgroundColor = .grayscales900
            $0.roundCorners(cornerRadius: 12.adjustedHeight, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }
        
        profileImageView.do {
            $0.backgroundColor = .grayscales800
            $0.contentMode = .scaleAspectFill
            $0.makeCornerRound(radius: 24.adjusted)
            $0.layer.cornerCurve = .continuous
        }
        
        profileStarGradientView.do {
            $0.applyGradientBackground(topColor: UIColor(hex: "D96AFF"), bottomColor: UIColor(hex: "7C57FF"), startPointY: 0.5, endPointY: 0.5)
            $0.layer.cornerCurve = .continuous
            $0.isHidden = true
        }
        
        profileStarImageView.do {
            $0.image = ImageLiterals.Profile.icProfileStar
            $0.isHidden = true
        }
        
        nameLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 30.adjustedHeight)
            $0.font = .uiHeadline02
            $0.textColor = .white
            $0.numberOfLines = 2
            $0.lineBreakMode = .byCharWrapping
        }
        
        instagramLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 20.adjustedHeight)
            $0.font = .uiBody02
            $0.textColor = .yelloMain500
        }
        
        schoolLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 16.adjustedHeight)
            $0.font = .uiLabelLarge
            $0.textColor = .grayscales400
            $0.textAlignment = .left
            $0.lineBreakMode = .byCharWrapping
        }
        
        separateView.do {
            $0.backgroundColor = .grayscales700
        }
        
        messageView.do {
            $0.countLabel.text = " "
            $0.titleLabel.text = StringLiterals.Profile.Count.message
        }
        
        friendView.do {
            $0.countLabel.text = " "
            $0.titleLabel.text = StringLiterals.Profile.Count.friend
        }
        
        pointView.do {
            $0.countLabel.text = " "
            $0.titleLabel.text = StringLiterals.Profile.Count.point
        }
        
        addGroupButton.do {
            $0.backgroundColor = .grayscales900
            $0.makeCornerRound(radius: 24.adjustedHeight)
            $0.titleLabel?.font = .uiBodyMedium
            $0.setTitleColor(.yelloMain500, for: .normal)
            $0.setImage(ImageLiterals.Profile.icPlus, for: .normal)
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 4.adjustedWidth)
            $0.setTitle(StringLiterals.Profile.MyProfile.addGroup, for: .normal)
            $0.addTarget(self, action: #selector(addGroupButtonTapped), for: .touchUpInside)
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
        
        nameSkeletonLabel.do {
            $0.backgroundColor = .grayscales800
            $0.makeCornerRound(radius: 2.adjustedHeight)
            $0.isHidden = true
        }
        
        schoolSkeletonLabel.do {
            $0.backgroundColor = .grayscales800
            $0.makeCornerRound(radius: 2.adjustedHeight)
            $0.isHidden = true
        }
        
        updateProfileView()
    }
    
    private func setLayout() {
        self.addSubviews(
            mainProfileView,
            profileStarGradientView,
            addGroupButton,
            shopBackgroundView,
            saleLabel)
        
        mainProfileView.addSubviews(profileImageView,
                                    profileStarImageView,
                                    nameLabel,
                                    instagramLabel,
                                    schoolLabel,
                                    separateView,
                                    messageView,
                                    friendView,
                                    pointView,
                                    nameSkeletonLabel,
                                    schoolSkeletonLabel
        )
        
        shopBackgroundView.addSubviews(shopButton)
        
        mainProfileView.snp.makeConstraints {
            $0.top.equalTo(profileStarGradientView.snp.bottom)
            $0.width.equalTo(343.adjustedWidth)
        }
        
        profileStarGradientView.snp.makeConstraints {
            $0.leading.trailing.equalTo(mainProfileView)
            $0.top.equalToSuperview()
            $0.height.equalTo(6.adjustedHeight)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.adjustedHeight)
            $0.leading.equalToSuperview().inset(27.5.adjustedWidth)
            $0.height.width.equalTo(48.adjusted)
        }
        
        profileStarImageView.snp.makeConstraints {
            $0.top.equalTo(mainProfileView).offset(10.adjustedHeight)
            $0.leading.equalToSuperview().inset(18.adjustedWidth)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.adjustedHeight)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12.adjustedWidth)
        }
        
        instagramLabel.snp.makeConstraints {
            $0.bottom.equalTo(nameLabel).offset(-3.adjustedHeight)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(8.adjustedWidth)
        }
        
        schoolLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalTo(nameLabel)
            $0.width.equalTo(243.adjustedWidth)
        }
        
        separateView.snp.makeConstraints {
            $0.top.equalTo(schoolLabel.snp.bottom).offset(16.adjustedHeight)
            $0.height.equalTo(1.adjusted)
            $0.leading.trailing.equalToSuperview().inset(32.adjustedWidth)
        }
        
        messageView.snp.makeConstraints {
            $0.top.equalTo(separateView.snp.bottom).offset(16.adjustedHeight)
            $0.trailing.equalTo(friendView.snp.leading).offset(-12.adjustedWidth)
            $0.height.equalTo(64.adjustedHeight)
            $0.width.equalTo(84.adjustedWidth)
            $0.bottom.equalToSuperview().inset(20.adjustedHeight)
        }
        
        friendView.snp.makeConstraints {
            $0.top.equalTo(messageView)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(64.adjustedHeight)
            $0.width.equalTo(84.adjustedWidth)
            $0.bottom.equalTo(messageView)
        }
        
        pointView.snp.makeConstraints {
            $0.top.equalTo(messageView)
            $0.leading.equalTo(friendView.snp.trailing).offset(12.adjustedWidth)
            $0.height.equalTo(64.adjustedHeight)
            $0.width.equalTo(84.adjustedWidth)
            $0.bottom.equalTo(messageView)
        }
        
        addGroupButton.snp.makeConstraints {
            $0.top.equalTo(mainProfileView.snp.bottom).offset(8.adjustedHeight)
            $0.height.equalTo(48.adjustedHeight)
            $0.width.equalTo(129.adjustedWidth)
            $0.leading.equalTo(mainProfileView)
            $0.bottom.equalToSuperview()
        }
        
        shopBackgroundView.snp.makeConstraints {
            $0.trailing.equalTo(mainProfileView)
            $0.height.equalTo(48.adjustedHeight)
            $0.width.equalTo(206.adjustedWidth)
            $0.top.equalTo(addGroupButton)
            $0.bottom.equalToSuperview()
        }
        
        shopButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.bottom.top.equalToSuperview().inset(2.adjustedWidth)
            $0.height.equalTo(44.adjustedHeight)
            $0.width.equalTo(202.adjustedWidth)
        }
        
        saleLabel.snp.makeConstraints {
            $0.height.equalTo(22.adjustedHeight)
            $0.width.equalTo(48.adjustedWidth)
            $0.trailing.equalTo(shopBackgroundView).inset(6.adjustedWidth)
            $0.top.equalTo(mainProfileView.snp.bottom).offset(4.adjustedHeight)
        }
        
        nameSkeletonLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22.adjustedHeight)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12.adjustedWidth)
            $0.height.equalTo(24.adjustedHeight)
            $0.width.equalTo(60.adjustedWidth)
        }
        
        schoolSkeletonLabel.snp.makeConstraints {
            $0.top.equalTo(nameSkeletonLabel.snp.bottom).offset(4.adjustedHeight)
            $0.leading.equalTo(nameSkeletonLabel)
            $0.height.equalTo(16.adjustedHeight)
            $0.width.equalTo(243.adjustedWidth)
        }
    }
    
    // MARK: Objc Function
    @objc private func addGroupButtonTapped() {
        let url = URL(string: "https://bit.ly/44xDDqC")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        Amplitude.instance().logEvent("click_profile_group")
    }
    
    func updateProfileView() {
        if isYelloPlus {
            mainProfileView.roundCorners(cornerRadius: 12.adjustedHeight, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            profileStarGradientView.isHidden = false
            profileStarImageView.isHidden = false
        } else {
            mainProfileView.roundCorners(cornerRadius: 12.adjustedHeight, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            profileStarGradientView.isHidden = true
            profileStarImageView.isHidden = true
        }
    }
}
