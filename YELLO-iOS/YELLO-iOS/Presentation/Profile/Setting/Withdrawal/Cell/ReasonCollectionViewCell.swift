//
//  ReasonCollectionViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 1/23/24.
//

import UIKit

import SnapKit
import Then

final class ReasonCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "ReasonCollectionViewCell"
    let reasonButton = UIButton()
    let unselectedView = UIView()
    let selectedView = UIView()
    let descriptionLabel = UILabel()
    var isReasonSelected = false {
        didSet {
            setButtonStyle()
        }
    }
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        reasonButton.do {
            $0.makeCornerRound(radius: 8.adjustedHeight)
            $0.backgroundColor = .grayscales700
        }
        
        unselectedView.do {
            $0.makeCornerRound(radius: 9.adjusted)
            $0.makeBorder(width: 2, color: .grayscales700)
            $0.backgroundColor = .clear
        }
        
        selectedView.do {
            $0.makeCornerRound(radius: 4.adjusted)
            $0.backgroundColor = .white
            $0.isHidden = true
        }
        
        descriptionLabel.do {
            $0.textColor = .white
            $0.font = .uiBodyLarge
        }
    }
    
    private func setLayout() {
        self.addSubviews(reasonButton)
        reasonButton.addSubviews(unselectedView,
                                 descriptionLabel)
        unselectedView.addSubview(selectedView)
        
        reasonButton.snp.makeConstraints {
            $0.top.equalTo(56.adjustedHeight)
            $0.width.equalTo(UIScreen.main.bounds.width - 68.adjustedWidth)
        }
        
        unselectedView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
            $0.width.height.equalTo(18.adjusted)
        }
        
        selectedView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(8.adjusted)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(unselectedView.snp.trailing).offset(8.adjustedWidth)
        }
    }
    
    private func setButtonStyle() {
        if isReasonSelected {
            reasonButton.do {
                $0.backgroundColor = .black
                $0.makeBorder(width: 1, color: .white)
            }
            
            selectedView.isHidden = false
        } else {
            reasonButton.do {
                $0.backgroundColor = .grayscales700
                $0.makeBorder(width: 0, color: .clear)
            }
            
            selectedView.isHidden = true
        }
    }
}
