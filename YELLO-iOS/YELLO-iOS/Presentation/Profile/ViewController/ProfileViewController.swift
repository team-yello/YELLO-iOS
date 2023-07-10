//
//  ProfileViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

import SnapKit
import Then

final class ProfileViewController: UIViewController {
    
    private let profileView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

extension ProfileViewController {
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .black
    }
    
    private func setLayout() {
        view.addSubview(profileView)
        
        profileView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
