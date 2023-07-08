//
//  VotingViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

import SnapKit
import Then

/// 추후 구현
final class VotingViewController: UIViewController {

    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let nextViewController = VotingPointViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
}
