//
//  VotingTarget.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/15.
//

import Foundation

import Alamofire

enum VotingTarget {
    case getVotingAvailable(_ dto: VotingAvailableRequestDTO)
}

extension VotingTarget: TargetType {
    var method: HTTPMethod {
        switch self {
        case .getVotingAvailable(_):
            return .get
        }
    }

    var path: String {
        switch self {
        case .getVotingAvailable(_):
            return "/vote/available"
        }
    }

    var parameters: RequestParams {
        switch self {
        case .getVotingAvailable(let dto):
            return .requestQuery(dto)
        }
    }

}
