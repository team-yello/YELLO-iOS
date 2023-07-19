//
//  ProfileTarget.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/15.
//

import Foundation

import Alamofire

enum ProfileTarget {
    case profileUser
    case profileFriend(_ queryDTO: ProfileFriendRequestQueryDTO)
    case profileDeleteFriend(id: Int)
}

extension ProfileTarget: TargetType {
    var headerType: HTTPHeaderType {
        switch self {
        case .profileUser(let userId):
            return .hasAccessToken
        case .profileFriend(let _):
            return .hasAccessToken
        case .profileDeleteFriend(let id):
            return .hasAccessToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .profileUser:
            return .get
        case .profileFriend:
            return .get
        case .profileDeleteFriend:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .profileUser:
            return "/user"
        case .profileFriend(_):
            return "/friend"
        case .profileDeleteFriend(let id):
            return "/friend/\(id)"
        }
    }

    var parameters: RequestParams {
        switch self {
        case .profileUser:
            return .requestPlain
        case let .profileFriend(queryDTO):
            return .requestQuery(queryDTO)
        case .profileDeleteFriend:
            return .requestPlain
        }
    }
}
