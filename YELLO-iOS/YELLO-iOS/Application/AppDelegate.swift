//
//  AppDelegate.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import UIKit

import Amplitude
import Firebase
import FirebaseCore
import FirebaseMessaging
import GoogleMobileAds
import KakaoSDKCommon
import KakaoSDKAuth


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetworkCheck.shared.startMonitoring()
        KakaoSDK.initSDK(appKey: Config.kakaoAppKey)
        UNUserNotificationCenter.current().delegate = self
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        /// 디바이스 토큰 요청
        application.registerForRemoteNotifications()
        
        /// Amplitude 설정
        Amplitude.instance().defaultTracking.sessions = true
        Amplitude.instance().defaultTracking.screenViews = true
        Amplitude.instance().defaultTracking = AMPDefaultTrackingOptions.initWithAllEnabled()
        Amplitude.instance().initializeApiKey(Config.amplitude)
        
        /// 접속 시간 전송
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let formattedDate = dateFormatter.string(from: currentDate)
        
        Amplitude.instance().setUserProperties(["user_last_use_date":formattedDate])
        
        let identify = AMPIdentify()
            .setOnce("user_invite", value: NSNumber(value: 0))
            .setOnce("user_instagram", value: NSNumber(value: 0))
            .setOnce("user_message_open", value: NSNumber(value: 0))
            .setOnce("user_vote_skip", value: NSNumber(value: 0))
            .setOnce("user_subscriptionbuy_count", value: NSNumber(value: 0))
            .setOnce("user_singlebuy_count", value: NSNumber(value: 0))
            .setOnce("user_revenue", value: NSNumber(value: 0))
        guard let identify = identify else { return true }
        Amplitude.instance().identify(identify)
        
        /// Mobile Ads SDK
        AppTracking.requestTrackingAuthorization()
        let ads = GADMobileAds.sharedInstance()
        ads.start { status in
            // Optional: Log each adapter's initialization latency.
            let adapterStatuses = status.adapterStatusesByClassName
            for adapter in adapterStatuses {
                let adapterStatus = adapter.value
                NSLog("Adapter Name: %@, Description: %@, Latency: %f", adapter.key,
                      adapterStatus.description, adapterStatus.latency)
                print("\(adapterStatus.description)")
            }
        }
        
        
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
              let messageNumber = path.split(separator: "/").last else {
            if type == StringLiterals.PushAlarm.TypeName.available || type == StringLiterals.PushAlarm.TypeName.recommend 
                || type == StringLiterals.PushAlarm.TypeName.lunchEvent {
                NotificationCenter.default.post(name: Notification.Name("showPage"), object: nil, userInfo: ["index":2]) // 40분 초기화, 추천인 포인트, 점심시간 이벤트
            } else if type == StringLiterals.PushAlarm.TypeName.newFriend {
                NotificationCenter.default.post(name: Notification.Name("showPage"), object: nil, userInfo: ["index":4]) // 새친구
            } else if type == StringLiterals.PushAlarm.TypeName.firstRecommend {
                NotificationCenter.default.post(name: Notification.Name("showPage"), object: nil, userInfo: ["index":5]) // 추천인 열람권
            } else if type == StringLiterals.PushAlarm.TypeName.openVote {
                NotificationCenter.default.post(name: Notification.Name("showPage"), object: nil, userInfo: ["index":1]) // 내가 보낸 쪽지 열람
            }
            return
        }
        
        NotificationCenter.default.post(name: Notification.Name("showMessage"), object: nil, userInfo: ["message":Int(messageNumber) ?? 0])

        if type == StringLiterals.PushAlarm.TypeName.newVote {
            NotificationCenter.default.post(name: Notification.Name("showPage"), object: nil, userInfo: ["index":3])
        }
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FirebaseMessaging")
        guard let fcmToken = fcmToken else { return }
        let deviceToken:[String: String] = ["token": fcmToken]
        UserManager.shared.deviceToken = fcmToken
        print("Device token:", deviceToken)
    }
}
