//
//  RecommendingTarget.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/15.
//

import Foundation

import Alamofire

enum RecommendingTarget {
    case recommendingKakaoFriend(_ queryDTO: RecommendingRequestQueryDTO, _ requestDTO: RecommendingFriendRequestDTO)
    case recommendingSchoolFriend(_ queryDTO: RecommendingRequestQueryDTO)
}

extension RecommendingTarget: TargetType {
    var method: HTTPMethod {
        switch self {
        case .recommendingKakaoFriend:
            return .post
        case .recommendingSchoolFriend:
            return .get
        }
    }

    var path: String {
        switch self {
        case .recommendingKakaoFriend(_, _):
            return "/friend/recommend/kakao"
        case .recommendingSchoolFriend(_):
            return "/friend/recommend/school?"
        }
    }

    var parameters: RequestParams {
        switch self {
        case let .recommendingKakaoFriend(queryDTO, requestDTO):
            return .requestQueryWithBody(queryDTO, bodyParameter: requestDTO)
        case let .recommendingSchoolFriend(queryDTO):
            return .requestQuery(queryDTO)
        }
    }
}
