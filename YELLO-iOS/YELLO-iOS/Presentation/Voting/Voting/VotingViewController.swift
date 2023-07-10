//
//  VotingViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

import SnapKit
import Then

final class VotingViewController: BaseViewController {
    
    private let button = UIButton()
    
    static var pushCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        
        view.backgroundColor = .black
        
        button.setTitle("클릭", for: .normal)
        button.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        
        view.addSubviews(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc
    func clicked() {
        let viewController = VotingViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
}

extension VotingViewController: UINavigationControllerDelegate {
    /// 뷰 컨트롤러가 푸시될 때마다 호출
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // 현재 뷰 컨트롤러가 자기 자신인 경우에만 pushCount를 증가
        if viewController == self {
            VotingViewController.pushCount += 1
            print(VotingViewController.pushCount)
            // pushCount가 10 이상이면 푸시를 막기 위해 popViewController를 호출
            if VotingViewController.pushCount >= 10 {
                let viewController = VotingPointViewController()
                self.navigationController?.pushViewController(viewController, animated: true)
                self.navigationController?.navigationBar.isHidden = true
            }
        } else {
            // 다른 뷰 컨트롤러로 이동하는 경우 pushCount를 초기화
            VotingViewController.pushCount = 0
        }
    }
}
