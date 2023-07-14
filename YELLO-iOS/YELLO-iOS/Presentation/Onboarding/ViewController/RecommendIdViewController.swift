//
//  RecommendIdViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

class RecommendIdViewController: OnboardingBaseViewController {
    // MARK: - Variables
    // MARK: Component 
    let baseView = RecommendIdView()
    
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
        
        if !isValidId {
            idTextFieldView.textField.setButtonState(state: .error)
            idTextFieldView.helperLabel.setLabelStyle(text: "존재하지 않는 아이디에요", State: .error)
        }
        
        let isButtonEnabled = !(idText.isEmpty) && isValidId
        nextButton.setButtonEnable(state: isButtonEnabled)
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        baseView.recommendIdTextField.textField.setButtonState(state: .id)
        checkButtonEnable()
    }
    
}
