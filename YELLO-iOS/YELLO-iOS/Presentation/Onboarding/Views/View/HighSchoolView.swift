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
    let stringLiteral = StringLiterals.Onboarding.School.self
    // MARK: Property
    var level = 1
    
    // MARK: Component
    let guideImageView = UIImageView()
    lazy var guideTitleLabel = YelloGuideLabel(labelText: stringLiteral.schoolSearchText)
    
    let buttonStackView = UIStackView()
    lazy var buttonArray = [firstLevelButton, secondLevelButton, thridLevelButton]
    let firstLevelButton = UIButton()
    let secondLevelButton = UIButton()
    let thridLevelButton = UIButton()
    
    lazy var schoolSearchTextField = YelloTextField(state: .search, placeholder: stringLiteral.highSchoolSearchPlaceholder)
    lazy var classSearchTextField = YelloTextField(state: .toggle, placeholder: stringLiteral.selectClassPlaceholder)
    
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
        
        guideImageView.do {
            $0.image = ImageLiterals.OnBoarding.schoolGuide
        }
        
        firstLevelButton.do {
            $0.roundCorners(cornerRadius: 8, maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner] )
        }
        
        thridLevelButton.do {
            $0.roundCorners(cornerRadius: 8, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner] )
        }
        
        buttonArray.forEach({ button in
            button.do {
                $0.titleLabel?.font = .uiBodyLarge
                $0.setTitleColor(.grayscales500, for: .normal)
                $0.setTitle("\(level)학년", for: .normal)
                $0.makeBorder(width: 1, color: .grayscales700)
            }
            level += 1
        })
        
        buttonStackView.do {
            buttonStackView.addArrangedSubviews(firstLevelButton, secondLevelButton, thridLevelButton)
            $0.makeCornerRound(radius: 8)
            $0.backgroundColor = .grayscales900
            $0.distribution = .fillEqually
        }
        
    }
    
    private func setLayout() {
        self.addSubviews(guideImageView, guideTitleLabel,
                         schoolSearchTextField, buttonStackView, classSearchTextField)
        
        guideImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20.adjusted)
            $0.leading.equalToSuperview()
        }
        
        guideTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(guideImageView.snp.bottom)
        }
        
        schoolSearchTextField.snp.makeConstraints {
            $0.top.equalTo(guideTitleLabel.snp.bottom).offset(18.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(32.adjusted)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(52.adjusted)
            $0.top.equalTo(schoolSearchTextField.snp.bottom).offset(16.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(32.adjusted)
        }
        
        classSearchTextField.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(16.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(32.adjusted)
        }
        
    }
}
