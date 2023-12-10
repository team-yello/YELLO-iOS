//
//  NameCheckViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 12/11/23.
//

import UIKit

import SnapKit

class NameCheckViewController: UIViewController {
    // MARK: - Variables
    let nameCheckView = NameCheckView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func loadView() {
        self.navigationController?.navigationBar.isHidden = true
        self.view = nameCheckView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
    }
    
    // MARK: Custom Function
    func addTarget() {
        nameCheckView.yesButton.addTarget(self, action: #selector(yesButtonClicked), for: .touchUpInside)
        nameCheckView.noButton.addTarget(self, action: #selector(noButtonClicked), for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func noButtonClicked() {
        let nameViewController = NameViewController()
        nameViewController.initialName = UserManager.shared.name
        self.navigationController?.pushViewController(nameViewController, animated: true)
        
    }
    
    @objc func yesButtonClicked() {
        self.navigationController?.pushViewController(SchoolSelectViewController(), animated: true)
    }
}
