//
//  GenderViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/07.
//

import UIKit

import SnapKit
import Then

class GenderViewController: OnboardingBaseViewController {
    // MARK: - Variables
    // MARK: Property
    var gender: Gender?
    var genderString: String = ""
    
    // MARK: Component
    let baseView = GenderView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.nextViewController = AddFriendsViewController()
    }
    
    // MARK: Layout Helpers
    override func setStyle() {
        [baseView.femaleButton, baseView.maleButton].forEach({
            $0.addTarget(self, action: #selector(genderButtonDidTap), for: .touchUpInside)
        })
    }
    
    override func setLayout() {
        view.addSubview(baseView)
        
        baseView.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: Custom Method
    func checkEnableButton() {
        if gender != nil {
            super.nextButton.setButtonEnable(state: true)
        }
    }
    
    // MARK: Objc Function
    @objc func genderButtonDidTap(_ sender: YelloSelectButton) {
        self.gender = sender.gender
        guard let gender = self.gender else { return }
        switch gender {
        case .female:
            genderString = "FEMALE"
        case .male:
            genderString = "MALE"
        }
        User.shared.gender = genderString
        checkEnableButton()
    }
}
