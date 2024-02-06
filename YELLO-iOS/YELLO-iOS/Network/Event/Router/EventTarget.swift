//
//  EventTarget.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2/6/24.
//

import Foundation

import Alamofire

enum EventTarget {
    case lunchEventCheck
    case lunchEventStart(_ requestDTO: EventRequestDTO)
    case eventReward
}

extension EventTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .lunchEventCheck:
            return .authorization
        case .lunchEventStart(_):
            return .authorization
        case .eventReward:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .lunchEventCheck:
            return .plain
        case .lunchEventStart(_):
            return .idempotencyKey
        case .eventReward:
            return .plain
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .lunchEventCheck:
            return .get
        case .lunchEventStart(_):
            return .post
        case .eventReward:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .lunchEventCheck:
            return "/v1/event"
        case .lunchEventStart(_):
            return "/v1/event"
        case .eventReward:
            return "/v1/event/reward"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .lunchEventCheck:
            return .requestPlain
        case let .lunchEventStart(requestDTO):
            return .requestWithBody(requestDTO)
        case .eventReward:
            return .requestPlain
        }
    }
}
