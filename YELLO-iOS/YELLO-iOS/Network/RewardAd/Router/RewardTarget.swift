//
//  RewardTarget.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2/18/24.
//

import Foundation
import Alamofire

@frozen
enum RewardTarget {
    case rewardPossible(_ tag: String)
    case rewardResult(_ requestDTO: RewardRequestDTO)
}

extension RewardTarget: TargetType {
    
    var authorization: Authorization {
        switch self {
        case .rewardPossible:
            return .authorization
        case .rewardResult:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .rewardPossible:
            return .hasToken
        case .rewardResult:
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .rewardPossible:
            return .get
        case .rewardResult:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .rewardPossible(let tag):
            return "/v1/admob/possible/\(tag)"
        case .rewardResult:
            return "/v1/admob/reward"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .rewardPossible:
            return .requestPlain
        case .rewardResult(let requestDTO):
            return .requestWithBody(requestDTO)
        }
    }
}
