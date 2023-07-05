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
        
        self.delegate = self
        
        // 탭 바 아이템의 글씨를 조금 띄우기 위해 titlePositionAdjustment를 설정
        let offset = UIOffset(horizontal: 0, vertical: -2) // 수직 방향으로 -3만큼 이동
        tabBar.items?.forEach { item in
            item.titlePositionAdjustment = offset
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight: CGFloat = 60.0
        tabBar.frame.size.height = tabBarHeight + safeAreaHeight
        tabBar.frame.origin.y = view.frame.height - tabBarHeight - safeAreaHeight
    }
    
    
    private func setTabBarAppearance() {
        
        view.backgroundColor = .white
        
        tabBar.backgroundColor = .grayscales900
        tabBar.tintColor = .yelloMain500
        tabBar.barTintColor = .grayscales600
        tabBar.roundCorners(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont.uiCaption04]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        
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


extension YELLOTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if let selectedViewController = tabBarController.selectedViewController {
            let selectedFontAttributes = [NSAttributedString.Key.font: UIFont.uiCaption04]
            selectedViewController.tabBarItem.setTitleTextAttributes(selectedFontAttributes, for: .normal)
        }
        
        for (index, controller) in tabBarController.viewControllers!.enumerated() {
            if let tabBarItem = controller.tabBarItem {
                if index != tabBarController.selectedIndex {
                    let defaultFontAttributes = [NSAttributedString.Key.font: UIFont.uiCaption03]
                    tabBarItem.setTitleTextAttributes(defaultFontAttributes, for: .normal)
                }
            }
        }
    }
}
