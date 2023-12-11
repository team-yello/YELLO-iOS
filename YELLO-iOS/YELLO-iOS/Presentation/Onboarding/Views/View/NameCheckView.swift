//
//  NameModifierView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 12/11/23.
//

import UIKit

import SnapKit
import Then

class NameCheckView: BaseView {
    // MARK: - Variables
    // MARK: Property
    let backgroundView = UIView()
    let contentsView = UIView()
    
    private let titleLabel = UILabel()
    let noButton = UIButton()
    let yesButton = UIButton()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black.withAlphaComponent(0.5)
        
        backgroundView.backgroundColor = .black

        contentsView.makeCornerRound(radius: 12.adjustedHeight)
        contentsView.backgroundColor = .grayscales900
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: "\"\(UserManager.shared.name)\"" + StringLiterals.Onboarding.CheckName.checkTitle, lineHeight: 22.adjustedHeight)
            $0.font = .uiBody01
            $0.asFont(targetString: "\"\(UserManager.shared.name)\"", font: .uiPopUpTitle)
            $0.textColor = .white
        }
        
        noButton.do {
            $0.setTitle(StringLiterals.Onboarding.CheckName.checkNoButton, for: .normal)
            $0.setTitleColor(.grayscales600, for: .normal)
            $0.titleLabel?.font = .uiButton
        }
        
        yesButton.do {
            $0.setTitle(StringLiterals.Onboarding.CheckName.checkYesButton, for: .normal)
            $0.setTitleColor(.yelloMain500, for: .normal)
            $0.titleLabel?.font = .uiButton
        }
    }
    
    override func setLayout() {
        self.addSubviews(backgroundView, contentsView)
        
        contentsView.addSubviews(titleLabel,
                                 noButton,
                                 yesButton)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentsView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(280.adjustedWidth)
            $0.height.equalTo(140.adjustedHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        noButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(23.adjustedHeight)
            $0.leading.equalToSuperview().inset(36.adjustedWidth)
            $0.height.equalTo(28.adjustedHeight)
        }
        
        yesButton.snp.makeConstraints {
            $0.bottom.equalTo(noButton)
            $0.trailing.equalToSuperview().inset(36.adjustedWidth)
            $0.width.equalTo(74.adjustedWidth)
            $0.height.equalTo(28.adjustedHeight)
        }
    }
}
