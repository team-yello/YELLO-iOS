//
//  EditCheckView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 3/3/24.
//

import UIKit

import SnapKit
import Then

final class EditCheckView: UIView {
    // MARK: - Variables
    // MARK: Property
    let contentsView = UIView()
    
    private let titleLabel = UILabel()
    let noButton = UIButton()
    let yesButton = UIButton()
    
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
        self.backgroundColor = .black.withAlphaComponent(0.5)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(noButtonTapped))
        self.addGestureRecognizer(tapGestureRecognizer)
        
        contentsView.do {
            $0.makeCornerRound(radius: 12.adjustedHeight)
            $0.backgroundColor = .grayscales900
            $0.makeShadow(radius: 12,
                          color: .black,
                          offset: CGSize(width: 0, height: 0),
                          opacity: 0.55)
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.EditProfile.editCheckTitle, lineHeight: 22.adjustedHeight)
            $0.font = .uiBody01
            $0.textColor = .white
        }
        
        noButton.do {
            $0.setTitle(StringLiterals.Profile.EditProfile.noButton, for: .normal)
            $0.setTitleColor(.grayscales600, for: .normal)
            $0.titleLabel?.font = .uiButton
            $0.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
        }
        
        yesButton.do {
            $0.setTitle(StringLiterals.Profile.EditProfile.yesButton, for: .normal)
            $0.setTitleColor(.yelloMain500, for: .normal)
            $0.titleLabel?.font = .uiButton
        }
    }
    
    private func setLayout() {
        self.addSubview(contentsView)
        
        contentsView.addSubviews(titleLabel,
                                 noButton,
                                 yesButton)
        
        contentsView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(280.adjustedWidth)
            $0.height.equalTo(140.adjustedHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(31.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        noButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(23.adjustedHeight)
            $0.leading.equalToSuperview().inset(27.adjustedWidth)
            $0.width.equalTo(106.adjustedWidth)
            $0.height.equalTo(28.adjustedHeight)
        }
        
        yesButton.snp.makeConstraints {
            $0.bottom.equalTo(noButton)
            $0.trailing.equalToSuperview().inset(27.adjustedWidth)
            $0.width.equalTo(106.adjustedWidth)
            $0.height.equalTo(28.adjustedHeight)
        }
    }
    
    // MARK: Objc Function
    @objc func noButtonTapped() {
        self.isHidden = true
        self.removeFromSuperview()
    }
}
