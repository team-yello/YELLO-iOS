//
//  RecommendIdViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

class RecommendIdViewController: OnboardingBaseViewController {
    // MARK: - Variables
    var isExisted = false
    
    // MARK: Component
    let pushViewController = PushSettingViewController()
    let baseView = RecommendIdView()
    let text = ""
    
    // MARK: - Function
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        step = 5
        isSkipable = true
        nextViewController = pushViewController
        super.viewDidLoad()
        setDelegate()
        addTarget()
    }
    
    override func setStyle() {
        navigationBarView.backButton.isHidden = true
    }
    
    override func setLayout() {
        view.addSubview(baseView)
        baseView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    func setDelegate() {
        baseView.recommendIdTextField.textField.delegate = self
    }
    
    func addTarget() {
        baseView.recommendIdTextField.textField.cancelButton.addTarget(self, action: #selector(idCancelTapped), for: .touchUpInside)
    }
    
    func checkButtonEnable() {
        let idTextFieldView = baseView.recommendIdTextField
        let idText = baseView.recommendIdTextField.textField.text ?? ""
        let isValidId = idText.isId()
        
        if !isExisted {
            idTextFieldView.textField.setButtonState(state: .error)
            idTextFieldView.helperLabel.setLabelStyle(text: "존재하지 않는 아이디에요", State: .error)
            nextButton.setButtonEnable(state: false)
            return
        } else {
            idTextFieldView.textField.setButtonState(state: .cancel)
            idTextFieldView.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.recommandHelper, State: .normal)
        }
        
        let isButtonEnabled = !(idText.isEmpty) && isValidId && isExisted
        if isButtonEnabled {
            baseView.recommendIdTextField.textField.setButtonState(state: .done)
            baseView.recommendIdTextField.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.recommandHelper, State: .normal)
        }
        nextButton.setButtonEnable(state: isButtonEnabled)
    }
    
    func checkIdValid(text: String) {
        let queryDTO = IdValidRequestQueryDTO(yelloId: text)
        
        NetworkService.shared.onboardingService.getCheckDuplicate(queryDTO: queryDTO) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if data.data {
                        /// id 중복 조회 시, 중복되는 경우
                        self?.isExisted = true
                    } else {
                        /// id 중복 조회 시, 중복되지 않은 경우
                        self?.isExisted = false
                        self?.checkButtonEnable()
                    }
                    self?.checkButtonEnable()
                }
            default:
                DispatchQueue.main.async {
                    self?.checkButtonEnable()
                }
            }
        }
            }
    
    // MARK: Objc Function
    @objc func idCancelTapped() {
        baseView.recommendIdTextField.helperLabel.setLabelStyle(text: "추천인의 아이디를 입력해주세요.", State: .normal)
    }
    
    override func setUser() {
        guard let text = baseView.recommendIdTextField.textField.text else { return }
        User.shared.recommendId = text
    }
    
}

// MARK: - extension
// MARK: UITextFieldDelegate
extension RecommendIdViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        baseView.recommendIdTextField.textField.setButtonState(state: .cancel)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        baseView.recommendIdTextField.textField.setButtonState(state: .id)
        guard let text = baseView.recommendIdTextField.textField.text else { return }
        checkIdValid(text: text)
        checkButtonEnable()
    }
    
}
