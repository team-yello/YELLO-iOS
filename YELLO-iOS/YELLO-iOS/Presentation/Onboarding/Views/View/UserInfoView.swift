//
//  UserInfoView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/06.
//

import UIKit

import SnapKit
import Then

class UserInfoView: BaseView {
    
    // MARK: - Variables
    // MARK: Constants
    let padding = 12
    
    // MARK: Component (button, label 등 코드로 만들때)
    let nameTextField = YelloTextFieldView(title: "이름은", state: .normal, placeholder: "김옐로",
                                           helper: StringLiterals.Onboarding.nameHelper)
    let idTextField = YelloTextFieldView(title: "아이디는", state: .id, placeholder: "insta_id",
                                         helper: StringLiterals.Onboarding.idHelper)
    let idLabel = UILabel()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setLayout() {
        self.addSubviews(nameTextField, idTextField)
        
        nameTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(padding)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(padding)
        }
        
    }
}
