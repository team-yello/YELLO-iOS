//
//  AddFriendsViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/07.
//

import UIKit

class AddFriendsViewController: OnboardingBaseViewController {
    
    let baseView = AddFriendsView(count: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.nextViewController = RecommendIdViewController()
        setLayout()
        // Do any additional setup after loading the view.
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
