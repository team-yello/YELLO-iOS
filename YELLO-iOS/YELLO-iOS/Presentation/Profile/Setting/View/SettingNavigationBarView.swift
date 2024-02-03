//
//  SettingNavigationBarView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

// MARK: - Protocol
protocol HandleBackButtonDelegate: AnyObject {
    func popView()
}

protocol HandleSaveButtonDelegate: AnyObject {
    func saveModifiedInfo()
}

final class SettingNavigationBarView: UIView {
    
    // MARK: - Variables
    // MARK: Property
    weak var handleBackButtonDelegate: HandleBackButtonDelegate?
    weak var handleSaveButtonDelegate: HandleSaveButtonDelegate?
    var isHasSaveButton: Bool = false {
        didSet {
            setUI()
        }
    }
    
    // MARK: Component
    lazy var backButton = UIButton()
    let titleLabel = UILabel()
    let saveButton = UIButton()
    
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
extension SettingNavigationBarView {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.Setting.setting, lineHeight: 24.adjustedHeight)
            $0.textColor = .white
            $0.font = .uiSubtitle05
        }
        
        backButton.do {
            $0.setImage(ImageLiterals.Profile.icArrowLeftWhite, for: .normal)
            $0.imageView?.tintColor = .white
            $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        }
        
        saveButton.do {
            $0.setTitle(StringLiterals.Profile.EditProfile.saveButton, for: .normal)
            $0.titleLabel?.font = .uiButton
            $0.setTitleColor(.white, for: .normal)
            $0.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        self.addSubviews(backButton,
                         titleLabel,
                         saveButton)
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(backButton.snp.trailing).offset(8.adjustedWidth)
        }
        
        saveButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16.adjustedWidth)
        }
        
        saveButton.isHidden = !isHasSaveButton
    }
    
    // MARK: Objc Function
    @objc private func backButtonDidTap() {
        self.handleBackButtonDelegate?.popView()
    }
    
    @objc private func saveButtonDidTap() {
        self.handleSaveButtonDelegate?.saveModifiedInfo()
    }
}
