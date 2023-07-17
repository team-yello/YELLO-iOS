//
//  ProfileTarget.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/15.
//

import Foundation

import Alamofire

enum ProfileTarget {
    case profileUser(userId: Int)
    case profileFriend(_ queryDTO: ProfileFriendRequestQueryDTO)
    case profileDeleteFriend(id: Int)
}

extension ProfileTarget: TargetType {
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
        case .profileUser(let userId):
            return "/user/\(userId)"
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
