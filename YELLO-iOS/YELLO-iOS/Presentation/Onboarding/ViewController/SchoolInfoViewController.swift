//
//  SchoolInfoViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/05.
//

import UIKit

class SchoolInfoViewController: OnboardingBaseViewController {

    var schoolLevel: SchoolLevel = .univ {
        didSet {
            baseView.removeFromSuperview()
            baseView = (schoolLevel == .high) ? highSchoolView : universityView
            setLayout()
        }
    }
    
    var schoolName = ""
    var groupId = 0
    var groupAdmissionYear = 0
    weak var delegate: SelectStudentIdDelegate?
    
    lazy var baseView: UIView = UIView()
    let highSchoolView = HighSchoolView()
    let universityView = UniversityView()
    let studentIdView = StudentIdView()
    let majorSearchViewController = FindMajorViewController()
    let studentIdViewController = StudentIdViewController()
    let bottomSheet = BaseBottomViewController()
    let userViewController = UserInfoViewController()
    
    override func viewDidLoad() {
        step = 2
        ProgressBarManager.shared.updateProgress(step: step)
        super.viewDidLoad()
        setDelegate()
        addTarget()
    }
    
    override func setLayout() {
        
        view.addSubview(baseView)
        nextViewController = userViewController
        
        baseView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(nextButton.snp.top)
        }
        
    }
    
    private func setDelegate() {
        if baseView == universityView {
            universityView.schoolSearchTextField.delegate = self
            universityView.majorSearchTextField.delegate = self
            universityView.studentIdTextField.delegate = self
            majorSearchViewController.majorDelegate = self
            studentIdView.idDelegate = self
            studentIdViewController.delegate = self
        }
        
    }
    
    override func setUser() {
        User.shared.groupId = self.groupId
        User.shared.groupAdmissionYear = self.groupAdmissionYear
    }
    
    private func addTarget() {
        universityView.schoolSearchTextField.addTarget(self, action: #selector(didTapTextField), for: .touchUpInside)
        navigationBarView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    private func schoolPresentModal() {
        let findSchooViewController = FindSchoolViewController()
        self.present(findSchooViewController, animated: true)
    }
    
    private func majorPresentModal() {
        
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
        let schoolText = universityView.schoolSearchTextField.text ?? ""
        let majorText = universityView.majorSearchTextField.text ?? ""
        let studentIDText = universityView.studentIdTextField.text ?? ""
        
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
    
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: false)
    }
    
}
// MARK: - extension
// MARK: UITextFieldDelegate
extension SchoolInfoViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case universityView.schoolSearchTextField:
            let nextViewController = FindSchoolViewController()
            nextViewController.delegate = self
            self.present(nextViewController, animated: true)
        case universityView.majorSearchTextField:
            let nextViewController = majorSearchViewController
            nextViewController.schoolName = self.schoolName
            nextViewController.majorSearchDelegate = self
            self.present(nextViewController, animated: true)
        case universityView.studentIdTextField:
            textField.resignFirstResponder()
            majorPresentModal()
        default:
            return
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
}

// MARK: SearchResultTableViewSelectDelegate
extension SchoolInfoViewController: SearchResultTableViewSelectDelegate {
    
    func didSelectSchoolResult(_ result: String) {
        universityView.schoolSearchTextField.setButtonState(state: .done)
        universityView.schoolSearchTextField.text = result
        self.schoolName = result
        checkButtonEnable()
    }
}

extension SchoolInfoViewController: MajorSearchResultSelectDelegate {
    func didSelectMajorResult(_ result: String) {
        universityView.majorSearchTextField.setButtonState(state: .done)
        universityView.majorSearchTextField.text = result
        checkButtonEnable()
    }
}

// MARK: SelectStudentIdDelegate
extension SchoolInfoViewController: SelectStudentIdDelegate {
    func didSelectStudentId(_ result: Int) {
        universityView.studentIdTextField.setButtonState(state: .done)
        universityView.studentIdTextField.text = "\(result)학번"
        groupAdmissionYear = result
        checkButtonEnable()
        bottomSheet.dismiss(animated: false)
    }
}

// MARK: StudentIdView
extension SchoolInfoViewController: UITableViewDelegate {
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

extension SchoolInfoViewController: FindMajorViewControllerDelegate {
    func didDismissFindMajorViewController(with groupList: GroupList) {
        self.groupId = groupList.groupID
    }
}
