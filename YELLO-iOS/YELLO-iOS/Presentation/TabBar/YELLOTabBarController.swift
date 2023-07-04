//
//  TabBarViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//


import UIKit

import SnapKit
import Then

final class YELLOTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setTabBarControllers()
    }

}

extension YELLOTabBarController {
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    private func setStyle() {
        tabBar.do {
            $0.backgroundColor = UIColor(hex: "#212529")
            $0.backgroundColor = UIColor(hex: "#212529")
            $0.isTranslucent = false
            $0.barTintColor = .grayscales600
            $0.tintColor = UIColor(hex: "#FFFB05")
            $0.roundCorners(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        setUpTabBar()
    }
    
    private func setLayout() {
         func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            var tabFrame = self.tabBar.frame
            tabFrame.size.height = 60
            tabFrame.origin.y = self.view.frame.size.height - 60
            self.tabBar.frame = tabFrame
        }
        
    }

    private func setTabBarControllers() {
        var navigations: [UINavigationController] = []
        YELLOTabBarItem.allCases.forEach {
            let navigation = makeNavigationController(
                selectedImage: $0.selectedImage,
                unselectedImage: $0.unselectedImage,
                rootViewController: $0.viewController
            )
            navigation.tabBarItem.title = $0.name
            navigations.append(navigation)
        }

        setViewControllers(navigations, animated: false)
    }

    private func makeNavigationController(selectedImage: UIImage, unselectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {

        let navigationController = UINavigationController(rootViewController: rootViewController)

        let tabBarItem = UITabBarItem(
            title: nil,
            image: unselectedImage,
            selectedImage: selectedImage
        )

        navigationController.tabBarItem = tabBarItem
        navigationController.navigationBar.isHidden = true
        return navigationController
    }
    

}
