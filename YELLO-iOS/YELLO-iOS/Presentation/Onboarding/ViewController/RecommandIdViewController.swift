//
//  RecommandIdViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

class RecommandIdViewController: OnboardingBaseViewController {
    
    let skipButton = UIButton()
    
    override func loadView() {
        super.loadView()
        super.isSkipable = true
        super.nextViewController = OnboardingEndViewController()
        view = RecommandIdView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

}
