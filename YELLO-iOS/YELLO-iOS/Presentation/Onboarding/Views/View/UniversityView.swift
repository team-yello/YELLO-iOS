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
    // MARK: Component
    let schoolSearchTextFieldView = YelloTextFieldView(title: StringLiterals.Onboarding.schoolSearchText,
                                                       state: .search,
                                                       placeholder: StringLiterals.Onboarding.univSearchPlaceholder)
    let majorSearchTextFieldView = YelloTextFieldView(title: StringLiterals.Onboarding.majorSearchText,
                                                      state: .search,
                                                      placeholder: StringLiterals.Onboarding.majorSearchPlaceholder)
    let studentIdTextFieldView = YelloTextFieldView(title: StringLiterals.Onboarding.studentIdText,
                                                      state: .toggle,
                                                      placeholder: StringLiterals.Onboarding.studentIdPlaceholder)
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
        
    }
    
    private func setLayout() {
        self.addSubviews(schoolSearchTextFieldView, majorSearchTextFieldView ,studentIdTextFieldView)
        
        schoolSearchTextFieldView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constraints.topMargin)
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
        }
        
        majorSearchTextFieldView.snp.makeConstraints {
            $0.top.equalTo(schoolSearchTextFieldView.snp.bottom).offset(30.adjusted)
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
        }
        
        studentIdTextFieldView.snp.makeConstraints {
            $0.top.equalTo(majorSearchTextFieldView.snp.bottom).offset(30.adjusted)
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
        }
    }
        
    // MARK: Custom Function
}
