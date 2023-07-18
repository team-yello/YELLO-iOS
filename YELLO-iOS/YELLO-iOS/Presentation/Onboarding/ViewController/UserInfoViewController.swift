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
    lazy var isIdDuplicate = false
    var isCheckingDuplicate = false
    
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
        baseView.idTextField.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.idHelper, State: .id)
    }
    
    @objc func nameCancelTapped() {
        baseView.nameTextField.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.nameHelper, State: .normal)
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
    
    // MARK: Custom Function
    func checkButtonEnable() {
        let nameTextFieldView = baseView.nameTextField
        let idTextFieldView = baseView.idTextField
        
        guard let isNameEmpty = nameTextFieldView.textField.text?.isEmpty else { return }
        guard let isIDEmpty = idTextFieldView.textField.text?.isEmpty else { return }
        guard let isKoreanOnly = nameTextFieldView.textField.text?.isContainKorean() else { return }
        
        guard let isEnglishOnly = idTextFieldView.textField.text?.isId() else { return }
        
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
        
        if !isIDEmpty, !isEnglishOnly {
            // 영어, 온점, 밑줄 이외의 문자가 포함되어 있으면 에러 처리
            idTextFieldView.textField.setButtonState(state: .error)
            idTextFieldView.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.idError, State: .error)
            self.isButtonEnable = false
        } else {
            if isIdDuplicate {
                idTextFieldView.textField.setButtonState(state: .error)
                idTextFieldView.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.idDuplicate, State: .error)
            } else {
                idTextFieldView.textField.rightViewMode = .never
                idTextFieldView.textField.setButtonState(state: .id)
                idTextFieldView.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.idHelper, State: .id)
            }
        }
        
        if !isIDEmpty, !isNameEmpty, isKoreanOnly, isEnglishOnly, !isIdDuplicate {
            nextButton.setButtonEnable(state: true)
            idTextFieldView.textField.setButtonState(state: .done)
            idTextFieldView.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.nameHelper, State: .done)
            nameTextFieldView.textField.setButtonState(state: .done)
        } else {
            nextButton.setButtonEnable(state: false)
        }
    }
    
    func checkDuplicate(id: String) {
        let queryDTO = IdValidRequestQueryDTO(yelloId: id)
        NetworkService.shared.onboardingService.getCheckDuplicate(queryDTO: queryDTO) { [weak self] result in
            switch result {
            case .success(let data):
                if data.status == 404 {
                    self?.isIdDuplicate = false
                } else {
                    guard let data = data.data else { return }
                    self?.isIdDuplicate = data
                }
                self?.checkButtonEnable() // 중복 확인 요청이 완료된 후에만 호출
            default:
                self?.isIdDuplicate = false
                self?.checkButtonEnable() // 요청이 실패한 경우에도 호출
            }
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
        if textField == baseView.idTextField.textField {
            guard let idText = textField.text else { return }
            self.checkDuplicate(id: idText)
        }
        self.checkButtonEnable()
    }
    
}
