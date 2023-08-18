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
    let stringLiteral = StringLiterals.Onboarding.self
    
    // MARK: Component
    let guideImageView = UIImageView()
    lazy var idTextField = YelloTextFieldView(title: stringLiteral.idTitle, state: .id,
                                              placeholder: stringLiteral.idPlaceholder)
    let idLabel = UILabel()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        guideImageView.do {
            $0.image = ImageLiterals.OnBoarding.idGuide
        }
        
        idTextField.helperLabel.do {
            $0.text = stringLiteral.idHelper
            $0.asColors(targetStrings: ["인스타그램", "아이디"], color: .yelloMain500)
        }
    }
    
    override func setLayout() {
        self.addSubviews(guideImageView, idTextField)
        
        guideImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20.adjusted)
            $0.leading.equalToSuperview()
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(guideImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(32.adjusted)
        }
        
    }
}
