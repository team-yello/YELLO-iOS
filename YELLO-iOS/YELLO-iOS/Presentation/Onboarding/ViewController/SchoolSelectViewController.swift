//
//  StudentSelectViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/04.
//

import UIKit

class SchoolSelectViewController: OnboardingBaseViewController {
    let baseView = SchoolSelectView()
    var schoolLevel: SchoolLevel = .high
    let highSchoolViewController = HighSchoolViewController()
    let universityViewController = UniversityViewController()
    
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
    
    override func setLayout() {
        view.addSubviews(baseView)
        baseView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func addTarget() {
        baseView.highSchoolButton.addTarget(self, action: #selector(highButtonDidTap), for: .touchUpInside)
        baseView.univButton.addTarget(self, action: #selector(univButtonDidTap), for: .touchUpInside)
        baseView.highSchoolButton.checkButton.addTarget(self, action: #selector(highButtonDidTap), for: .touchUpInside)
        baseView.univButton.checkButton.addTarget(self, action: #selector(univButtonDidTap), for: .touchUpInside)
    }
    
    @objc func highButtonDidTap() {
        nextViewController = highSchoolViewController
        nextButton.setButtonEnable(state: true)
    }
    
    @objc func univButtonDidTap() {
        nextViewController = universityViewController
        nextButton.setButtonEnable(state: true)
    }
    
}
