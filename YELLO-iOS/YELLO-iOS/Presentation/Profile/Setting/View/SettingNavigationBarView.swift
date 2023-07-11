//
//  SettingNavigationBarView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

protocol HandleBackButtonDelegate: AnyObject {
    func popView()
}

final class SettingNavigationBarView: UIView {
    
    weak var handleBackButtonDelegate: HandleBackButtonDelegate?
    
    lazy var backButton = UIButton()
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingNavigationBarView {
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Setting.setting, lineHeight: 24)
            $0.textColor = .white
            $0.font = .uiSubtitle05
        }
        
        backButton.do {
            $0.setImage(ImageLiterals.Profile.icArrowLeftWhite, for: .normal)
            $0.imageView?.tintColor = .white
            $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        self.addSubviews(backButton,
                         titleLabel)
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16.adjusted)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(backButton.snp.trailing).offset(8.adjusted)
        }
    }
    
    @objc
    private func backButtonDidTap() {
        self.handleBackButtonDelegate?.popView()
    }
}
