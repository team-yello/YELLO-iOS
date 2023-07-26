//
//  SceneDelegate.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import UIKit

import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let isLoggined = UserDefaults.standard.bool(forKey: "isLoggined")
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let splashViewController = SplashViewController()
        window?.rootViewController = splashViewController
        
        self.window?.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.3) {
            
            let className = UserDefaults.standard.string(forKey: "lastViewController")
            let viewControllerCreators = [
                "VotingViewController": { VotingViewController(nibName: nil, bundle: nil) },
                // Add more view controller creators here...
            ]
            
            if let className = className,
               let creator = viewControllerCreators[className] {
                let rootViewController = creator()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                navigationController.navigationBar.isHidden = true
                self.window?.rootViewController = navigationController
            } else {
                // Fallback to a default view controller if the last one was not found or could not be restored
                let rootViewController = self.isLoggined ? YELLOTabBarController() : KakaoLoginViewController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                navigationController.navigationBar.isHidden = true
                self.window?.rootViewController = navigationController
            }
            
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    /// 카카오 로그인
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene else { return }
        guard let topViewController = topViewController(controller: windowScene.windows.first?.rootViewController) else { return }
        
        // Save the class name of topViewController to UserDefaults
        let className = "\(String(describing: type(of: topViewController)))"
        UserDefaults.standard.set(className, forKey: "lastViewController")
        VotingViewController.pushCount = VotingViewController.pushCount - 1
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let navigationController = controller as? UINavigationController {
        return topViewController(controller: navigationController.visibleViewController)
    }
    if let tabController = controller as? UITabBarController {
        if let selected = tabController.selectedViewController {
            return topViewController(controller: selected)
        }
    }
    if let presented = controller?.presentedViewController {
        return topViewController(controller: presented)
    }
    return controller
}
