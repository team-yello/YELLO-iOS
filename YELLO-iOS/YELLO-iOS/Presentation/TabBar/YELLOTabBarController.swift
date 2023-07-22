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
    
    private var startStatus: Int = 18
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVotingAvailable()
        setTabBarItems()
        setTabBarAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.selectedIndex = 2
        self.delegate = self
        self.navigationController?.navigationBar.isHidden = true
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
        var rootViewController: UIViewController
        /// 친구 수에 따라 rootViewController가 달라짐
        if startStatus == 1 {
            rootViewController = VotingStartViewController()
        } else if startStatus == 2 {
            rootViewController = VotingTimerViewController()
        } else {
            rootViewController = VotingLockedViewController()
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
        
        guard let selectedViewController = tabBarController.selectedViewController else {
            return true
        }
        
        if selectedViewController == viewController && tabBarController.selectedIndex == 2 {
            // 현재 선택된 뷰 컨트롤러와 선택될 뷰 컨트롤러가 다르고, 3번째 탭이 선택된 경우
            return false
        }
        
        return true
    }
}

extension YELLOTabBarController {
    func getVotingAvailable() {
        NetworkService.shared.votingService.getVotingAvailable {
            result in
            switch result {
            case .success(let data):
                let status = data.status
                guard let data = data.data else { return }
                if status == 200 {
                    if data.isPossible {
                        self.startStatus = 1
                    } else {
                        self.startStatus = 2
                    }
                } else {
                    self.startStatus = 3
                }
                
                self.setTabBarAppearance()
                self.setTabBarItems()
            default:
                print("network failure")
                return
            }
        }
    }
}
