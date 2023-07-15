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
    
    private let timerView = VotingTimerView()
    
    private let numOfFriends = 4 /// 친구 수 임의로 지정 (서버 통신으로 받아와야 함)
    private var rootViewController = UIViewController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarAppearance()
        setTabBarItems()
        
        self.delegate = self
        self.selectedIndex = 2
    }
    
    // MARK: - TabBar Height
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight: CGFloat = 60.0
        tabBar.frame.size.height = tabBarHeight + safeAreaHeight
        tabBar.frame.origin.y = view.frame.height - tabBarHeight - safeAreaHeight
    }
    
    // MARK: - TabBar Style
    
    private func setTabBarAppearance() {
        
        /// 탭 바 아이템의 글씨를 조금 띄우기 위해 titlePositionAdjustment를 설정
        let offset = UIOffset(horizontal: 0, vertical: -2) /// 수직 방향으로 -2만큼
        tabBar.items?.forEach { item in
            item.titlePositionAdjustment = offset
        }
        
        view.backgroundColor = .black
        
        tabBar.tintColor = .yelloMain500
        tabBar.barTintColor = .grayscales600
        tabBar.roundCorners(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont.uiLabelBoldSmall]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
                        
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: UIColor(hex: "668099"), alpha: 0.15, x: 0, y: -2, blur: 5)
    }
    
    // MARK: - TabBar Item
    
    private func setTabBarItems() {
        
        /// 친구 수에 따라 rootViewController가 달라짐
        if numOfFriends < 4 {
            rootViewController = VotingLockedViewController()
        } else {
            rootViewController = VotingStartViewController()
        }
        
        tabs = [
            UINavigationController(rootViewController: RecommendingViewController()),
            UINavigationController(rootViewController: AroundViewController()),
            UINavigationController(rootViewController: rootViewController),
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

// MARK: - TabBar Custom Font

extension YELLOTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if let selectedViewController = tabBarController.selectedViewController {
            let selectedFontAttributes = [NSAttributedString.Key.font: UIFont.uiLabelBoldSmall]
            selectedViewController.tabBarItem.setTitleTextAttributes(selectedFontAttributes, for: .normal)
        }
        
        for (index, controller) in tabBarController.viewControllers!.enumerated() {
            if let tabBarItem = controller.tabBarItem {
                if index != tabBarController.selectedIndex {
                    let defaultFontAttributes = [NSAttributedString.Key.font: UIFont.uiLabelSmall]
                    tabBarItem.setTitleTextAttributes(defaultFontAttributes, for: .normal)
                }
            }
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            // 현재 선택된 탭 인덱스를 확인
            guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
                return true
            }
        
            // 원하는 조건에 따라 화면 전환을 막거나 허용
            if selectedIndex == 2 {
                return false
            }

            // 나머지 탭은 기본 동작인 화면 전환을 허용합니다.
            return true
        }
}
