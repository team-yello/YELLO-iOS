//
//  SchoolSearchView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//

import UIKit

import Then
import SnapKit

final class SchoolSearchView: BaseView {
    // MARK: - Variables
    
    // MARK: Constants
    let padding = 16
    let topMargin = 20
    let bottomMargin = 34
    
    // MARK: Property

    // MARK: Component
    let infoLabel = UILabel()
    let schoolTextField = YelloTextFieldView(title: "학교가 어디인가요?", state: iconState.search)
    let nextButton = YelloButton(buttonText: "다음", state: .unabled)
    
    // MARK: - Function
    
    // MARK: Layout Helpers
    override func setStyle() {
        infoLabel.do {
            $0.text = "엘로에 가입하기 위한 절차에요."
            $0.font = .uiBody02
            $0.textColor = .grayscales600
        }
    }
    
    override func setLayout() {
        self.addSubviews(infoLabel, schoolTextField)
        infoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(padding)
            $0.top.equalToSuperview().offset(topMargin)
        }
        
        schoolTextField.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview().inset(padding)
        }
  
    }

    // MARK: Custom Function

    // MARK: Objc Function

}
