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
    
    lazy var baseView: UIView = UIView()
    let highSchoolView = HighSchoolView()
    let universityView = UniversityView()
    
    override func viewDidLoad() {
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
        }
        
    }
    
    private func addTarget() {
        universityView.schoolSearchTextFieldView.textField.addTarget(self, action: #selector(didTapTextField), for: .touchUpInside)
    }
    
    private func presentModal() {
        let findSchooViewController = FindSchoolViewController()
        self.present(findSchooViewController, animated: true)
    }
    
    // MARK: objc Function
    @objc func didTapTextField() {
        presentModal()
    }
    
}
// MARK: - extension
// MARK: UITextFieldDelegate
extension SchoolInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let nextViewController = FindSchoolViewController()
        nextViewController.delegate = self
        self.present(nextViewController, animated: true)
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
     //   nextVC.schoolName = result
        super.nextButton.setButtonEnable(state: true)
    }
}
