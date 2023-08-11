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
    let profileView = ProfileView()
    let friendProfileViewController = FriendProfileViewController()
    let bottomSheetViewController = BottomFriendProfileViewController()
    
    var isFinishPaging = false
    var isLoadingData = false
    
    var pageCount = -1
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileView.profileFriend()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.items?[2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.profileView.myProfileHeaderView.myProfileView.profileUser()
    }
    
    override func setStyle() {
        view.backgroundColor = .black
        profileView.navigationBarView.delegate = self
        profileView.handleFriendCellDelegate = self
        friendProfileViewController.friendProfileView.handleDeleteFriendButtonDelegate = self
        bottomSheetViewController.friendProfileView.handleDeleteFriendButtonDelegate = self
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
        bottomSheetViewController.friendProfileView.configureMyProfileFriendDetailCell(profileView.myProfileFriendModelDummy[index])
        
        let nav = UINavigationController(rootViewController: friendProfileViewController)
    
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
                present(nav, animated: true, completion: nil)
            }
        } else {
            bottomSheetViewController.modalPresentationStyle = .overFullScreen
            present(bottomSheetViewController, animated: false)
        }
        
    }
}

extension ProfileViewController: HandleDeleteFriendButtonDelegate {
    func deleteFriendButtonTapped() {
        profileView.showToast(message: profileView.myProfileFriendModelDummy[profileView.indexNumber].name + StringLiterals.Profile.Friend.toastMessage)
        
        friendProfileViewController.friendProfileView.profileDeleteFriend(id: profileView.myProfileFriendModelDummy[profileView.indexNumber].userId)
        bottomSheetViewController.friendProfileView.profileDeleteFriend(id: profileView.myProfileFriendModelDummy[profileView.indexNumber].userId)
        
        // 삭제할 아이템의 식별자 가져오기
        let itemToDelete = profileView.myProfileFriendModelDummy[profileView.indexNumber]
        
        // 스냅샷에서 해당 아이템 삭제
        profileView.dataSource.defaultRowAnimation = .right
        var snapshot = profileView.dataSource.snapshot()
        snapshot.deleteItems([itemToDelete])
        profileView.dataSource.apply(snapshot, animatingDifferences: true)
        self.profileView.myProfileFriendModelDummy.remove(at: self.profileView.indexNumber)
        
        // 삭제 작업이 적용된 후에 UI 업데이트
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.profileView.myProfileHeaderView.myProfileView.profileUser()
            self.profileView.initialProfileFriendDataCount -= 1
            self.profileView.friendCount -= 1
        }
        profileView.dataSource.defaultRowAnimation = .middle
    }
}
