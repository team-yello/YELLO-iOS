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
    case recommendingAddFriend(_ friendId: Int)
}

extension RecommendingTarget: TargetType {
    
    var authorization: Authorization {
        switch self {
        case .recommendingKakaoFriend(_, _):
            return .authorization
        case .recommendingSchoolFriend(_):
            return .authorization
        case .recommendingAddFriend(_):
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .recommendingKakaoFriend(_, _):
            return .plain
        case .recommendingSchoolFriend(_):
            return .plain
        case .recommendingAddFriend(_):
            return .plain
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .recommendingKakaoFriend:
            return .post
        case .recommendingSchoolFriend:
            return .get
        case .recommendingAddFriend:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .recommendingKakaoFriend(_, _):
            return "/friend/recommend/kakao"
        case .recommendingSchoolFriend(_):
            return "/friend/recommend/school"
        case .recommendingAddFriend(let friendId):
            return "friend/\(friendId)"
        }
    }

    var parameters: RequestParams {
        switch self {
        case let .recommendingKakaoFriend(queryDTO, requestDTO):
            return .requestQueryWithBody(queryDTO, bodyParameter: requestDTO)
        case let .recommendingSchoolFriend(queryDTO):
            return .requestQuery(queryDTO)
        case .recommendingAddFriend:
            return .requestPlain
        }
    }
}
