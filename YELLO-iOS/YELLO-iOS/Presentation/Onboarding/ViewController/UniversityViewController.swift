//
//  SchoolInfoViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/05.
//

import UIKit

class UniversityViewController: OnboardingBaseViewController {
    
    var schoolName = ""
    var groupId = 0
    var groupAdmissionYear = 0
    weak var delegate: SelectStudentIdDelegate?
    
    let baseView = UniversityView()
    let studentIdView = StudentIdView()
    let majorSearchViewController = FindMajorViewController()
    let studentIdViewController = StudentIdViewController()
    let bottomSheet = BaseBottomViewController()
    let userViewController = UserInfoViewController()
    lazy var genderViewController = GenderViewController()
    
    override func viewDidLoad() {
        step = 2
        super.viewDidLoad()
        setDelegate()
        addTarget()
    }
    
    override func setLayout() {
        
        view.addSubview(baseView)
        nextViewController = genderViewController
        
        baseView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(nextButton.snp.top)
        }
        
    }
    
    private func setDelegate() {
        baseView.schoolSearchTextField.delegate = self
        baseView.majorSearchTextField.delegate = self
        baseView.studentIdTextField.delegate = self
        majorSearchViewController.majorDelegate = self
        studentIdView.idDelegate = self
        studentIdViewController.delegate = self
    }
    
    override func setUser() {
        User.shared.groupId = self.groupId
        User.shared.groupAdmissionYear = self.groupAdmissionYear
    }
    
    private func addTarget() {
        baseView.schoolSearchTextField.addTarget(self, action: #selector(didTapTextField), for: .touchUpInside)
    }
    
    private func schoolPresentModal() {
        let findSchooViewController = FindSchoolViewController()
        self.present(findSchooViewController, animated: true)
    }
    
    private func studentIDSelect() {
        
        if #available(iOS 16.0, *) {
            let nav = UINavigationController(rootViewController: studentIdViewController)
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
                sheet.invalidateDetents()
                present(nav, animated: true, completion: nil)
            }
            
        } else {
            bottomSheet.setCustomView(view: studentIdView)
            bottomSheet.modalPresentationStyle = .overFullScreen
            present(bottomSheet, animated: false)
        }
    }
    
    func checkButtonEnable() {
        let schoolText = baseView.schoolSearchTextField.text ?? ""
        let majorText = baseView.majorSearchTextField.text ?? ""
        let studentIDText = baseView.studentIdTextField.text ?? ""
        
        let isSchoolTextFilled = !schoolText.isEmpty
        let isMajorTextFilled = !majorText.isEmpty
        let isStudentIDTextFilled = !studentIDText.isEmpty
        
        let isButtonEnabled = isSchoolTextFilled && isMajorTextFilled && isStudentIDTextFilled
        
        nextButton.setButtonEnable(state: isButtonEnabled)
    }
    
    // MARK: objc Function
    @objc func didTapTextField() {
        schoolPresentModal()
    }
    
    
}
// MARK: - extension
// MARK: UITextFieldDelegate
extension UniversityViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case baseView.schoolSearchTextField:
            let nextViewController = FindSchoolViewController()
            nextViewController.delegate = self
            self.present(nextViewController, animated: true)
        case baseView.majorSearchTextField:
            let nextViewController = majorSearchViewController
            nextViewController.schoolName = self.schoolName
            nextViewController.majorSearchDelegate = self
            self.present(nextViewController, animated: true)
        case baseView.studentIdTextField:
            textField.resignFirstResponder()
            studentIDSelect()
        default:
            return
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
}

// MARK: SearchResultTableViewSelectDelegate
extension UniversityViewController: SearchResultTableViewSelectDelegate {
    
    func didSelectSchoolResult(_ result: String) {
        baseView.schoolSearchTextField.setButtonState(state: .done)
        baseView.schoolSearchTextField.text = result
        self.schoolName = result
        checkButtonEnable()
    }
}

extension UniversityViewController: MajorSearchResultSelectDelegate {
    func didSelectMajorResult(_ result: String) {
        baseView.majorSearchTextField.setButtonState(state: .done)
        baseView.majorSearchTextField.text = result
        checkButtonEnable()
    }
}

// MARK: SelectStudentIdDelegate
extension UniversityViewController: SelectStudentIdDelegate {
    func didSelectStudentId(_ result: Int) {
        baseView.studentIdTextField.setButtonState(state: .done)
        baseView.studentIdTextField.text = "\(result)학번"
        groupAdmissionYear = result
        checkButtonEnable()
        bottomSheet.dismiss(animated: false)
    }
}

// MARK: StudentIdView
extension UniversityViewController: UITableViewDelegate {
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

extension UniversityViewController: FindMajorViewControllerDelegate {
    func didDismissFindMajorViewController(with groupList: GroupList) {
        self.groupId = groupList.groupID
    }
}