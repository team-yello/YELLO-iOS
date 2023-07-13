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
        }
        
    // MARK: Custom Function
    func setDelegate() {
        baseView.recommendIdTextField.textField.delegate = self
    }
    
    func checkButtonEnable() {
        let idText = baseView.recommendIdTextField.textField.text ?? ""
        
        let isButtonEnabled = !(idText.isEmpty)
        nextButton.setButtonEnable(state: isButtonEnabled)
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