//
//  UserInfoViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//

import UIKit

import SnapKit
import Then

class UserInfoViewController: OnboardingBaseViewController {
    // MARK: - Variables
    // MARK: Component 
    private let baseView = UserInfoView()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        super.nextViewController = GenderViewController()
    }
    
    // MARK: Layout Helper
    override func setLayout() {
        view.addSubview(baseView)
        baseView.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.bottom) // 상단 레이아웃 가이드 아래로 배치
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    func setDelegate() {
        baseView.idTextField.textField.delegate = self
        baseView.nameTextField.textField.delegate = self
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

// MARK: - extension
// MARK: UITextFieldDelegate
extension UserInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == baseView.nameTextField.textField {
            baseView.nameTextField.textField.setButtonState(state: .cancel)
        } else {
            baseView.idTextField.textField.setButtonState(state: .cancel)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == baseView.nameTextField.textField {
            baseView.nameTextField.textField.setButtonState(state: .normal)
        } else {
            baseView.idTextField.textField.setButtonState(state: .id)
        }
        checkButtonEnable()
    }
}
