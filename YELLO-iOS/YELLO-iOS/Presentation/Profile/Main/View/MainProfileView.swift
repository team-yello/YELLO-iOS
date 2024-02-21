//
//  ThirdMyProfileView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 1/23/24.
//

import UIKit

import Then
import SnapKit

final class MainProfileView: UIView {
    // MARK: - Variables
    // MARK: Property
    // MARK: Component
    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 48
        .adjusted, height: 48.adjusted))
    let profileStarGradientView = UIView(frame: CGRect(x: 0, y: 0, width: 344.adjusted, height: 6.adjustedHeight))
    let profileStarImageView = UIImageView()
    let editProfileButton = UIButton()
    
    let nameLabel = UILabel()
    let instagramLabel = UILabel()
    let schoolLabel = UILabel()
    
    let nameInstagramStackView = UIStackView()
    let userInfoStackView = UIStackView()
    
    let nameSkeletonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 66.adjustedWidth, height: 16.adjustedHeight))
    let schoolSkeletonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 66.adjustedWidth, height: 16.adjustedHeight))
    
    // 옐로 플러스 여부에 따라서 달라짐
    var isYelloPlus: Bool = false {
        didSet {
            updateProfileView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        
        self.do {
            $0.backgroundColor = .grayscales900
            $0.makeCornerRound(radius: 12.adjusted)
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
        
        editProfileButton.do {
            $0.setImage(ImageLiterals.Profile.icRight, for: .normal)
        }
        
        nameLabel.do {
            $0.setTextWithLineHeight(text: "", lineHeight: 28.adjustedHeight)
            $0.font = .uiHeadline02
            $0.textColor = .white
            $0.numberOfLines = 2
            $0.lineBreakMode = .byCharWrapping
        }
        
        instagramLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 16.adjustedHeight)
            $0.font = .uiBody02
            $0.textColor = .yelloMain500
        }
        
        schoolLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 16.adjustedHeight)
            $0.font = .uiLabelLarge
            $0.textColor = .grayscales400
            $0.numberOfLines = 2
            $0.textAlignment = .left
            $0.lineBreakMode = .byCharWrapping
        }
        
        nameInstagramStackView.do {
            $0.axis = .horizontal
            $0.addArrangedSubviews(nameLabel,
                                   instagramLabel)
        }
        
        userInfoStackView.do {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.addArrangedSubviews(nameInstagramStackView,
                                   schoolLabel)
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
        self.addSubviews(profileImageView,
                         profileStarImageView,
                         userInfoStackView,
                         editProfileButton,
                         profileStarGradientView,
                         nameSkeletonLabel,
                         schoolSkeletonLabel)
        
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20.adjusted)
            $0.size.equalTo(48.adjusted)
        }
        
        userInfoStackView.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        schoolLabel.snp.makeConstraints {
            $0.width.equalTo(208.adjustedWidth)
        }
        
        editProfileButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24.adjusted)
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
        
        profileStarImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10.adjustedHeight)
            $0.leading.equalToSuperview().inset(18.adjustedWidth)
        }
    }
    
    func updateProfileView() {
        if isYelloPlus {
            profileStarGradientView.isHidden = false
            profileStarImageView.isHidden = false
        } else {
            profileStarGradientView.isHidden = true
            profileStarImageView.isHidden = true
        }
    }
}
