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
}

extension VotingTarget: TargetType {
    var method: HTTPMethod {
        switch self {
        case .getVotingAvailable:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getVotingAvailable:
            return "/vote/available"
        }
    }

    var parameters: RequestParams {
        switch self {
        case .getVotingAvailable:
            return .requestPlain
        }
    }

}
