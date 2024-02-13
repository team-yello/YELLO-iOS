//
//  StudentSelectViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/04.
//

import UIKit

class SchoolSelectViewController: OnboardingBaseViewController {
    // MARK: - Variables
    // MARK: Component
    let baseView = SchoolSelectView()
    let highSchoolViewController = HighSchoolViewController()
    let universityViewController = UniversityViewController()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarView.isHidden = false
        progressBarView.isHidden = false
        navigationBarView.backButton.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.step = 1
        addTarget()
    }
    
    // MARK: Layout Helpers
    override func setLayout() {
        view.addSubviews(baseView)
        baseView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(4.adjustedHeight)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    private func addTarget() {
        baseView.highSchoolButton.addTarget(self, action: #selector(highButtonDidTap), for: .touchUpInside)
        baseView.univButton.addTarget(self, action: #selector(univButtonDidTap), for: .touchUpInside)
        baseView.highSchoolButton.checkButton.addTarget(self, action: #selector(highButtonDidTap), for: .touchUpInside)
        baseView.univButton.checkButton.addTarget(self, action: #selector(univButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func highButtonDidTap() {
        nextViewController = highSchoolViewController
        UserManager.shared.groupType = .high
        nextButton.setButtonEnable(state: true)
    }
    
    @objc func univButtonDidTap() {
        nextViewController = universityViewController
        UserManager.shared.groupType = .univ
        nextButton.setButtonEnable(state: true)
    }
    
}
