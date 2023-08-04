//
//  YELLOTabBarItem.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case recommending
    case around
    case voting
    case myYello
    case profile
}

extension TabBarItem {
    var title: String {
        switch self {
        case .recommending:   return StringLiterals.TabBar.ItemTitle.recommend
        case .around:         return StringLiterals.TabBar.ItemTitle.around
        case .voting:         return StringLiterals.TabBar.ItemTitle.home
        case .myYello:        return StringLiterals.TabBar.ItemTitle.myYello
        case .profile:        return StringLiterals.TabBar.ItemTitle.profile
        }
    }
}

extension TabBarItem {
    var Icon: UIImage? {
        switch self {
        case .recommending:  return ImageLiterals.TabBar.icPlusFriend
        case .around:        return ImageLiterals.TabBar.icFriendYello
        case .voting:        return ImageLiterals.TabBar.icHome
        case .myYello:       return ImageLiterals.TabBar.icMyYello
        case .profile:       return ImageLiterals.TabBar.icProfile
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .recommending:  return ImageLiterals.TabBar.icPlusFriendSelected.withRenderingMode(.alwaysOriginal)
        case .around:        return ImageLiterals.TabBar.icFriendYelloSelected.withRenderingMode(.alwaysOriginal)
        case .voting:        return ImageLiterals.TabBar.icHomeSelected.withRenderingMode(.alwaysOriginal)
        case .myYello:       return ImageLiterals.TabBar.icMyYelloSelected.withRenderingMode(.alwaysOriginal)
        case .profile:       return ImageLiterals.TabBar.icProfileSelected.withRenderingMode(.alwaysOriginal)
        }
    }
}

extension TabBarItem {
    public func asTabBarItem() -> UITabBarItem {
        let tabBarItem = UITabBarItem(
            title: title,
            image: Icon,
            selectedImage: selectedIcon
        )
        
        tabBarItem.imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0)
        
        return tabBarItem
    }
}
