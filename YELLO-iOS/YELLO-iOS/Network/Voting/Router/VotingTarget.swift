//
//  VotingTarget.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/15.
//

import Foundation

import Alamofire

enum VotingTarget {
    case getVotingAvailable
    case getVotingSuffle
    case getVotingList
    case postVotingAnswerList(_ requestDTO: VotingAnswerListRequestDTO)
    case getUnreadCount
}

extension VotingTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .getVotingAvailable:
            return .authorization
        case .getVotingSuffle:
            return .authorization
        case .getVotingList:
            return .authorization
        case .postVotingAnswerList:
            return .authorization
        case .getUnreadCount:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .getVotingAvailable:
            return .plain
        case .getVotingSuffle:
            return .plain
        case .getVotingList:
            return .plain
        case .postVotingAnswerList:
            return .plain
        case .getUnreadCount:
            return .plain
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getVotingAvailable:
            return .get
        case .getVotingSuffle:
            return .get
        case .getVotingList:
            return .get
        case .postVotingAnswerList:
            return .post
        case .getUnreadCount:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getVotingAvailable:
            return "/v1/vote/available"
        case .getVotingSuffle:
            return "/v1/friend/shuffle"
        case .getVotingList:
            return "/v1/vote/question"
        case .postVotingAnswerList:
            return "/v1/vote"
        case .getUnreadCount:
            return "/v1/vote/count"
        }
    }

    var parameters: RequestParams {
        switch self {
        case .getVotingAvailable:
            return .requestPlain
        case .getVotingSuffle:
            return .requestPlain
        case .getVotingList:
            return .requestPlain
        case let .postVotingAnswerList(requestDTO):
            return .requestWithBody(requestDTO)
        case .getUnreadCount:
            return .requestPlain
        }
    }

}
