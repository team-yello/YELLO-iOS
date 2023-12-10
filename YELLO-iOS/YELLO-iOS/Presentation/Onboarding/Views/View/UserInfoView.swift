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
    
    // MARK: Component
    let guideImageView = UIImageView()
    let idTextField = YelloTextFieldView(title: StringLiterals.Onboarding.Id.idTitle, state: .id,
                                         placeholder: StringLiterals.Onboarding.Id.idPlaceholder,
                                         helper: StringLiterals.Onboarding.Id.idHelper)
    let idLabel = UILabel()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        guideImageView.do {
            $0.image = ImageLiterals.OnBoarding.idGuide
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
