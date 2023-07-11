//
//  SettingCustomButton.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class SettingCustomButton: UIButton {
    
    // MARK: - Variables
    // MARK: Property
    private let customTitleLabel = UILabel()

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
    func setUI() {
        setStyle()
        setLayout()
    }
    
    func setStyle() {
        self.backgroundColor = .grayscales900
        self.makeCornerRound(radius: 8)
        
        customTitleLabel.do {
            $0.font = .uiBodySmall
            $0.textColor = .white
        }
    }
    
    func setLayout() {
        self.addSubview(customTitleLabel)
        
        customTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
    }
    
    // MARK: Custom Function
    func updateTitle(text: String) {
        customTitleLabel.text = text
    }
}
