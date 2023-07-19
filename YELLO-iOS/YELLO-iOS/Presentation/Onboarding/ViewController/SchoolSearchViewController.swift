//
//  SchoolSearchViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//

import UIKit

import SnapKit
import Then

final class SchoolSearchViewController: OnboardingBaseViewController {
    
    // MARK: - Variables
    // MARK: Component 
    let schoolSearchView = SchoolSearchView()
    let nextVC = StudentInfoViewController()

    // MARK: - Function
    // MARK: LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        super.nextViewController = nextVC
        setDelegate()
        addTarget()
    }
    
    // MARK: Layout Helpers
    override func setLayout() {
        view.addSubviews(schoolSearchView)
        schoolSearchView.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: Custom Method
    private func setDelegate() {
        schoolSearchView.schoolTextField.textField.delegate = self
    }
    
    private func addTarget() {
        schoolSearchView.schoolTextField.textField.addTarget(self, action: #selector(didTapTextField), for: .touchUpInside)
    }
    
    private func presentModal() {
        let findSchooViewController = FindSchoolViewController()
        let nav = UINavigationController(rootViewController: findSchooViewController)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.large()]
        }
        present(nav, animated: true, completion: nil)
    }
        
    // MARK: objc Function
    @objc func didTapTextField() {
        presentModal()
    }
    
}

// MARK: - extension
// MARK: UITextFieldDelegate
extension SchoolSearchViewController: UITextFieldDelegate {
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
extension SchoolSearchViewController: SearchResultTableViewSelectDelegate {
    func didSelectSearchResult(_ result: String) {
        schoolSearchView.schoolTextField.textField.setButtonState(state: .done)
        schoolSearchView.schoolTextField.textField.text = result
        nextVC.schoolName = result
        super.nextButton.setButtonEnable(state: true)
    }
}
