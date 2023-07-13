//
//  AddFriendsViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/07.
//

import UIKit

import SnapKit
import Then

class AddFriendsViewController: OnboardingBaseViewController {
    // MARK: - Variables
    // MARK: Component 
    let baseView = AddFriendsView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.nextViewController = RecommendIdViewController()
    }
    
    // MARK: Layout Helpers
    override func setStyle() {
        super.nextButton.setButtonEnable(state: true)
    }
    
    override func setLayout() {
        view.addSubview(baseView)
        
        baseView.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        view.bringSubviewToFront(super.nextButton)
    }
    
}
