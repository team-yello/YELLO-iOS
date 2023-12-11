//
//  NameViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/10.
//

import UIKit

import SnapKit
import Then

final class NameViewController: OnboardingBaseViewController {
    // MARK: - Variables
    var isButtonEnable = false
    var initialName = ""
    
    let userinfoViewController = UserInfoViewController()
    
    // MARK: Component
    private let baseView = NameView()
    
    // MARK: LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        navigationBarView.isHidden = true
        progressBarView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        super.nextViewController = SchoolSelectViewController()
    }
    
    // MARK: Layout Helper
    
    override func setStyle() {
        if !initialName.isEmpty {
            baseView.nameTextFieldView.textField.text = initialName
        }
        baseView.nameTextFieldView.textField.cancelButton.do {
            $0.addTarget(self, action: #selector(nameCancelTapped), for: .touchUpInside)
            checkButtonEnable()
        }
    }
    
    override func setLayout() {
        view.addSubview(baseView)
        baseView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(68.adjustedHeight)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    // MARK: Custom Function
    func setDelegate() {
        baseView.nameTextFieldView.textField.delegate = self
        baseView.nameTextFieldView.textField.addTarget(self, action: #selector(textDidChange), for: .allEvents)
        
    }
    
    func checkButtonEnable() {
        let nameTextFieldView = baseView.nameTextFieldView
        
        guard let isNameEmpty = nameTextFieldView.textField.text?.isEmpty else { return }
        guard let isKoreanOnly = nameTextFieldView.textField.text?.isContainKorean() else { return }
        
        nameTextFieldView.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.Name.nameHelper, State: .normal)
        
        if !isNameEmpty, !isKoreanOnly {
            // 한글로만 이루어져 있지 않으면 에러 처리
            nameTextFieldView.textField.setButtonState(state: .error)
            nameTextFieldView.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.Name.nameError, State: .error)
            self.isButtonEnable = false
        } else if isNameEmpty {
            nameTextFieldView.textField.setButtonState(state: .normal)
            nameTextFieldView.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.Name.nameHelper, State: .normal)
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
        UserManager.shared.name = name
    }
    
    // MARK: objc Function
    @objc func nameCancelTapped() {
        baseView.nameTextFieldView.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.Name.nameHelper, State: .normal)
        nextButton.setButtonEnable(state: false)
    }
    
    @objc private func textDidChange(_ textField: UITextField) {
        let maxLength = 4
        if let text = textField.text {
            
            if text.count > maxLength {
                // 8글자 넘어가면 자동으로 키보드 내려감
                textField.resignFirstResponder()
            }
            
            // 초과되는 텍스트 제거
            if text.count >= maxLength {
                let index = text.index(text.startIndex, offsetBy: maxLength)
                let newString = text[text.startIndex..<index]
                textField.text = String(newString)
            }
        }
        baseView.nameTextFieldView.textField.setButtonState(state: .cancel)
        checkButtonEnable()
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
    
}
