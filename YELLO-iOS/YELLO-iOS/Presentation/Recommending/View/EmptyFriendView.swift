//
//  EmptyFriendView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class EmptyFriendView: UIView {
    
    private let containView = UIView()
    private let emptyImageView = UIImageView()
    private let emptyDescriptionLabel = UILabel()
    private lazy var inviteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptyFriendView {
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
        emptyImageView.do {
            $0.image = ImageLiterals.Recommending.imgBannerInvite
        }
        
        emptyDescriptionLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Recommending.Empty.title, lineHeight: 24)
            $0.numberOfLines = 2
            $0.textColor = .grayscales300
            $0.font = .uiBodyLarge
        }
        
        inviteButton.do {
            $0.setTitle(StringLiterals.Recommending.Empty.inviteButton, for: .normal)
            $0.setTitleColor(.yelloMain500, for: .normal)
            $0.titleLabel?.font = .uiSubtitle04
            $0.backgroundColor = .grayscales800
            $0.makeCornerRound(radius: 8)
        }
    }
    
    private func setLayout() {
        self.addSubview(containView)
        containView.addSubviews(emptyImageView,
                               emptyDescriptionLabel,
                               inviteButton)
        
        self.snp.makeConstraints {
            $0.height.equalTo(483.adjustedHeight)
            $0.width.equalTo(375.adjustedWidth)
        }
        
        containView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(272.adjustedHeight)
            $0.width.equalTo(236.adjustedWidth)
        }
        
        emptyImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(130.adjusted)
        }
        
        emptyDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(emptyImageView.snp.bottom).offset(16.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        inviteButton.snp.makeConstraints {
            $0.top.equalTo(emptyDescriptionLabel.snp.bottom).offset(30.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(236)
            $0.height.equalTo(48)
        }
    }
}
