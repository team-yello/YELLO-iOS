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
                    self.checkAndUpdateIfNeeded()
                } else {
                    if self.isLoggined {
                        let yelloTabBarController = YELLOTabBarController()
                        let navigationController = UINavigationController(rootViewController: yelloTabBarController)
                        navigationController.navigationBar.isHidden = true
                        self.window?.rootViewController = navigationController
                        self.window?.makeKeyAndVisible()
                        self.checkAndUpdateIfNeeded()
                    } else {
                        let kakaologinViewController = KakaoLoginViewController()
                        let navigationController = UINavigationController(rootViewController: kakaologinViewController)
                        navigationController.navigationBar.isHidden = true
                        self.window?.rootViewController = navigationController
                        self.window?.makeKeyAndVisible()
                        self.checkAndUpdateIfNeeded()
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
                    self.checkAndUpdateIfNeeded()
                } else if type == StringLiterals.PushAlarm.TypeName.newFriend {
                    selectedIndex = 4
                    rootViewController.selectedIndex = selectedIndex
                    self.window?.rootViewController = navigationController
                    self.window?.makeKeyAndVisible()
                    self.checkAndUpdateIfNeeded()
                }
                return
            }
            
            let rootViewController = YELLOTabBarController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
            self.checkAndUpdateIfNeeded()
            
            if type == StringLiterals.PushAlarm.TypeName.newVote {
                selectedIndex = 3
                rootViewController.selectedIndex = selectedIndex
                let myYelloDetailViewController = MyYelloDetailViewController()
                NetworkService.shared.myYelloService.myYelloDetail(voteId: Int(messageNumber) ?? 0) { response in
                    switch response {
                    case .success(let data):
                        guard let data = data.data else { return }

                        myYelloDetailViewController.myYelloDetailView.voteIdNumber = Int(messageNumber) ?? 0
                        myYelloDetailViewController.colorIndex = data.colorIndex
                        myYelloDetailViewController.myYelloDetailView.currentPoint = data.currentPoint
                        myYelloDetailViewController.myYelloDetailView.detailSenderView.isHidden = false
                        myYelloDetailViewController.myYelloDetailView.detailKeywordView.isHidden = false
                        myYelloDetailViewController.myYelloDetailView.genderLabel.isHidden = false
                        myYelloDetailViewController.myYelloDetailView.instagramButton.isHidden = false
                        myYelloDetailViewController.myYelloDetailView.keywordButton.isHidden = false
                        myYelloDetailViewController.myYelloDetailView.senderButton.isHidden = false
                        myYelloDetailViewController.setBackgroundView()
                        
                        if data.senderGender == "MALE" {
                            myYelloDetailViewController.myYelloDetailView.genderLabel.text = StringLiterals.MyYello.Detail.male
                        } else {
                            myYelloDetailViewController.myYelloDetailView.genderLabel.text = StringLiterals.MyYello.Detail.female
                        }
                        
                        if data.vote.nameHead == nil {
                            myYelloDetailViewController.myYelloDetailView.detailKeywordView.nameKeywordLabel.text = "너" + (data.vote.nameFoot ?? "")
                        } else {
                            myYelloDetailViewController.myYelloDetailView.detailKeywordView.nameKeywordLabel.text = (data.vote.nameHead ?? "") + " 너" + (data.vote.nameFoot ?? "")
                        }
                        
                        myYelloDetailViewController.myYelloDetailView.detailKeywordView.keywordHeadLabel.text = (data.vote.keywordHead ?? "")
                        myYelloDetailViewController.myYelloDetailView.detailKeywordView.keywordLabel.text = data.vote.keyword
                        myYelloDetailViewController.myYelloDetailView.detailKeywordView.keywordFootLabel.text = (data.vote.keywordFoot ?? "")
                        
                        myYelloDetailViewController.myYelloDetailView.isKeywordUsed = data.isAnswerRevealed
                        
                        if data.nameHint == 0 {
                            myYelloDetailViewController.myYelloDetailView.isSenderUsed = true
                            if let initial = myYelloDetailViewController.getFirstInitial(data.senderName as NSString, index: 0) {
                                myYelloDetailViewController.myYelloDetailView.detailSenderView.senderLabel.text = initial
                            }
                        } else if data.nameHint == 1 {
                            myYelloDetailViewController.myYelloDetailView.isSenderUsed = true
                            if let initial = myYelloDetailViewController.getSecondInitial(data.senderName as NSString, index: 1) {
                                myYelloDetailViewController.myYelloDetailView.detailSenderView.senderLabel.text = initial
                            }
                        } else if data.nameHint == -3 {
                            myYelloDetailViewController.myYelloDetailView.isSenderUsed = true
                            myYelloDetailViewController.myYelloDetailView.detailSenderView.senderLabel.text = data.senderName
                            myYelloDetailViewController.myYelloDetailView.isKeywordUsed = true
                            myYelloDetailViewController.myYelloDetailView.senderButton.setButtonState(state: .noTicket)
                            myYelloDetailViewController.myYelloDetailView.keywordButton.isHidden = true
                            myYelloDetailViewController.myYelloDetailView.haveTicket = false
                            myYelloDetailViewController.myYelloDetailView.senderButton.snp.makeConstraints {
                                $0.top.equalTo(myYelloDetailViewController.myYelloDetailView.instagramButton.snp.bottom).offset(77.adjustedHeight)
                            }
                        }
                        if data.isSubscribe {
                            myYelloDetailViewController.myYelloDetailView.isPlus = true
                        }
                        myYelloDetailViewController.myYelloDetailView.ticketCount = data.ticketCount
                        
                        navigationController.pushViewController(myYelloDetailViewController, animated: true)
                    default:
                        print("network fail")
                        return
                    }
                }
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
        Amplitude.instance().logEvent("view_vote_question", withEventProperties: ["vote_step":VotingViewController.pushCount])
        
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
        checkAndUpdateIfNeeded()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene else { return }
        guard let topViewController = topViewController(controller: windowScene.windows.first?.rootViewController) else { return }
        Amplitude.instance().logEvent("view_vote_question", withEventProperties: ["vote_step":VotingViewController.pushCount])
        
        // Save the class name of topViewController to UserDefaults
        let className = "\(String(describing: type(of: topViewController)))"
        UserDefaults.standard.set(className, forKey: "lastViewController")
    }
    
    func checkAndUpdateIfNeeded() {
        let marketingVersion = AppStoreCheck().latestVersion() ?? ""
        let currentProjectVersion = AppStoreCheck.appVersion ?? ""
        let splitMarketingVersion = marketingVersion.split(separator: ".").map { $0 }
        let splitCurrentProjectVersion = currentProjectVersion.split(separator: ".").map { $0 }
        
        if splitCurrentProjectVersion[0] < splitMarketingVersion[0] {
            showUpdateAlert(version: marketingVersion)
        } else if splitCurrentProjectVersion[1] < splitMarketingVersion[1] {
            showUpdateAlert(version: marketingVersion)
        } else {
            print(marketingVersion)
            print(currentProjectVersion)
            print(splitMarketingVersion)
            print(splitCurrentProjectVersion)
            print("현재 최신 버젼입니다.")
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

