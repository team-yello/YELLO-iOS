//
//  UserInfoViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//

import UIKit

class UserInfoViewController: OnboardingBaseViewController {
    
    private let baseView = UserInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.nextViewController = GenderViewController()
    }
    
    override func setLayout() {
        view.addSubview(baseView)
        baseView.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.bottom) // 상단 레이아웃 가이드 아래로 배치
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setDelegate() {
        
    }
    
    func checkButtonEnable() {
        let nameText = baseView.nameTextField.textField.text ?? ""
        let idText = baseView.idTextField.textField.text ?? ""
        
        let isNameTextFilled = !nameText.isEmpty
        let isIDTextFilled = !idText.isEmpty
        
        let isButtonEnabled = isNameTextFilled && isIDTextFilled
        
        nextButton.setButtonEnable(state: isButtonEnabled)
    }
    
}
