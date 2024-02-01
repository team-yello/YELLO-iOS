//
//  SceneDelegate.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import UIKit

import Amplitude
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
        self.checkAndUpdateIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.3) {
            guard let notificationResponse = connectionOptions.notificationResponse else {
                let className = UserDefaults.standard.string(forKey: "lastViewController")
                let viewControllerCreators = [
                    "VotingViewController": { VotingViewController(nibName: nil, bundle: nil) },
                    "VotingPointViewController": { VotingPointViewController(nibName: nil, bundle: nil) },
                    // Add more view controller creators here...
                ]
                
                if let className = className,
                   let creator = viewControllerCreators[className] {
                    let rootViewController = creator()
                    let navigationController = UINavigationController(rootViewController: rootViewController)
                    navigationController.navigationBar.isHidden = true
                    self.window?.rootViewController = navigationController
                    self.window?.makeKeyAndVisible()
                    if NetworkCheck.shared.isConnected {
                        self.checkAndUpdateIfNeeded()
                    }
                } else {
                    if self.isLoggined {
                        let yelloTabBarController = YELLOTabBarController()
                        let status = UserDefaults.standard.integer(forKey: "status")
                        yelloTabBarController.startStatus = status
                        let navigationController = UINavigationController(rootViewController: yelloTabBarController)
                        navigationController.navigationBar.isHidden = true
                        self.window?.rootViewController = navigationController
                        self.window?.makeKeyAndVisible()
                        if NetworkCheck.shared.isConnected {
                            self.checkAndUpdateIfNeeded()
                        }
                    } else {
                        let kakaologinViewController = KakaoLoginViewController()
                        let navigationController = UINavigationController(rootViewController: kakaologinViewController)
                        navigationController.navigationBar.isHidden = true
                        self.window?.rootViewController = navigationController
                        self.window?.makeKeyAndVisible()
                        if NetworkCheck.shared.isConnected {
                            self.checkAndUpdateIfNeeded()
                        }
                    }
                }
                return
            }
            
            var selectedIndex = 0
            let userInfo = notificationResponse.notification.request.content.userInfo
            guard let type = userInfo["type"] as? String else { return }
            guard let path = userInfo["path"] as? String,
                  let messageNumber = path.split(separator: "/").last else {
                let rootViewController = YELLOTabBarController()
                let navigationController = UINavigationController(rootViewController: rootViewController)
                if type == StringLiterals.PushAlarm.TypeName.available || type == StringLiterals.PushAlarm.TypeName.recommend {
                    selectedIndex = 2
                    rootViewController.selectedIndex = selectedIndex
                    self.window?.rootViewController = navigationController
                    self.window?.makeKeyAndVisible()
                    if NetworkCheck.shared.isConnected {
                        self.checkAndUpdateIfNeeded()
                    }
                } else if type == StringLiterals.PushAlarm.TypeName.newFriend {
                    selectedIndex = 4
                    rootViewController.selectedIndex = selectedIndex
                    self.window?.rootViewController = navigationController
                    self.window?.makeKeyAndVisible()
                    if NetworkCheck.shared.isConnected {
                        self.checkAndUpdateIfNeeded()
                    }
                }
                return
            }
            
            let rootViewController = YELLOTabBarController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
            if NetworkCheck.shared.isConnected {
                self.checkAndUpdateIfNeeded()
            }
            if type == StringLiterals.PushAlarm.TypeName.newVote {
                selectedIndex = 3
                rootViewController.selectedIndex = selectedIndex
                let myYelloDetailViewController = MyYelloDetailViewController()
                myYelloDetailViewController.myYelloDetail(voteId:  Int(messageNumber) ?? 0)
                navigationController.pushViewController(myYelloDetailViewController, animated: true)
            }
        }
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
        if NetworkCheck.shared.isConnected {
            self.checkAndUpdateIfNeeded()
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene else { return }
        guard let topViewController = topViewController(controller: windowScene.windows.first?.rootViewController) else { return }
        
        // Save the class name of topViewController to UserDefaults
        let className = "\(String(describing: type(of: topViewController)))"
        UserDefaults.standard.set(className, forKey: "lastViewController")
    }
    func checkAndUpdateIfNeeded() {
        AppStoreCheck().latestVersion { marketingVersion in
            DispatchQueue.main.async {
                guard let marketingVersion = marketingVersion else {
                    print("앱스토어 버전을 찾지 못했습니다.")
                    return
                }
                let currentProjectVersion = AppStoreCheck.appVersion ?? ""
                let splitMarketingVersion = marketingVersion.split(separator: ".").compactMap { Int($0) }
                let splitCurrentProjectVersion = currentProjectVersion.split(separator: ".").compactMap { Int($0) }
                

                print(marketingVersion)
                print(currentProjectVersion)
                print(splitMarketingVersion)
                print(splitCurrentProjectVersion)
                
                if splitCurrentProjectVersion.count > 0 && splitMarketingVersion.count > 0 {
                    if splitCurrentProjectVersion[0] < splitMarketingVersion[0] {
                        self.showUpdateAlert(version: marketingVersion)
                    } else if splitCurrentProjectVersion[1] < splitMarketingVersion[1] {
                        self.showUpdateAlert(version: marketingVersion)
                    } else {
//                        print(marketingVersion)
//                        print(currentProjectVersion)
//                        print(splitMarketingVersion)
//                        print(splitCurrentProjectVersion)
                        print("현재 최신 버전입니다.")
                    }
                }
            }
        }
    }
    
    func showUpdateAlert(version: String) {
        let alert = UIAlertController(
            title: "업데이트 알림",
            message: "더 나은 서비스를 위해 옐로가 수정되었어요! 업데이트해주시겠어요?",
            preferredStyle: .alert
        )
        
        let updateAction = UIAlertAction(title: "업데이트", style: .default) { _ in
            AppStoreCheck().openAppStore()
        }
        
        alert.addAction(updateAction)
        window?.rootViewController?.present(alert, animated: true, completion: nil)
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

