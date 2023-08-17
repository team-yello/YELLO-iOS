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
}

extension PurchaseTarget: TargetType {
    var headerType: HTTPHeaderType {
        switch self {
        case .purchaseSubscibe(_):
            return .hasAccessToken
        case .purchaseTicket(_):
            return .hasAccessToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .purchaseSubscibe:
            return .post
        case .purchaseTicket:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .purchaseSubscibe(_):
            return "/purchase/apple/verify/subscribe"
        case .purchaseTicket(_):
            return "/purchase/apple/verify/ticket"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case let .purchaseSubscibe(requestDTO):
            return .requestWithBody(requestDTO)
        case let .purchaseTicket(requestDTO):
            return .requestWithBody(requestDTO)
        }
    }
}
