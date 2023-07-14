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
    var isButtonEnable = false
    
    // MARK: Component
    private let baseView = UserInfoView()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        super.nextViewController = GenderViewController()
    }
    
    // MARK: Layout Helper
    
    override func setStyle() {
        baseView.idTextField.textField.cancelButton.do {
            $0.addTarget(self, action: #selector(idCancelTapped), for: .touchUpInside)
            checkButtonEnable()
        }
        
        baseView.nameTextField.textField.cancelButton.do {
            $0.addTarget(self, action: #selector(nameCancelTapped), for: .touchUpInside)
            checkButtonEnable()
        }
    }
    
    @objc func idCancelTapped() {
        baseView.idTextField.helperLabel.setLabelStyle(text: "인스타 아이디로 하면 친구들이 찾기 쉬워요! (최대 20자)", State: .id)
    }
    
    @objc func nameCancelTapped() {
        baseView.nameTextField.helperLabel.setLabelStyle(text: "이름은 가입 후 바꿀 수 없으니 정확히 적어주세요!", State: .normal)
    }
    
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
        let nameTextFieldView = baseView.nameTextField
        let idTextFieldView = baseView.idTextField
        
        guard let isNameEmpty = nameTextFieldView.textField.text?.isEmpty else { return }
        guard let isIDEmpty = idTextFieldView.textField.text?.isEmpty else { return }
        guard let isKoreanOnly = nameTextFieldView.textField.text?.isContainKorean() else { return }
        
        guard let isEnglishOnly = idTextFieldView.textField.text?.isId() else { return }
        
        if !isNameEmpty, !isKoreanOnly {
            /// 한글로만 이루어져 있지 않으면 에러 처리
            nameTextFieldView.textField.setButtonState(state: .error)
            nameTextFieldView.helperLabel.setLabelStyle(text: "한글만 입력 가능해요.", State: .error)
            self.isButtonEnable = false
        } else if isNameEmpty {
            nameTextFieldView.textField.setButtonState(state: .normal)
            nameTextFieldView.helperLabel.setLabelStyle(text: "이름은 가입 후 바꿀 수 없으니 정확히 적어주세요!", State: .normal)
        }
        if !isIDEmpty, !isEnglishOnly {
            /// 영어, 온점, 밑줄 이외의 문자가 포함되어 있으면 에러 처리
            idTextFieldView.textField.setButtonState(state: .error)
            idTextFieldView.helperLabel.setLabelStyle(text: "문자, 숫자, 밑줄, 마침표만 사용할 수 있어요.", State: .error)
            self.isButtonEnable = false
        } else {
            idTextFieldView.textField.setButtonState(state: .id)
            idTextFieldView.helperLabel.setLabelStyle(text: "인스타 아이디로 하면 친구들이 찾기 쉬워요! (최대 20자)", State: .id)
        }
        
        
        
        if !isIDEmpty, !isNameEmpty, isKoreanOnly, isEnglishOnly {
            nextButton.setButtonEnable(state: true)
        } else {
            nextButton.setButtonEnable(state: false)
        }
        
    }
    
}

// MARK: - extension
// MARK: UITextFieldDelegate
extension UserInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let nameTextField = baseView.nameTextField.textField
        let idTextField = baseView.idTextField.textField
        
        if textField == nameTextField {
            nameTextField.setButtonState(state: .cancel)
        } else {
            idTextField.setButtonState(state: .cancel)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.checkButtonEnable()
    }
    
    
}
