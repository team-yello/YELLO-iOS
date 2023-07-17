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
}

extension MyYelloTarget: TargetType {
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
        }
    }
    
    var path: String {
        switch self {
        case .myYello(_):
            return "/vote"
        case .myYelloDetail(let voteId):
            return "/vote/\(voteId)"
        case .myYelloDetailKeyword(let voteId):
            return "/vote/\(voteId)/keyword"
        case .myYelloDetailName(let voteId):
            return "/vote/\(voteId)/name"
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
        }
    }
}
