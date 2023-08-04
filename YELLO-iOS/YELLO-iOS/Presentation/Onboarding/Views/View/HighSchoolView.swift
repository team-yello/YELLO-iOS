//
//  HighSchoolView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/04.
//

import UIKit

import SnapKit
import Then

class HighSchoolView: UIView {
    // MARK: - Variables
    
    // MARK: Constants
    
    // MARK: Property
    
    // MARK: Component
    let schoolSearchTextFieldView = YelloTextFieldView(title: StringLiterals.Onboarding.schoolSearchText,
                                                       state: .search,
                                                       placeholder: StringLiterals.Onboarding.highSchoolSearchPlaceholder)
    let selectLevelLabel = UILabel()
    let buttonStackView = UIStackView()
    let firstLevelButton = UIButton()
    let secondLevelButton = UIButton()
    let thridLevelButton = UIButton()
    
    let selectClassTextFieldView = YelloTextFieldView(title: StringLiterals.Onboarding.selectClassText,
                                                      state: .toggle,
                                                      placeholder: StringLiterals.Onboarding.selectClassPlaceholder)
    
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
        selectLevelLabel.do {
            $0.text = StringLiterals.Onboarding.selectLevelText
            $0.font = .uiHeadline03
            $0.textColor = .white
        }
        
        firstLevelButton.do {
            $0.makeCornerRound(radius: Constraints.round)
            $0.makeBorder(width: 1, color: .grayscales500)
            $0.setTitle("1학년", for: .normal)
            $0.titleLabel?.font = .uiBodyLarge
            $0.tintColor = .grayscales500
        }
        
        secondLevelButton.do {
            $0.makeCornerRound(radius: Constraints.round)
            $0.makeBorder(width: 1, color: .grayscales500)
            $0.setTitle("2학년", for: .normal)
            $0.titleLabel?.font = .uiBodyLarge
            $0.tintColor = .grayscales500
        }
        
        thridLevelButton.do {
            $0.makeCornerRound(radius: Constraints.round)
            $0.makeBorder(width: 1, color: .grayscales500)
            $0.setTitle("3학년", for: .normal)
            $0.titleLabel?.font = .uiBodyLarge
            $0.tintColor = .grayscales500
        }
        
        buttonStackView.do {
            buttonStackView.addArrangedSubviews(firstLevelButton, secondLevelButton, thridLevelButton)
            $0.spacing = 8
            $0.distribution = .fillEqually
        }
    }
    
    private func setLayout() {
        self.addSubviews(schoolSearchTextFieldView, selectLevelLabel, buttonStackView, selectClassTextFieldView)
        
        schoolSearchTextFieldView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
        }
        
        selectLevelLabel.snp.makeConstraints {
            $0.top.equalTo(schoolSearchTextFieldView.snp.bottom).offset(30.adjusted)
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
        }
        
        [firstLevelButton, secondLevelButton, thridLevelButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(52.adjusted)
            }
        }
        
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(52.adjusted)
            $0.top.equalTo(selectLevelLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
            
        }
        
        selectClassTextFieldView.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(30.adjusted)
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
        }
        
    }
}
