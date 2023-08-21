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
    case purchaseInfo
}

extension ProfileTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .profileUser:
            return .authorization
        case .profileFriend:
            return .authorization
        case .profileDeleteFriend:
            return .authorization
        case .deleteUser:
            return .authorization
        case .purchaseInfo:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .profileUser:
            return .plain
        case .profileFriend:
            return .plain
        case .profileDeleteFriend:
            return .plain
        case .deleteUser:
            return .plain
        case .purchaseInfo:
            return .plain
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
        case .purchaseInfo:
            return .get
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
        case .purchaseInfo:
            return "/purchase/purchaseInfo"
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
        case .purchaseInfo:
            return .requestPlain
        }
    }
}
