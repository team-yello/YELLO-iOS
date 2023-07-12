//
//  OnboardingEndViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

class OnboardingEndViewController: BaseViewController {
    
    let baseView = OnboardingEndView()
    
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
    }
    
    private func addTarget() {
        baseView.goToYelloButton.addTarget(self, action: #selector(yelloButtondidTap), for: .touchUpInside)
    }
    
    @objc func yelloButtondidTap() {
        navigationController?.pushViewController(VotingStartViewController(), animated: true)
    }
    
}
