//
//  NameViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/10.
//

import UIKit

import SnapKit
import Then

class NameViewController: OnboardingBaseViewController {
    // MARK: - Variables
    var isButtonEnable = false
    
    let userinfoViewController = UserInfoViewController()
    
    // MARK: Component
    private let baseView = NameView()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        step = 4
        super.viewDidLoad()
        setDelegate()
        super.nextViewController = userinfoViewController
        
    }
    
    // MARK: Layout Helper
    
    override func setStyle() {
        baseView.nameTextFieldView.textField.cancelButton.do {
            $0.addTarget(self, action: #selector(nameCancelTapped), for: .touchUpInside)
            checkButtonEnable()
        }
    }
    
    @objc func nameCancelTapped() {
        baseView.nameTextFieldView.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.nameHelper, State: .normal)
    }
    
    override func setLayout() {
        view.addSubview(baseView)
        baseView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    func setDelegate() {
        baseView.nameTextFieldView.textField.delegate = self
        
    }
    
    // MARK: Custom Function
    func checkButtonEnable() {
        let nameTextFieldView = baseView.nameTextFieldView
        
        guard let isNameEmpty = nameTextFieldView.textField.text?.isEmpty else { return }
        guard let isKoreanOnly = nameTextFieldView.textField.text?.isContainKorean() else { return }
        
        nameTextFieldView.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.nameHelper, State: .normal)
        
        if !isNameEmpty, !isKoreanOnly {
            // 한글로만 이루어져 있지 않으면 에러 처리
            nameTextFieldView.textField.setButtonState(state: .error)
            nameTextFieldView.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.nameError, State: .error)
            self.isButtonEnable = false
        } else if isNameEmpty {
            nameTextFieldView.textField.setButtonState(state: .normal)
            nameTextFieldView.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.nameHelper, State: .normal)
        }
        
        if !isNameEmpty, isKoreanOnly {
            nextButton.setButtonEnable(state: true)
            nameTextFieldView.textField.setButtonState(state: .done)
        } else {
            nextButton.setButtonEnable(state: false)
        }
    }
    
    override func setUser() {
        guard let name = baseView.nameTextFieldView.textField.text else { return }
        User.shared.name = name
    }
    
}

// MARK: - extension
// MARK: UITextFieldDelegate
extension NameViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let nameTextField = baseView.nameTextFieldView.textField
        nameTextField.setButtonState(state: .cancel)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.checkButtonEnable()
    }
    
}
