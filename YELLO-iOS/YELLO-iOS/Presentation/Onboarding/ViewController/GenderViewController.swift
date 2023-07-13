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
    
    let baseView = GenderView()
    var gender: Gender?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.nextViewController = AddFriendsViewController()
    }
    
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
    
    func checkEnableButton() {
        if gender != nil {
            super.nextButton.setButtonEnable(state: true)
        }
    }
    
    @objc func genderButtonDidTap(_ sender: YelloGenderButton) {
        self.gender = sender.gender
        checkEnableButton()
    }
}
