//
//  UIWindow+.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/11.
//

import UIKit

extension UIWindow {
    
    public var visibleViewController: UIViewController? {
        return self.visibleViewControllerFrom(viewController: self.rootViewController)
    }
    
    public func visibleViewControllerFrom(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = viewController as? UINavigationController {
            return self.visibleViewControllerFrom(viewController: navigationController.visibleViewController)
        } else if let tabBarController = viewController as? UITabBarController {
            return self.visibleViewControllerFrom(viewController: tabBarController.selectedViewController)
        } else {
            if let presnetedViewController = viewController?.presentedViewController {
                return self.visibleViewControllerFrom(viewController: presnetedViewController)
            } else {
                return viewController
            }
        }
    }
}
