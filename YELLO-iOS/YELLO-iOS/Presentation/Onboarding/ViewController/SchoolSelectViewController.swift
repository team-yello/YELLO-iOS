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
    var schoolLevel: SchoolLevel = .high
    
    override func viewDidLoad() {
        step = 1
        super.viewDidLoad()
        nextViewController = schoolInfoViewController
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
        baseView.highSchoolButton.addTarget(self, action: #selector(setSchoolLevel(sender:)), for: .touchUpInside)
        baseView.univButton.addTarget(self, action: #selector(setSchoolLevel(sender:)), for: .touchUpInside)
    }
    
    @objc func setSchoolLevel(sender: YelloSelectButton) {
        if sender == baseView.highSchoolButton {
            schoolLevel = .high
        } else {
            schoolLevel = .univ
        }
        nextButton.setButtonEnable(state: true)
    }
    
    @objc override func didTapButton() {
        super.didTapButton()
        schoolInfoViewController.schoolLevel = self.schoolLevel
    }
    
}
