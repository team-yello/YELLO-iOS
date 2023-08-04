//
//  StudentSelectViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/04.
//

import UIKit

class SchoolSelectViewController: OnboardingBaseViewController {
    let baseView = SchoolSelectView()
    var schoolInfoViewController = SchoolInfoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextViewController = schoolInfoViewController
        setProgressBar()
        addTarget()
    }
    
    override func setLayout() {
        view.addSubview(baseView)
        baseView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func addTarget() {
        baseView.highSchoolButton.addTarget(self, action: #selector(setSchoolLevel(sender:)), for: .touchUpInside)
        baseView.univButton.addTarget(self, action: #selector(setSchoolLevel(sender:)), for: .touchUpInside)
    }
    
    private func setProgressBar() {
        step = 1
        ProgressBarManager.shared.updateProgress(step: step)
    }
    
    @objc func setSchoolLevel(sender: YelloSelectButton) {
        if sender == baseView.highSchoolButton {
            schoolInfoViewController.schoolLevel = .high
            print("고등학생")
            print(schoolInfoViewController.schoolLevel)
        } else {
            schoolInfoViewController.schoolLevel = .univ
            print(schoolInfoViewController.schoolLevel)
            print("대학생")
        }
        nextButton.setButtonEnable(state: true)
    }
    
}
