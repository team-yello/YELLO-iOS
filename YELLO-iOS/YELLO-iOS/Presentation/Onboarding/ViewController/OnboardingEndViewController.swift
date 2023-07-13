//
//  OnboardingEndViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

class OnboardingEndViewController: BaseViewController {
    // MARK: - Variables
    // MARK: Component 
    let baseView = OnboardingEndView()
    
    // MARK: - Function
    // MARK: LifeCycle
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
    
    // MARK: Custom Function
    private func addTarget() {
        baseView.goToYelloButton.addTarget(self, action: #selector(yelloButtondidTap), for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func yelloButtondidTap() {
//        navigationController?.pushViewController(VotingStartViewController(), animated: true)
        let yelloTabBarController = YELLOTabBarController()
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: yelloTabBarController)
    }
    
}
