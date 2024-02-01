//
//  ProfileViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/05.
//

import UIKit

import Amplitude
import SnapKit
import Then

final class ProfileViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    let profileView = ProfileView()
    let editProfileViewController = EditProfileViewController()
    let friendProfileViewController = FriendProfileViewController()
    let bottomSheetViewController = BottomFriendProfileViewController()
    let paymentPlusViewController = PaymentPlusViewController()
    
    var isFinishPaging = false
    var isLoadingData = false
    
    var pageCount = -1
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Amplitude.instance().logEvent("view_profile")
        Amplitude.instance().setUserProperties(["user_friends": profileView.friendCount,
                                                "user_message_received": profileView.myYelloCount,
                                                "user_subscription": profileView.isYelloPlus ? "yes" : "no",
                                                "user_ticket": profileView.ticketCount])
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.items?[2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.profileView.myProfileHeaderView.profileUser()
        self.profileView.purchaseInfo()
        self.resetProfileView()
        self.paymentPlusViewController.getProducts()
    }
    
    override func setStyle() {
        view.backgroundColor = .black
        profileView.navigationBarView.delegate = self
        profileView.handleFriendCellDelegate = self
        friendProfileViewController.friendProfileView.handleDeleteFriendButtonDelegate = self
        bottomSheetViewController.friendProfileView.handleDeleteFriendButtonDelegate = self
        profileView.handleShopButton = self
        profileView.handleEditButton = self
    }
    
    override func setLayout() {
        
        let tabbarHeight = 60 + safeAreaBottomInset()
        
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        view.addSubview(profileView)
        profileView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().inset(tabbarHeight)
        }
    }
    
    func resetProfileView() {
        self.profileView.pageCount = -1
        self.profileView.isFinishPaging = false
        self.profileView.fetchingMore = false
        self.profileView.myFriendTableView.reloadData()
        self.profileView.myProfileFriendModelDummy = []
        self.profileView.profileFriend()
    }
}

// MARK: NavigationBarViewDelegate
extension ProfileViewController: NavigationBarViewDelegate {
    func settingButtonTapped() {
        let profileSettingViewController = ProfileSettingViewController()
        Amplitude.instance().logEvent("click_profile_manage")
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
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            present(nav, animated: true, completion: nil)
        }
        
    }
}

extension ProfileViewController: HandleDeleteFriendButtonDelegate {
    func deleteFriendButtonTapped() {
        profileView.showToast(message: profileView.myProfileFriendModelDummy[profileView.indexNumber].name + StringLiterals.Profile.Friend.toastMessage)
        
        friendProfileViewController.friendProfileView.profileDeleteFriend(id: profileView.myProfileFriendModelDummy[profileView.indexNumber].userId)
        // 삭제 작업이 적용된 후에 UI 업데이트
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.profileView.myProfileFriendModelDummy.remove(at: self.profileView.indexNumber)
            self.profileView.myFriendTableView.deleteRows(at: [[0, self.profileView.indexNumber]], with: .right)
            self.profileView.myProfileHeaderView.profileUser()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.profileView.myFriendTableView.reloadData()
            }
        }
    }
}

extension ProfileViewController: HandleShopButton {
    func shopButtonTapped() {
        navigationController?.pushViewController(paymentPlusViewController, animated: true)
    }
}

extension ProfileViewController: HandleEditButton {
    func editButtonTapped() {
        editProfileViewController.userInfoList = profileView.myProfileHeaderView.userInfoList
        navigationController?.pushViewController(editProfileViewController, animated: true)
    }
}
