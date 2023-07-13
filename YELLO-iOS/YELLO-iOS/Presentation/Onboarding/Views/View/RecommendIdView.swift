//
//  RecommendIdView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

class RecommendIdView: BaseView {
    
    let guideLabel = YelloGuideLabel(labelText: "추천인 코드")
    let subGuideLabel = UILabel()
    let recommendIdTextField = YelloTextFieldView(title: "", state: .id,
                                                  placeholder: "추천인 아이디",
                                                  helper: "추천인의 아이디를 입력해주세요.")
    
    override func setStyle() {
        subGuideLabel.do {
            $0.text = "없다면 건너뛰어도 돼요."
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 22)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales600
        }
    }
    
    override func setLayout() {
        self.addSubviews(guideLabel, subGuideLabel, recommendIdTextField)
        
        guideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(66)
            $0.leading.equalToSuperview().inset(Constraints.bigMargin)
        }
        
        subGuideLabel.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(Constraints.bigMargin)
        }
        
        recommendIdTextField.snp.makeConstraints {
            $0.top.equalTo(subGuideLabel.snp.bottom).offset(Constraints.topMargin)
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
        }
    }
}
