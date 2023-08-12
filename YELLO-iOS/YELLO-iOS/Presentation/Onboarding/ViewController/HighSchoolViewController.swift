//
//  HighSchoolViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/11.
//

import UIKit

import SnapKit
import Then

class HighSchoolViewController: OnboardingBaseViewController {
    // MARK: - Variables
    // MARK: Constants
    let schoolSearchViewController = FindSchoolViewController()
    let studentIdViewController = StudentIdViewController()
    lazy var studentIdView = StudentIdView()
    lazy var userViewController = UserInfoViewController()
    lazy var genderViewController = GenderViewController()
    let bottomSheetViewController = BaseBottomViewController()
    
    // MARK: Property
    var isSelectLevel = false
    
    // MARK: Component
    let baseView = HighSchoolView()
    
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
        studentIdView.studentIdList = (1...10).map { "\($0)반" }
        studentIdViewController.studentIdList = (1...10).map { "\($0)반" }
    }
    
    override func setLayout() {
        view.addSubview(baseView)
        nextViewController = genderViewController
        baseView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(4.adjustedHeight)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    private func addTarget() {
        baseView.schoolSearchTextField.delegate = self
        baseView.classSearchTextField.delegate = self
        schoolSearchViewController.delegate = self
        studentIdViewController.delegate = self
    }
    
    private func setDelegate() {
        baseView.buttonArray.forEach {
            $0.addTarget(self, action: #selector(didTapClassButton), for: .touchUpInside)
        }
    }
    
    private func classModalPresent() {
        
        if #available(iOS 16.0, *) {
            let nav = UINavigationController(rootViewController: studentIdViewController)
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
                sheet.invalidateDetents()
                present(nav, animated: true, completion: nil)
            }
            
        } else {
            bottomSheetViewController.setCustomView(view: studentIdView)
            bottomSheetViewController.modalPresentationStyle = .overFullScreen
            present(bottomSheetViewController, animated: false)
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
        //고등학교 정보 저장
    }
    
    // MARK: Objc Function
    @objc func didTapClassButton(sender: UIButton) {
        sender.makeBorder(width: 1, color: .yelloMain500)
        sender.setTitleColor(.yelloMain500, for: .normal)
        baseView.buttonArray.forEach { button in
            if button != sender {
                button.setTitleColor(.grayscales700, for: .normal)
                button.makeBorder(width: 1, color: .grayscales700)
            }
        }
        
        isSelectLevel = true
    }

}

extension HighSchoolViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case baseView.schoolSearchTextField:
            let nextViewController = FindSchoolViewController()
            nextViewController.delegate = self
            self.present(nextViewController, animated: true)
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

extension HighSchoolViewController: SearchResultTableViewSelectDelegate {
    func didSelectSchoolResult(_ result: String) {
        baseView.schoolSearchTextField.text = result
        checkButtonEnable()
    }
}

extension HighSchoolViewController: SelectStudentIdDelegate {
    func didSelectStudentId(_ result: Int) {
        baseView.classSearchTextField.text = "\(result)반"
        checkButtonEnable()
    }
}