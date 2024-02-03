//
//  RecommendProfileViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 1/23/24.
//

import UIKit

import SnapKit
import Then

final class RecommendProfileViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    let recommendFriendProfileView = RecommendFriendProfileView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.resetProfile()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.recommendFriendProfileView.layoutChange()
    }
    
    // MARK: Layout Helpers
    override func setStyle() {
        view.backgroundColor = .black
        recommendFriendProfileView.handleBottomSheetButtonDelegate = self
    }
    
    override func setLayout() {
        view.addSubview(recommendFriendProfileView)
        
        recommendFriendProfileView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func resetProfile() {
        recommendFriendProfileView.profileImageView.image = nil
        recommendFriendProfileView.nameLabel.text = nil
        recommendFriendProfileView.instagramLabel.text = nil
        recommendFriendProfileView.schoolLabel.text = nil
        recommendFriendProfileView.messageCountView.countLabel.text = nil
        recommendFriendProfileView.friendCountView.countLabel.text = nil
    }
}

// MARK: - extension
// MARK: HandleBottomSheetButtonDelegate
extension RecommendProfileViewController: HandleBottomSheetButtonDelegate {
    func dismissView() {
        self.dismiss(animated: true)
    }
}
