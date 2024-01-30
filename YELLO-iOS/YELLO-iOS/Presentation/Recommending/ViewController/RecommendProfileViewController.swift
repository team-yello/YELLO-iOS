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
}

// MARK: - extension
// MARK: HandleBottomSheetButtonDelegate
extension RecommendProfileViewController: HandleBottomSheetButtonDelegate {
    func dismissView() {
        self.dismiss(animated: true)
    }
}
