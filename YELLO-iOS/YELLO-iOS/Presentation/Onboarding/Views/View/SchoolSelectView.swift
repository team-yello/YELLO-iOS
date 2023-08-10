//
//  SchoolSelectView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/02.
//

import UIKit

import SnapKit
import Then

class SchoolSelectView: UIView {
    let highSchoolButton = YelloSelectButton(buttonFormat: .school, buttonText: "고등학교")
    let univButton = YelloSelectButton(buttonFormat: .school, buttonText: "대학교")
    
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
        self.addSubviews(highSchoolButton, univButton)
        
        highSchoolButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview().inset(Constraints.smallMargin)
            $0.height.equalTo(146)
        }
        univButton.snp.makeConstraints {
            $0.top.equalTo(highSchoolButton.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(Constraints.smallMargin)
            $0.height.equalTo(146)
        }
        
    }
}
