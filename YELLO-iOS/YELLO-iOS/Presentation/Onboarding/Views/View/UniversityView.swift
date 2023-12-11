//
//  UniversityView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/05.
//

import UIKit

import SnapKit
import Then

class UniversityView: UIView {
    // MARK: - Variables
    let stringLiteral = StringLiterals.Onboarding.School.self
    
    // MARK: Component
    let guideImageView = UIImageView()
    lazy var guideTitleLabel = YelloGuideLabel(labelText: stringLiteral.schoolSearchText)
    
    lazy var schoolSearchTextField = YelloTextField(state: .search,
                                                    placeholder: stringLiteral.univSearchPlaceholder)
    lazy var majorSearchTextField = YelloTextField(state: .search,
                                                   placeholder: stringLiteral.majorSearchPlaceholder)
    lazy var studentIdTextField = YelloTextField(state: .toggle,
                                                 placeholder: stringLiteral.studentIdPlaceholder)
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        guideImageView.do {
            $0.image = ImageLiterals.OnBoarding.schoolGuide
        }
    }
    
    private func setLayout() {
        self.addSubviews(guideImageView, guideTitleLabel, schoolSearchTextField, majorSearchTextField, studentIdTextField)
        
        guideImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20.adjusted)
            $0.leading.equalToSuperview().offset(0)
        }
        
        guideTitleLabel.snp.makeConstraints {
            $0.top.equalTo(guideImageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        schoolSearchTextField.snp.makeConstraints {
            $0.top.equalTo(guideTitleLabel.snp.bottom).offset(18.adjusted)
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
        }
        
        majorSearchTextField.snp.makeConstraints {
            $0.top.equalTo(schoolSearchTextField.snp.bottom).offset(16.adjusted)
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
        }
        
        studentIdTextField.snp.makeConstraints {
            $0.top.equalTo(majorSearchTextField.snp.bottom).offset(16.adjusted)
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
        }
    }
        
    // MARK: Custom Function
}
