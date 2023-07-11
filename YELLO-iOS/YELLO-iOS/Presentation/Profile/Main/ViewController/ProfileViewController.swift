//
//  ProfileViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/05.
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension ProfileViewController {
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
//        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .black
        profileView.navigationBarView.delegate = self
        profileView.handleFriendCellDelegate = self
    }
    
    private func setLayout() {
        
        let tabbarHeight = 60 + safeAreaBottomInset()
        
        view.addSubview(profileView)
        
        profileView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(tabbarHeight)
        }
    }
    
    func safeAreaBottomInset() -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let bottomPadding = window?.safeAreaInsets.bottom
            return bottomPadding ??  0.0
        } else {
            return 0.0
        }
    }
}

extension ProfileViewController: NavigationBarViewDelegate {
    func settingButtonTapped() {
        let profileSettingViewController = ProfileSettingViewController()
        navigationController?.pushViewController(profileSettingViewController, animated: true)
    }
}

extension ProfileViewController: HandleFriendCellDelegate {
    func presentModal() {
        let friendProfileViewController = FriendProfileViewController()
        let nav = UINavigationController(rootViewController: friendProfileViewController)
        
//        friendProfileViewController.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 370)
    
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        present(nav, animated: true, completion: nil)
    }
}