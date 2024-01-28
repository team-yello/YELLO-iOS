//
//  UserNotificationTarget.swift
//  YELLO-iOS
//
//  Created by 변희주 on 1/28/24.
//

import Foundation

import Alamofire

enum NotificationTarget {
    case userNotification
}

extension NotificationTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .userNotification:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .userNotification:
            return .plain
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .userNotification:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .userNotification:
            return "/notice"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .userNotification:
            return .requestPlain
        }
    }
}
