//
//  BottomFriendProfileViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/20.
//

import UIKit

import SnapKit
import Then

final class BottomFriendProfileViewController: BaseBottomViewController {
    
    // MARK: - Variables
    // MARK: Component
    let friendProfileView = FriendProfileView()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.friendProfileView.layoutChange()
    }
    
    // MARK: Layout Helpers
    override func setViewHierarchy() {
        super.setViewHierarchy()
        friendProfileView.handleBottomSheetButtonDelegate = self
    }
    
    override func setLayout() {
        super.setLayout()
        super.bottomSheetView.addSubview(friendProfileView)
        
        friendProfileView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

// MARK: - extension
// MARK: HandleBottomSheetButtonDelegate
extension BottomFriendProfileViewController: HandleBottomSheetButtonDelegate {
    func dismissView() {
        self.dismiss(animated: true)
    }
}
