//
//  PurchaseTarget.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/17.
//

import Foundation

import Alamofire

enum PurchaseTarget {
    case purchaseSubscibe(_ requestDTO: PurchaseRequestDTO)
    case purchaseTicket(_ requestDTO: PurchaseRequestDTO)
    case purchaseSubscibeNeed
}

extension PurchaseTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .purchaseSubscibe(_):
            return .authorization
        case .purchaseTicket(_):
            return .authorization
        case .purchaseSubscibeNeed:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .purchaseSubscibe(_):
            return .plain
        case .purchaseTicket(_):
            return .plain
        case .purchaseSubscibeNeed:
            return .plain
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .purchaseSubscibe:
            return .post
        case .purchaseTicket:
            return .post
        case .purchaseSubscibeNeed:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .purchaseSubscibe(_):
            return "/v1/purchase/apple/verify/subscribe"
        case .purchaseTicket(_):
            return "/v1/purchase/apple/verify/ticket"
        case .purchaseSubscibeNeed:
            return "/v1/user/subscribe"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case let .purchaseSubscibe(requestDTO):
            return .requestWithBody(requestDTO)
        case let .purchaseTicket(requestDTO):
            return .requestWithBody(requestDTO)
        case .purchaseSubscibeNeed:
            return .requestPlain
        }
    }
}
