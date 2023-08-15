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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
    }
    
    // MARK: Layout Helper
    override func setLayout() {
        view.addSubview(baseView)
        baseView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: Custom Function
    private func addTarget() {
        baseView.goToYelloButton.addTarget(self, action: #selector(yelloButtondidTap), for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func yelloButtondidTap() {
        /// 온보딩 이후 rootViewController 변경
        self.baseView.goToYelloButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let yelloTabBarController = YELLOTabBarController()
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: yelloTabBarController)
            self.baseView.goToYelloButton.isEnabled = true
        }
    }
    
}
