//
//  NavigationBarView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

// MARK: - Protocol
protocol NavigationBarViewDelegate: AnyObject {
    func settingButtonTapped()
}

final class NavigationBarView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    weak var delegate: NavigationBarViewDelegate?
    
    // MARK: Component
    private let profileLabel = UILabel()
    lazy var settingButton = UIButton()

    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black
        
        profileLabel.do {
            $0.text = StringLiterals.Profile.NavigationBar.profile
            $0.textColor = .white
            $0.font = .uiHeadline03
        }
        
        settingButton.do {
            $0.setTitle(StringLiterals.Profile.NavigationBar.setting, for: .normal)
            $0.setTitleColor(.grayscales600, for: .normal)
            $0.titleLabel?.font = .uiLabelLarge
            $0.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        self.addSubviews(profileLabel,
                        settingButton)
        
        profileLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16.adjustedWidth)
        }
        
        settingButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12.adjusted)
            $0.width.equalTo(33.adjustedWidth)
            $0.height.equalTo(28.adjustedHeight)
        }
    }
    
    // MARK: Objc Function
    @objc private func settingButtonTapped() {
        delegate?.settingButtonTapped()
    }
}
