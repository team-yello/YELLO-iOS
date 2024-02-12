//
//  RecommendIdView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

import SnapKit
import Then

class RecommendIdView: BaseView {
    
    // MARK: - Variables
    // MARK:
    let stringLiteral = StringLiterals.Onboarding.self
    // MARK: Component
    let guideLabel = YelloGuideLabel(labelText: 
                                        StringLiterals.Onboarding.Recommand.recommandTitle)
    let subGuideLabel = UILabel()
    lazy var recommendIdTextField = YelloTextFieldView(title: "", state: .id,
                                                       placeholder: stringLiteral.Id.idPlaceholder,
                                                       helper: stringLiteral.Recommand.recommandHelper )
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        subGuideLabel.do {
            $0.text = stringLiteral.Recommand.recommandSubTitle
            $0.setTextWithLineHeight(text: $0.text, lineHeight: 22)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales600
            $0.asColor(targetString: "+100", color: .yelloMain500)
        }
        recommendIdTextField.textField.placeholder = "추천인 아이디"
    }
    
    override func setLayout() {
        self.addSubviews(guideLabel, subGuideLabel, recommendIdTextField)
        
        guideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        subGuideLabel.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(6.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        recommendIdTextField.snp.makeConstraints {
            $0.top.equalTo(subGuideLabel.snp.bottom).offset(Constraints.topMargin)
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
        }
    }
}
