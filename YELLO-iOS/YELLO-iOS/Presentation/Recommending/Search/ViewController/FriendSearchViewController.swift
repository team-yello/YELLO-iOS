//
//  FriendSearchViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/02.
//

import UIKit

import SnapKit
import Then

final class FriendSearchViewController: BaseViewController {
    
    private let friendSearchView = FriendSearchView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        friendSearchView.friendSearchNavigationBarView.handleBackButtonDelegate = self
    }
    
    override func setLayout() {
        view.addSubviews(friendSearchView)
        
        friendSearchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: HandleBackButtonDelegate
extension FriendSearchViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
}
