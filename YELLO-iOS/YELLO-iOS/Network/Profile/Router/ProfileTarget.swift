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
    case deleteUser
}

extension ProfileTarget: TargetType {
    var headerType: HTTPHeaderType {
        switch self {
        case .profileUser:
            return .hasAccessToken
        case .profileFriend:
            return .hasAccessToken
        case .profileDeleteFriend:
            return .hasAccessToken
        case .deleteUser:
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
        case .deleteUser:
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
        case .deleteUser:
            return "/user"
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
        case .deleteUser:
            return .requestPlain
        }
    }
}
