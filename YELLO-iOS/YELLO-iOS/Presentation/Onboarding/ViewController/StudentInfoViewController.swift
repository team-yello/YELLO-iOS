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
    let majorSearchViewController = FindMajorViewController()
    let studentIdViewController = StudentIdViewController()
    let bottomSheet = BaseBottomViewController()
    let studentIdView = StudentIdView()
    
    // MARK: Component
    private let baseView = StudentInfoView()
    var schoolName: String = "" {
        didSet {
            resetTextField()
        }
    }
    var groupId = 0
    var groupAdmissionYear = 0
    weak var delegate: SelectStudentIdDelegate?
    
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
        majorSearchViewController.majorDelegate = self
        studentIdView.idDelegate = self
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
        
        if #available(iOS 15.0, *) {
            let nav = UINavigationController(rootViewController: studentIdViewController)
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
                if #available(iOS 16.0, *) {
                    sheet.invalidateDetents()
                }
            }
        } else {
            
            bottomSheet.setCustomView(view: studentIdView)
            bottomSheet.modalPresentationStyle = .overFullScreen
            present(bottomSheet, animated: false)
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
    
    override func setUser() {
        print("id: \(groupId), year: \(groupAdmissionYear)")
        User.shared.groupId = groupId
        User.shared.groupAdmissionYear = groupAdmissionYear
    }
    
}

// MARK: - extension
// MARK: UITextFieldDelegate
extension StudentInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case baseView.majorTextField.textField:
            let nextViewController = majorSearchViewController
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
    func didSelectStudentId(_ result: Int) {
        baseView.studentIDTextField.textField.setButtonState(state: .done)
        baseView.studentIDTextField.textField.text = "\(result)학번"
        groupAdmissionYear = result
        checkButtonEnable()
        bottomSheet.dismiss(animated: false)
    }
}


// MARK: StudentIdView
extension StudentInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentCell = tableView.cellForRow(at: indexPath),
              let cellTitle = currentCell.textLabel?.text else {
            return
        }
        
        // 학번 문자열에서 숫자 부분 추출
        let studentId = cellTitle.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        guard let studentId = Int(studentId) else { return }
        delegate?.didSelectStudentId(studentId)
        self.dismiss(animated: true)
    }
}

extension StudentInfoViewController: FindMajorViewControllerDelegate {
    func didDismissFindMajorViewController(with groupList: GroupList) {
        self.groupId = groupList.groupID
    }
}
