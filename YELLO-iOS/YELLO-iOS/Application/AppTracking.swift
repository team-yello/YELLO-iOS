//
//  AppTracking.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2/18/24.
//

import AdSupport
import AppTrackingTransparency
import Foundation

final class AppTracking  {
    static var idfa: UUID {
        return ASIdentifierManager.shared().advertisingIdentifier
    }
    
    static func requestTrackingAuthorization() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { (status) in
                    switch status {
                    case .notDetermined:
                        print("notDetermined") // 결정되지 않음
                    case .restricted:
                        print("restricted") // 제한됨
                    case .denied:
                        print("denied") // 거부됨
                    case .authorized:
                        print("authorized") // 허용됨
                    @unknown default:
                        print("error") // 알려지지 않음
                    }
                }
            }
        }
    }
}
