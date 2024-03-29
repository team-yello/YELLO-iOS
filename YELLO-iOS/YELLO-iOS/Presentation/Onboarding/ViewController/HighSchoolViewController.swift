//
//  HighSchoolViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/11.
//

import UIKit

import Amplitude
import SnapKit
import FirebaseCrashlytics
import Then

class HighSchoolViewController: OnboardingBaseViewController {
    // MARK: - Variables
    // MARK: Property
    var isSelectLevel = false
    var highSchoolName = ""
    var schoolLevel = 0
    var schoolClass = 0
    var groupId = 0
    
    // MARK: Component
    let baseView = HighSchoolView()
    let schoolSearchViewController = FindSchoolViewController()
    let studentIdViewController = StudentIdViewController()
    lazy var userViewController = UserInfoViewController()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        step = 2
        super.viewDidLoad()
        addTarget()
        setDelegate()
    }
    
    // MARK: Layout Helpers
    override func setStyle() {
        studentIdViewController.studentIdList = (1...20).map { "\($0)반" }
    }
    
    override func setLayout() {
        view.addSubview(baseView)
        nextViewController = userViewController
        baseView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(4.adjustedHeight)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    private func addTarget() {
        baseView.schoolSearchTextField.delegate = self
        baseView.classSearchTextField.delegate = self
        schoolSearchViewController.schoolSearchDelegate = self
        studentIdViewController.delegate = self
    }
    
    private func setDelegate() {
        baseView.buttonArray.forEach {
            $0.addTarget(self, action: #selector(classButtonTapped), for: .touchUpInside)
        }
    }
    
    private func classModalPresent() {
        let nav = UINavigationController(rootViewController: studentIdViewController)
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            present(nav, animated: true, completion: nil)
        }
    }
    
    func getSchoolClass(keyword: String) {
        let queryDTO = HighSchoolClassRequestQueryDTO(name: self.highSchoolName, keyword: keyword)
        NetworkService.shared.onboardingService.getHighSchoolClass(queryDTO: queryDTO) { result in
            switch result {
            case .success(let data):
                if let data = data.data {
                    self.groupId = data.groupId
                } else {
                    Crashlytics.crashlytics().log("dto: \(queryDTO) \n data: \(String(describing: data.data))")
                }
            default:
                print("network Error")
            }
        }
    }
    
    func checkButtonEnable() {
        let schoolText = baseView.schoolSearchTextField.text ?? ""
        let studentIDText = baseView.classSearchTextField.text ?? ""
        
        let isSchoolTextFilled = !schoolText.isEmpty
        let isStudentIDTextFilled = !studentIDText.isEmpty
        let isButtonEnabled = isSchoolTextFilled && isStudentIDTextFilled && self.isSelectLevel
        
        nextButton.setButtonEnable(state: isButtonEnabled)
    }
    
    override func setUser() {
        UserManager.shared.groupId = groupId
        UserManager.shared.groupAdmissionYear = schoolLevel
        var userProperties: [AnyHashable : Any] = [:]
        userProperties["user_school"] = highSchoolName
        userProperties["user_department"] = schoolLevel
        Amplitude.instance().setUserProperties(userProperties)
    }
    
    /// 학년 추출
    func extractNumbers(from text: String) -> Int {
        let numberCharacterSet = CharacterSet.decimalDigits
        let numbers = Int(text.components(separatedBy: numberCharacterSet.inverted).joined()) ?? 0
        return numbers
    }
    
    // MARK: Objc Function
    @objc func classButtonTapped(sender: UIButton) {
        sender.makeBorder(width: 1, color: .yelloMain500)
        sender.setTitleColor(.yelloMain500, for: .normal)
        baseView.buttonArray.forEach { button in
            if button != sender {
                button.setTitleColor(.grayscales700, for: .normal)
                button.makeBorder(width: 1, color: .grayscales700)
            }
        }
        isSelectLevel = true
        guard let buttonTitleLabel = sender.titleLabel else { return }
        self.schoolLevel = extractNumbers(from: buttonTitleLabel.text ?? "")
        checkButtonEnable()
    }
    
    @objc func textfieldButtonTapped(_ sender: UIButton) {
        switch sender {
        case baseView.schoolSearchTextField.searchButton:
            let nextViewController = FindSchoolViewController()
            nextViewController.schoolSearchDelegate = self
            self.present(nextViewController, animated: true)
            baseView.classSearchTextField.text = ""
        case baseView.classSearchTextField.toggleButton:
            classModalPresent()
        default:
            return
        }
    }
}

extension HighSchoolViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case baseView.schoolSearchTextField:
            let nextViewController = FindSchoolViewController()
            nextViewController.schoolSearchDelegate = self
            self.present(nextViewController, animated: true)
            baseView.classSearchTextField.text = ""
        case baseView.classSearchTextField:
            textField.resignFirstResponder()
            classModalPresent()
        default:
            return
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
}

extension HighSchoolViewController: SchoolSearchResultSelectDelegate {
    func didSelectSchoolResult(_ result: String) {
        baseView.schoolSearchTextField.text = result
        self.highSchoolName = result
        checkButtonEnable()
    }
}

extension HighSchoolViewController: SelectStudentIdDelegate {
    func didSelectStudentId(_ result: Int, type: SelectType ) {
        baseView.classSearchTextField.text = "\(result)반"
        getSchoolClass(keyword: String(result))
        checkButtonEnable()
    }
}
