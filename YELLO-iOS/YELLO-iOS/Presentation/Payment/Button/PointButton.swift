//
//  PaymentNameKeyButton.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/11.
//

import UIKit

import SnapKit
import Then

final class PointButton: UIButton {
    
    enum RewardItem {
        case voting
        case ad
    }
    
    let pointTitleLabel = UILabel()
    let subTitleLabel = UILabel()
    let labelStackView = UIStackView()
    let pointImageView = UIImageView()
    let pointLabel = UILabel()
    
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
    
    init(reward: RewardItem) {
        super.init(frame: CGRect())
        setButtonState(reward: reward)
        setUI()
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
        
        pointImageView.do {
            $0.image = ImageLiterals.Payment.imgCoin
        }
        
        pointTitleLabel.do {
            $0.font = .uiSubtitle02
            $0.textColor = .purpleSub100
        }
        
        subTitleLabel.do {
            $0.font = .uiLabelMedium
            $0.textColor = .yelloMain500
        }
        
        labelStackView.do {
            $0.axis = .vertical
            $0.spacing = 0
            $0.alignment = .leading
            $0.addArrangedSubviews(pointTitleLabel, subTitleLabel)
            $0.isUserInteractionEnabled = false
        }
        
        pointLabel.do {
            $0.textColor = .white
            $0.font = .uiBodyMedium
            $0.isUserInteractionEnabled = false
        }
    }
    
    private func setLayout() {
        self.addSubviews(labelStackView,
                         pointImageView,
                         pointLabel)
        
        self.snp.makeConstraints {
            $0.width.equalTo(343.adjustedWidth)
            $0.height.equalTo(70.adjusted)
        }
        
        pointImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
        }
        
        labelStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(pointImageView.snp.trailing).offset(10.adjustedWidth)
        }
        
        pointLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(31.adjustedWidth)
        }
    }
    
    // MARK: Custom Function
    func setButtonState(reward: RewardItem) {
        switch reward {
        case .voting:
            pointTitleLabel.text = StringLiterals.MyYello.Payment.votingPointTitle
            pointLabel.text = StringLiterals.MyYello.Payment.votingPoint
        case .ad:
            pointTitleLabel.text = StringLiterals.MyYello.Payment.adPointTitle
            subTitleLabel.text = StringLiterals.MyYello.Payment.adPointsubTitle
            pointLabel.text = StringLiterals.MyYello.Payment.adPoint
        }
    }
}
