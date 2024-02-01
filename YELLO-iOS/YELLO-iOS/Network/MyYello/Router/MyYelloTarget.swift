//
//  MyYelloTarget.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/15.
//

import Foundation

import Alamofire

enum MyYelloTarget {
    case myYello(_ queryDTO: MyYelloRequestQueryDTO)
    case myYelloDetail(voteId: Int)
    case myYelloDetailKeyword(voteId: Int)
    case myYelloDetailName(voteId: Int)
    case myYelloDetailFullName(voteId: Int)
    case payCheck(_ requestDTO: PayRequestBodyDTO)
}

extension MyYelloTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .myYello:
            return .authorization
        case .myYelloDetail:
            return .authorization
        case .myYelloDetailKeyword:
            return .authorization
        case .myYelloDetailName:
            return .authorization
        case .myYelloDetailFullName:
            return .authorization
        case .payCheck:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .myYello:
            return .plain
        case .myYelloDetail:
            return .plain
        case .myYelloDetailKeyword:
            return .plain
        case .myYelloDetailName:
            return .plain
        case .myYelloDetailFullName:
            return .plain
        case .payCheck:
            return .plain
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .myYello:
            return .get
        case .myYelloDetail:
            return .get
        case .myYelloDetailKeyword:
            return .patch
        case .myYelloDetailName:
            return .patch
        case .myYelloDetailFullName:
            return .patch
        case .payCheck:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .myYello(_):
            return "/v1/vote"
        case .myYelloDetail(let voteId):
            return "/v1/vote/\(voteId)"
        case .myYelloDetailKeyword(let voteId):
            return "/v1/vote/\(voteId)/keyword"
        case .myYelloDetailName(let voteId):
            return "/v1/vote/\(voteId)/name"
        case .myYelloDetailFullName(let voteId):
            return "/v1/vote/\(voteId)/fullname"
        case .payCheck(_):
            return "/v1/pay"
        }
    }

    var parameters: RequestParams {
        switch self {
        case let .myYello(queryDTO):
            return .requestQuery(queryDTO)
        case .myYelloDetail:
            return .requestPlain
        case .myYelloDetailKeyword:
            return .requestPlain
        case .myYelloDetailName:
            return .requestPlain
        case .myYelloDetailFullName:
            return .requestPlain
        case let .payCheck(requestDTO):
            return .requestWithBody(requestDTO)
        }
    }
}
