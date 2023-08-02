//
//  FriendSearchView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/02.
//

import UIKit

import SnapKit
import Then

final class FriendSearchView: BaseView {
    
    let friendSearchNavigationBarView = SettingNavigationBarView()
    
    override func setStyle() {
        friendSearchNavigationBarView.do {
            $0.titleLabel.setTextWithLineHeight(text: StringLiterals.Recommending.Search.title, lineHeight: 24)
        }
    }
    
    override func setLayout() {
        
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        self.addSubviews(friendSearchNavigationBarView)
        
        friendSearchNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48)
        }
    }
}
