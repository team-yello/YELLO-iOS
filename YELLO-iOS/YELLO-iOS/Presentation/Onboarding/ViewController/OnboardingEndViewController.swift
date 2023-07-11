//
//  OnboardingEndViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

class OnboardingEndViewController: BaseViewController {
    
    override func loadView() {
        super.loadView()
        view = OnboardingEndView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
