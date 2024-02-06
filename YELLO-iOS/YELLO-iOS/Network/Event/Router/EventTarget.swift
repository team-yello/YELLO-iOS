//
//  EventTarget.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2/6/24.
//

import Foundation

import Alamofire

enum EventTarget {
    case lunchEvent
}

extension EventTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .lunchEvent:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .lunchEvent:
            return .plain
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .lunchEvent:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .lunchEvent:
            return "/v1/event"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .lunchEvent:
            return .requestPlain
        }
    }
}
