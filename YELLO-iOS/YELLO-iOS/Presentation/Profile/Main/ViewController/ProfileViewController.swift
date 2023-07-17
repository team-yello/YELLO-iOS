//
//  ProfileViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/05.
//

import UIKit

import SnapKit
import Then

final class ProfileViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    private let profileView = ProfileView()
    let friendProfileViewController = FriendProfileViewController()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.profileView.beginBatchFetch()
    }

    override func setStyle() {
        view.backgroundColor = .black
        profileView.navigationBarView.delegate = self
        profileView.handleFriendCellDelegate = self
        friendProfileViewController.friendProfileView.handleDeleteFriendButtonDelegate = self
    }
    
    override func setLayout() {
        
        let tabbarHeight = 60 + safeAreaBottomInset()
        
        view.addSubview(profileView)
        profileView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(tabbarHeight)
        }
    }
}

// MARK: NavigationBarViewDelegate
extension ProfileViewController: NavigationBarViewDelegate {
    func settingButtonTapped() {
        let profileSettingViewController = ProfileSettingViewController()
        navigationController?.pushViewController(profileSettingViewController, animated: true)
    }
}

// MARK: HandleFriendCellDelegate
extension ProfileViewController: HandleFriendCellDelegate {
    func presentModal(index: Int) {
        profileView.indexNumber = index
        friendProfileViewController.friendProfileView.configureMyProfileFriendDetailCell(profileView.myProfileFriendModelDummy[index])
        let nav = UINavigationController(rootViewController: friendProfileViewController)
    
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        present(nav, animated: true, completion: nil)
    }
}

extension ProfileViewController: HandleDeleteFriendButtonDelegate {
    func deleteFriendButtonTapped() {
        profileView.showToast(message: profileView.myProfileFriendModelDummy[profileView.indexNumber].name + StringLiterals.Profile.Friend.toastMessage)
        
        friendProfileViewController.friendProfileView.profileDeleteFriend(id: profileView.myProfileFriendModelDummy[profileView.indexNumber].userId)
        
        profileView.myProfileFriendModelDummy.remove(at: profileView.indexNumber)
        profileView.myProfileFriendModelModel.remove(at: profileView.indexNumber)
        profileView.myFriendTableView.deleteRows(at: [[0, profileView.indexNumber]], with: .right)
        
        profileView.initialProfileFriendDataCount -= 1
        profileView.friendCount -= 1
        profileView.myFriendTableView.reloadData()
        profileView.myProfileHeaderView.myProfileView.profileUser(userId: profileView.indexNumber)
    }
}
