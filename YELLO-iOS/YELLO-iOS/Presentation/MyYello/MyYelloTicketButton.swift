//
//  MyYelloTicketButton.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/05.
//

import UIKit

import SnapKit
import Then

final class MyYelloTicketButton: UIButton {
    
    private let keyImageView = UIImageView()
    let keyCountLabel = UILabel()
    private let keyStackView = UIStackView()
    
    private let buttonTitleLabel = UILabel()
    private let titleStackView = UIStackView()

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
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        
        self.backgroundColor = .yelloMain500
        self.makeCornerRound(radius: 31)
        self.layer.cornerCurve = .continuous
        
        keyImageView.do {
            $0.image = ImageLiterals.MyYello.icKey
        }
        
        keyCountLabel.do {
            $0.text = "0"
            $0.font = .uiSubtitle02
            $0.textColor = .purpleSub500
        }
        
        keyStackView.do {
            $0.addArrangedSubviews(keyImageView, keyCountLabel)
            $0.axis = .horizontal
            $0.spacing = 4
            $0.isUserInteractionEnabled = false
        }
        
        buttonTitleLabel.do {
            $0.text = StringLiterals.MyYello.List.keyButton
            $0.textColor = .black
            $0.font = .uiSubtitle03
        }

        
        titleStackView.do {
            $0.addArrangedSubviews(keyStackView, buttonTitleLabel)
            $0.axis = .horizontal
            $0.spacing = 12
            $0.isUserInteractionEnabled = false
        }
    }
    
    private func setLayout() {
        
        self.addSubviews(titleStackView)
        
        titleStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
