//
//  YELLOTabBarItem.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

enum YELLOTabBarItem: String, CaseIterable {
    case Recommending
    case Around
    case Voting
    case MyYello
    case Profile

    var unselectedImage: UIImage {
        switch self {
        case .Recommending: return ImageLiterals.TabBar.icPlusFriend
        case .Around: return ImageLiterals.TabBar.icFriendYello
        case .Voting: return ImageLiterals.TabBar.icHome
        case .MyYello: return ImageLiterals.TabBar.icMyYello
        case .Profile: return ImageLiterals.TabBar.icProfile
        }
    }

    var selectedImage: UIImage {
        switch self {
        case .Recommending: return ImageLiterals.TabBar.icPlusFriendSelected.withRenderingMode(.alwaysOriginal)
        case .Around: return ImageLiterals.TabBar.icFriendYelloSelected.withRenderingMode(.alwaysOriginal)
        case .Voting: return ImageLiterals.TabBar.icHomeSelected.withRenderingMode(.alwaysOriginal)
        case .MyYello: return ImageLiterals.TabBar.icMyYelloSelected.withRenderingMode(.alwaysOriginal)
        case .Profile: return ImageLiterals.TabBar.icProfileSelected.withRenderingMode(.alwaysOriginal)
        }
    }

    var name: String {
        switch self {
        case .Recommending: return StringLiterals.TabBar.ItemTitle.recommending
        case .Around: return StringLiterals.TabBar.ItemTitle.around
        case .Voting: return StringLiterals.TabBar.ItemTitle.home
        case .MyYello: return StringLiterals.TabBar.ItemTitle.myYello
        case .Profile: return StringLiterals.TabBar.ItemTitle.profile
        }
    }


}
