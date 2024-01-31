//
//  AroundTarget.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/14.
//

import Foundation

import Alamofire

enum AroundTarget {
    case around(_ queryDTO: AroundRequestQueryDTO)
}

extension AroundTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .around:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .around:
            return .plain
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .around:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .around(_):
            return "/v1/vote/friend"
        }
    }

    var parameters: RequestParams {
        switch self {
        case let .around(queryDTO):
            return .requestQuery(queryDTO)
        }
    }
}
