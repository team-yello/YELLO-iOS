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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
    
    private func setUI() {
        setStyle()
        setTabBarControllers()
    }
    
    private func setStyle() {
        view.backgroundColor = .white
        
        // 탭 바 아이템들을 순회하면서 개별적으로 폰트를 설정
        for item in tabBar.items ?? [] {
            // 일반 상태의 폰트 설정
            let normalAttributes = [NSAttributedString.Key.font: UIFont.uiCaption03]
            item.setTitleTextAttributes(normalAttributes, for: .normal)
            
            // 선택된 상태의 폰트 설정
            let selectedAttributes = [NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 10.0)!]
            item.setTitleTextAttributes(selectedAttributes, for: .selected)
        }
        
        tabBar.do {
            $0.isTranslucent = false
            $0.backgroundColor = UIColor(hex: "#212529")
            $0.tintColor = UIColor(hex: "#FFFB05")
            $0.barTintColor = .grayscales600
            $0.roundCorners(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        
    }
    
    private func setTabBarControllers() {
        
        // MARK: - firstViewController
        
        let firstViewController = UINavigationController(rootViewController: RecommendingViewController())
        firstViewController.tabBarItem = UITabBarItem(title: StringLiterals.TabBar.ItemTitle.recommending, image: ImageLiterals.TabBar.icPlusFriend, selectedImage: ImageLiterals.TabBar.icPlusFriendSelected.withRenderingMode(.alwaysOriginal))
        
        // MARK: - secondViewController
        
        let secondViewController = UINavigationController(rootViewController: AroundViewController())
        secondViewController.tabBarItem = UITabBarItem(title: StringLiterals.TabBar.ItemTitle.around, image: ImageLiterals.TabBar.icFriendYello, selectedImage: ImageLiterals.TabBar.icFriendYelloSelected.withRenderingMode(.alwaysOriginal))
        
        // MARK: - ThirdViewController
        
        let thirdViewController = UINavigationController(rootViewController: VotingViewController())
        thirdViewController.tabBarItem = UITabBarItem(title: StringLiterals.TabBar.ItemTitle.home, image: ImageLiterals.TabBar.icHome, selectedImage: ImageLiterals.TabBar.icHomeSelected.withRenderingMode(.alwaysOriginal))
        
        // MARK: - FourthViewController
        
        let fourthViewController = UINavigationController(rootViewController: MyYelloViewController())
        fourthViewController.tabBarItem = UITabBarItem(title: StringLiterals.TabBar.ItemTitle.myYello, image: ImageLiterals.TabBar.icMyYello, selectedImage: ImageLiterals.TabBar.icMyYelloSelected.withRenderingMode(.alwaysOriginal))
        
        // MARK: - FifthViewController
        
        let fifthViewController = UINavigationController(rootViewController: ProfileViewController())
        fifthViewController.tabBarItem = UITabBarItem(title: StringLiterals.TabBar.ItemTitle.profile, image: ImageLiterals.TabBar.icProfile, selectedImage: ImageLiterals.TabBar.icProfileSelected.withRenderingMode(.alwaysOriginal))
        
        self.viewControllers = [firstViewController,
                                secondViewController,
                                thirdViewController,
                                fourthViewController,
                                fifthViewController]
    }
    
    
    // MARK: - TabBar height 조절
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 60
        tabFrame.origin.y = self.view.frame.size.height - 60
        self.tabBar.frame = tabFrame
    }
    
}

