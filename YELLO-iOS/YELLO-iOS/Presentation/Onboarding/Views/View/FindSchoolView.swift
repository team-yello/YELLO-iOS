//
//  FindSchoolView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//

import UIKit

final class FindSchoolView: BaseView {
    
    let padding = 16
    
    let titleLabel = UILabel()
    let schoolSearchTextField = YelloTextField()
    let helperButton = YelloHelperButton(buttonText: "우리 학교가 없나요? 학교를 추가해보세요!")
    
    override func setStyle() {
        self.backgroundColor = .white
        titleLabel.do {
            $0.text = "우리 학교 검색하기"
            $0.font = .uiSubtitle02
        }
    }
    
    override func setLayout() {
        self.addSubviews(titleLabel,schoolSearchTextField,helperButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.centerX.equalToSuperview()
        }
        
        schoolSearchTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(padding)
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
        
        helperButton.snp.makeConstraints {
            $0.top.equalTo(schoolSearchTextField.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
    }
}

