//
//  AppDelegate.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import UIKit

import FirebaseCore
import FirebaseMessaging
import KakaoSDKCommon
import KakaoSDKAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        KakaoSDK.initSDK(appKey: Config.kakaoAppKey)
        UNUserNotificationCenter.current().delegate = self
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        /// 디바이스 토큰 요청
        application.registerForRemoteNotifications()
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //사용자 인증에 필요한 함수 추가 (iOS 13 이하)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        }
        return false
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
        guard let type = userInfo["type"] as? String else { return }
        guard let path = userInfo["path"] as? String,
              let messageNumber = path.split(separator: "/").last else { return }
        NotificationCenter.default.post(name: Notification.Name("showMessage"), object: nil, userInfo: ["message":Int(messageNumber) ?? 0])
        
        if type == "VOTE_AVAILABLE" {
            NotificationCenter.default.post(name: Notification.Name("showPage"), object: nil, userInfo: ["index":2])
        } else if type == "NEW_VOTE" {
            NotificationCenter.default.post(name: Notification.Name("showPage"), object: nil, userInfo: ["index":3])
        } else if type == "NEW_FRIEND" {
            NotificationCenter.default.post(name: Notification.Name("showPage"), object: nil, userInfo: ["index":4])
        }
        
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FirebaseMessaging")
        let deviceToken:[String: String] = ["token": fcmToken ?? ""]
        User.shared.deviceToken = fcmToken ?? ""
        print("Device token:", deviceToken) // 이 토큰은 FCM에서 알림을 테스트하는 데 사용할 수 있습니다.
    }
}

