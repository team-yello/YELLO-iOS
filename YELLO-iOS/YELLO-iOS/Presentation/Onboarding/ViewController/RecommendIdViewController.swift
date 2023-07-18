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
    let baseView = RecommendIdView()
    let text = ""
    
    // MARK: - Function
    // MARK: LifeCycle
    override func loadView() {
        super.loadView()
        super.isSkipable = true
        super.nextViewController = OnboardingEndViewController()
        view = baseView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        addTarget()
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
        }
        
        let isButtonEnabled = !(idText.isEmpty) && isValidId && isExisted
        if isButtonEnabled {
            baseView.recommendIdTextField.textField.setButtonState(state: .done)
            baseView.recommendIdTextField.helperLabel.setLabelStyle(text: "", State: .done)
            baseView.recommendIdTextField.textField.rightViewMode = .never
        }
        nextButton.setButtonEnable(state: isButtonEnabled)
    }
    
    func checkIdValid(text: String) {
        let queryDTO = IdValidRequestQueryDTO(yelloId: text)
        
        NetworkService.shared.onboardingService.getCheckDuplicate(queryDTO: queryDTO) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let data = data.data else {
                        if data.status == 404 {
                            self?.isExisted = false
                            self?.checkButtonEnable()
                        }
                        return
                    }
                    if data {
                        self?.isExisted = true
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
