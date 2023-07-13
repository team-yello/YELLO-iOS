//
//  StudentInfoViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//

import UIKit

class StudentInfoViewController: OnboardingBaseViewController {
    
    private let baseView = StudentInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.nextViewController = UserInfoViewController()
        setDelegate()
    }
    
    override func setLayout() {
        view.addSubview(baseView)
        baseView.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.bottom) // 상단 레이아웃 가이드 아래로 배치
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        baseView.majorTextField.textField.delegate = self
        baseView.studentIDTextField.textField.delegate = self
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
}

extension StudentInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case baseView.majorTextField.textField:
            let nextViewController = FindMajorViewController()
            nextViewController.delegate = self
            self.present(nextViewController, animated: true)
        case baseView.studentIDTextField.textField:
            textField.resignFirstResponder()
            presentModal()
        default:
            return
        }
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

extension StudentInfoViewController: SearchResultTableViewSelectDelegate {
    func didSelectSearchResult(_ result: String) {
        baseView.majorTextField.textField.setButtonState(state: .done)
        baseView.majorTextField.textField.text = result
        checkButtonEnable()
    }
}

extension StudentInfoViewController: SelectStudentIdDelegate {
    func didSelectStudentId(_ result: String) {
        baseView.studentIDTextField.textField.setButtonState(state: .done)
        baseView.studentIDTextField.textField.text = result
        checkButtonEnable()
    }
}
