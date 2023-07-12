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
    override func viewDidLoad() {
        super.viewDidLoad()
        super.nextViewController = AddFriendsViewController()
    }
    override func setLayout() {
        view.addSubview(baseView)
        
        baseView.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
