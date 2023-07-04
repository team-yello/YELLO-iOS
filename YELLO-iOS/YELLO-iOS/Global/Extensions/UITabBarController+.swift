//
//  UITabBarController+.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

extension UITabBarController {
    func setUpTabBar() {
        let appearance = UITabBar.appearance()
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = UIImage()
        appearance.clipsToBounds = true
    }

}
