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
    
    private var startStatus: Int = 1
    
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
    
    // MARK: - TabBar Style
    
    private func setTabBarAppearance() {
        
        /// 탭 바 아이템의 글씨를 조금 띄우기 위해 titlePositionAdjustment를 설정
        let offset = UIOffset(horizontal: 0, vertical: -7) /// 수직 방향으로 -7만큼
        tabBar.items?.forEach { item in
            item.titlePositionAdjustment = offset
        }
        
        tabBar.items?[2].imageInsets = UIEdgeInsets(top: -23, left: 0, bottom: 0, right: 0)
        view.backgroundColor = .clear
        
        tabBar.tintColor = .yelloMain500
        tabBar.barTintColor = .grayscales600
        tabBar.roundCorners(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        // 탭바만 폰트 기기대응X
        let myFont = UIFont(name: "Pretendard-Bold", size: 10.0)!
        let fontAttributes = [NSAttributedString.Key.font: myFont]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
                        
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: UIColor(hex: "668099"), alpha: 0.15, x: 0, y: -2, blur: 5)
    }
}

// MARK: - TabBar Custom Font

extension YELLOTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if let selectedViewController = tabBarController.selectedViewController {
            let myFont = UIFont(name: "Pretendard-Bold", size: 10.0)!
            let selectedFontAttributes = [NSAttributedString.Key.font: myFont]
            selectedViewController.tabBarItem.setTitleTextAttributes(selectedFontAttributes, for: .normal)
        }
        
        for (index, controller) in tabBarController.viewControllers!.enumerated() {
            if let tabBarItem = controller.tabBarItem {
                if index != tabBarController.selectedIndex {
                    let myFont = UIFont(name: "Pretendard-Medium", size: 10.0)!
                    let defaultFontAttributes = [NSAttributedString.Key.font: myFont]
                    tabBarItem.setTitleTextAttributes(defaultFontAttributes, for: .normal)
                }
            }
        }
        
        let selectedIndex = tabBarController.selectedIndex
        switch selectedIndex {
        case 0, 1, 3, 4:
            tabBar.items?[2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            tabBar.items?[2].imageInsets = UIEdgeInsets(top: -23, left: 0, bottom: 0, right: 0)
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
                self.setTabBarItems()
                self.setTabBarAppearance()
                self.myYelloCount()
            default:
                print("network failure")
                return
            }
        }
    }
    
    func myYelloCount() {
        let queryDTO = MyYelloRequestQueryDTO(page: 0)
        NetworkService.shared.myYelloService.myYello(queryDTO: queryDTO) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                if data.totalCount > 99 {
                    self.tabBar.items?[3].badgeValue = "99+"
                } else {
                    self.tabBar.items?[3].badgeValue = String(data.totalCount)
                }
            default:
                print("network fail")
                return
            }
        }
    }
}
