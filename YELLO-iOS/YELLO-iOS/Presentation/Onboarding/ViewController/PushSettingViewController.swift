//
//  PushSettingViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/08.
//

import UIKit

class PushSettingViewController: UIViewController {
    // MARK: - Variables
    // MARK: Component (button, label 등 코드로 만들때)
    let baseView = PushSettingView()
    let onboardingEndViewController = OnboardingEndViewController()
    
    // MARK: Life Cycles
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        view.backgroundColor = .black
    }
    
    private func setLayout() {
        view.addSubview(baseView)
        baseView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func tapButton() {
        navigationController?.pushViewController(onboardingEndViewController, animated: true)
    }

}
