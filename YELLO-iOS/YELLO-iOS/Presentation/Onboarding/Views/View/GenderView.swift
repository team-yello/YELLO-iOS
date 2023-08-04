//
//  GenderView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/07.
//

import UIKit

import SnapKit
import Then

class GenderView: BaseView {
    // MARK: - Variables
    // MARK: Component 
    let guideLabel = YelloGuideLabel(labelText: "성별은")
    let maleButton = YelloSelectButton(buttonFormat: .gender, buttonText: "남자")
    let femaleButton = YelloSelectButton(buttonFormat: .gender, buttonText: "여자")
    
    private lazy var buttonStackView = UIStackView()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        buttonStackView.do {
            $0.addArrangedSubviews(maleButton, femaleButton)
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 9
        }
    }
    
    override func setLayout() {
        self.addSubviews(guideLabel, buttonStackView)
        
        guideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constraints.topMargin)
            $0.leading.equalToSuperview().offset(Constraints.bigMargin)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(Constraints.topMargin)
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
        }
        
    }
    
}
