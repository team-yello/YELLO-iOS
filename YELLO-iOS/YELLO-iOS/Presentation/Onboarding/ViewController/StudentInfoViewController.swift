//
//  StudentInfoViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//

import UIKit

import SnapKit
import Then

class StudentInfoViewController: OnboardingBaseViewController {
    
    // MARK: - Variables
    
    // MARK: Component
    private let baseView = StudentInfoView()
    var schoolName: String = "" {
        didSet{
            resetTextField()
        }
    }
    
    // MARK: - Function
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.nextViewController = UserInfoViewController()
        setDelegate()
    }
    
    // MARK: Layout Helpers
    override func setLayout() {
        view.addSubview(baseView)
        baseView.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.bottom) // 상단 레이아웃 가이드 아래로 배치
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: Custom Method
    private func setDelegate() {
        baseView.majorTextField.textField.delegate = self
        baseView.studentIDTextField.textField.delegate = self
    }
    
    private func resetTextField() {
        let majorTextField = baseView.majorTextField.textField
        let studentIDTextField = baseView.studentIDTextField.textField
        
        majorTextField.text = ""
        studentIDTextField.text = ""
        majorTextField.setButtonState(state: .search)
        studentIDTextField.setButtonState(state: .toggle)
        
        super.nextButton.setButtonEnable(state: false)
    }
    
    private func presentModal() {
        let studentIdViewController = StudentIdViewController()
        let nav = UINavigationController(rootViewController: studentIdViewController)
        studentIdViewController.delegate = self
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.invalidateDetents()
        }
        
        present(nav, animated: true, completion: nil)
    }
    
    func checkButtonEnable() {
        let majorText = baseView.majorTextField.textField.text ?? ""
        let studentIDText = baseView.studentIDTextField.textField.text ?? ""
        
        let isMajorTextFilled = !majorText.isEmpty
        let isStudentIDTextFilled = !studentIDText.isEmpty
        
        let isButtonEnabled = isMajorTextFilled && isStudentIDTextFilled
        
        nextButton.setButtonEnable(state: isButtonEnabled)
    }
}

// MARK: - extension
// MARK: UITextFieldDelegate
extension StudentInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case baseView.majorTextField.textField:
            let nextViewController = FindMajorViewController()
            nextViewController.schoolName = self.schoolName
            nextViewController.delegate = self
            self.present(nextViewController, animated: true)
        case baseView.studentIDTextField.textField:
            textField.resignFirstResponder()
            presentModal()
        default:
            return
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}

// MARK: SearchResultTableViewSelectDelegate
extension StudentInfoViewController: SearchResultTableViewSelectDelegate {
    func didSelectSearchResult(_ result: String) {
        baseView.majorTextField.textField.setButtonState(state: .done)
        baseView.majorTextField.textField.text = result
        checkButtonEnable()
    }
}

// MARK: SelectStudentIdDelegate
extension StudentInfoViewController: SelectStudentIdDelegate {
    func didSelectStudentId(_ result: String) {
        baseView.studentIDTextField.textField.setButtonState(state: .done)
        baseView.studentIDTextField.textField.text = result
        checkButtonEnable()
    }
}
