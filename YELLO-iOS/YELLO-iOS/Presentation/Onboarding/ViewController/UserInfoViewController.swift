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
    
    let maxLength = 20
    let addFriendViewController = AddFriendsViewController()
    
    // MARK: Component
    private let baseView = UserInfoView()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        step = 3
        super.viewDidLoad()
        setDelegate()
        super.nextViewController = addFriendViewController
        
    }
    
    // MARK: Layout Helper
    
    override func setStyle() {
        baseView.idTextField.textField.cancelButton.do {
            $0.addTarget(self, action: #selector(idCancelTapped), for: .touchUpInside)
            checkButtonEnable()
        }
    }
    
    @objc func idCancelTapped() {
        baseView.idTextField.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.idHelper, State: .id)
        baseView.idTextField.textField.setButtonState(state: .id)
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
        NotificationCenter.default.addObserver(self,
                                                       selector: #selector(textDidChange(_:)),
                                                       name: UITextField.textDidChangeNotification,
                                               object: baseView.idTextField.textField)
        baseView.idTextField.textField.delegate = self
        
    }
    
    // MARK: Custom Function
    func checkButtonEnable() {
        let idTextFieldView = baseView.idTextField
        
        guard let isIDEmpty = idTextFieldView.textField.text?.isEmpty else { return }
        guard let isEnglishOnly = idTextFieldView.textField.text?.isId() else { return }
        
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
        
        if !isIDEmpty, isEnglishOnly, !isIdDuplicate {
            nextButton.setButtonEnable(state: true)
            idTextFieldView.textField.setButtonState(state: .done)
        } else {
            nextButton.setButtonEnable(state: false)
        }
    }
    
    func checkDuplicate(id: String) {
        let queryDTO = IdValidRequestQueryDTO(yelloId: id)
        NetworkService.shared.onboardingService.getCheckDuplicate(queryDTO: queryDTO) { [weak self] result in
            switch result {
            case .success(let data):
                self?.isIdDuplicate = data.data
                self?.checkButtonEnable() // 중복 확인 요청이 완료된 후에만 호출
            default:
                self?.isIdDuplicate = false
                self?.checkButtonEnable() // 요청이 실패한 경우에도 호출
            }
        }
    }
    
    override func setUser() {
        guard let id = baseView.idTextField.textField.text else { return }
        User.shared.yelloId = id
    }
    
    @objc private func textDidChange(_ notification: Notification) {
            if let textField = notification.object as? UITextField {
                if let text = textField.text {
                    
                    if text.count > maxLength {
                        textField.resignFirstResponder()
                    }
                    
                    // 초과되는 텍스트 제거
                    if text.count >= maxLength {
                        let index = text.index(text.startIndex, offsetBy: maxLength)
                        let newString = text[text.startIndex..<index]
                        textField.text = String(newString)
                    }
                }
            }
        }

}

// MARK: - extension
// MARK: UITextFieldDelegate
extension UserInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        baseView.idTextField.textField.setButtonState(state: .cancel)
        baseView.idTextField.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.idHelper, State: .normal)
    
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let text = textField.text else {return false}
            
            // 최대 글자수 이상을 입력한 이후에는 중간에 다른 글자를 추가할 수 없게끔 작동
            if text.count >= maxLength && range.length == 0 && range.location < maxLength {
                return false
            }
            
            return true
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
