//
//  TabBarViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

import SnapKit
import Then

// MARK: - TabBar

final class YELLOTabBarController: UITabBarController {
    
    private var tabs: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setTabBarAppearance()
        setTabBarItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.frame.size.height = 60.adjusted
        tabBar.frame.origin.y = view.frame.height - 60.adjusted
    }
    
    private func setTabBarAppearance() {
        
        view.backgroundColor = .white
        
        UITabBar.appearance().backgroundColor = .grayscales900
        UITabBar.appearance().tintColor = .yelloMain500
        UITabBar.appearance().unselectedItemTintColor = .grayscales600
        tabBar.roundCorners(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont.uiCaption03]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        
        let selectedFontAttributes = [NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 10.0)!]
        UITabBarItem.appearance().setTitleTextAttributes(selectedFontAttributes, for: .selected)
    }
    
    private func setTabBarItems() {
        tabs = [
            UINavigationController(rootViewController: RecommendingViewController()),
            UINavigationController(rootViewController: AroundViewController()),
            UINavigationController(rootViewController: VotingViewController()),
            UINavigationController(rootViewController: MyYelloViewController()),
            UINavigationController(rootViewController: ProfileViewController())
        ]
        
        TabBarItem.allCases.forEach {
            tabs[$0.rawValue].tabBarItem = $0.asTabBarItem()
            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
        }
        
        setViewControllers(tabs, animated: true)
    }
}

