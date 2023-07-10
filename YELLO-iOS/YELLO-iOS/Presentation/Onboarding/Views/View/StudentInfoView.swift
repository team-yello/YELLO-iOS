//
//  StudentInfoView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//

import UIKit

import SnapKit
import Then

final class StudentInfoView: BaseView {
    
    let padding = 16
    
    let majorTextField = YelloTextFieldView(title: "무슨 학과인가요?", state: .search)
    let studentIDTextField = YelloTextFieldView(title: "몇 학번인가요?", state: .toggle)
    
    override func setStyle() {
        self.backgroundColor = .white
    }
    
    override func setLayout() {
        self.addSubviews(majorTextField,studentIDTextField)
        
        majorTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(padding)
        }
        
        studentIDTextField.snp.makeConstraints {
            $0.top.equalTo(majorTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(padding)
        }
        
    }
}
 
