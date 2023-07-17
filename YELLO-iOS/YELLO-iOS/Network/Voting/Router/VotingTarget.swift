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
}

extension VotingTarget: TargetType {
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
        }
    }

    var path: String {
        switch self {
        case .getVotingAvailable:
            return "/vote/available"
        case .getVotingSuffle:
            return "/friend/shuffle"
        case .getVotingList:
            return "/vote/question"
        case .postVotingAnswerList:
            return "/vote"
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
        }
    }

}
