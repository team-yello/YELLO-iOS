//
//  SchoolInfoViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/05.
//

import UIKit

class SchoolInfoViewController: OnboardingBaseViewController {

    var schoolLevel: SchoolLevel = .high {
        didSet {
            baseView.removeFromSuperview()
            baseView = (schoolLevel == .high) ? highSchoolView : universityView
            setLayout()
        }
    }
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
    
    override func viewDidLoad() {
        step = 2
        ProgressBarManager.shared.updateProgress(step: step)
        super.viewDidLoad()
        setDelegate()
        addTarget()
    }
    
    override func setLayout() {
        
        view.addSubview(baseView)
        nextViewController = GenderViewController()
        
        baseView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(nextButton.snp.top)
        }
        
    }
    
    private func setDelegate() {
        if baseView == universityView {
            universityView.schoolSearchTextFieldView.textField.delegate = self
            universityView.majorSearchTextFieldView.textField.delegate = self
            universityView.studentIdTextFieldView.textField.delegate = self
            majorSearchViewController.majorDelegate = self
            studentIdView.idDelegate = self
            studentIdViewController.delegate = self
        }
        
    }
    
    private func addTarget() {
        universityView.schoolSearchTextFieldView.textField.addTarget(self, action: #selector(didTapTextField), for: .touchUpInside)
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
        let majorText = universityView.majorSearchTextFieldView.textField.text ?? ""
        let studentIDText = universityView.studentIdTextFieldView.textField.text ?? ""
        
        let isMajorTextFilled = !majorText.isEmpty
        let isStudentIDTextFilled = !studentIDText.isEmpty
        
        let isButtonEnabled = isMajorTextFilled && isStudentIDTextFilled
        
        nextButton.setButtonEnable(state: isButtonEnabled)
        
    }
    // MARK: objc Function
    @objc func didTapTextField() {
        schoolPresentModal()
    }
    
}
// MARK: - extension
// MARK: UITextFieldDelegate
extension SchoolInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case universityView.schoolSearchTextFieldView.textField:
            let nextViewController = FindSchoolViewController()
            nextViewController.delegate = self
            self.present(nextViewController, animated: true)
        case universityView.majorSearchTextFieldView.textField:
            let nextViewController = majorSearchViewController
         //   nextViewController.schoolName = self.schoolName
            nextViewController.delegate = self
            self.present(nextViewController, animated: true)
        case universityView.studentIdTextFieldView.textField:
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
    func didSelectSearchResult(_ result: String) {
        universityView.schoolSearchTextFieldView.textField.setButtonState(state: .done)
        universityView.schoolSearchTextFieldView.textField.text = result
        
        universityView.majorSearchTextFieldView.textField.setButtonState(state: .done)
        universityView.majorSearchTextFieldView.textField.text = result
            checkButtonEnable()
     //   nextVC.schoolName = result
        super.nextButton.setButtonEnable(state: true)
    }
}


// MARK: SelectStudentIdDelegate
extension SchoolInfoViewController: SelectStudentIdDelegate {
    func didSelectStudentId(_ result: Int) {
        universityView.studentIdTextFieldView.textField.setButtonState(state: .done)
        universityView.studentIdTextFieldView.textField.text = "\(result)학번"
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
