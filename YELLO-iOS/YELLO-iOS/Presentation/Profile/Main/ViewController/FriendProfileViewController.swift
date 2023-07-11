//
//  FriendProfileViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class FriendProfileViewController: BaseViewController {
    
    let friendProfileView = FriendProfileView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func setStyle() {
        view.backgroundColor = .black
        friendProfileView.handleBottomSheetButtonDelegate = self
    }
    
    override func setLayout() {
        view.addSubview(friendProfileView)
        
        friendProfileView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension FriendProfileViewController: HandleBottomSheetButtonDelegate {
    func dismissView() {
        self.dismiss(animated: true)
    }
}
