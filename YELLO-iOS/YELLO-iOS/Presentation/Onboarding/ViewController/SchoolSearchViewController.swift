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
    
    let schoolSearchView = SchoolSearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.nextViewController = StudentInfoViewController()
        setDelegate()
        addTarget()
    }
    
    override func setLayout() {
        view.addSubviews(schoolSearchView)
        schoolSearchView.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        schoolSearchView.schoolTextField.textField.delegate = self
    }
    
    private func addTarget() {
        schoolSearchView.schoolTextField.textField.addTarget(self, action: #selector(didTapTextField), for: .touchUpInside)
    }
    
    @objc func didTapTextField() {
        presentModal()
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
}

extension SchoolSearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let nextViewController = FindSchoolViewController()
        nextViewController.delegate = self
        self.present(nextViewController, animated: true)
    }
    
}

extension SchoolSearchViewController: SearchResultTableViewSelectDelegate {
    func didSelectSearchResult(_ result: String) {
        schoolSearchView.schoolTextField.textField.setButtonState(state: .done)
        schoolSearchView.schoolTextField.textField.text = result
        super.nextButton.setButtonEnable(state: true)
    }
}
