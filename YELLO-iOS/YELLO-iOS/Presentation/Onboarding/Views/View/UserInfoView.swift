//
//  UserInfoView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/06.
//

import UIKit

class UserInfoView: UIView {
    let padding = 12
    
    let nameTextField = YelloTextFieldView(title: "이름은", state: .cancel, helper: "이름은 가입 후 바꿀 수 없으니 정확히 적어주세요!")
    let idTextField = YelloTextFieldView(title: "아이디는", state: .normal, helper: "인스타 아이디로 하면 친구들이 찾기 쉬워요! (최대 20자)")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        
    }
    
    private func setLayout() {
        self.addSubviews(nameTextField,idTextField)
        
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
