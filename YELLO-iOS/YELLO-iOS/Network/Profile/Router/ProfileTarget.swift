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
    case accountUpdatedAt
    case editProfile(_ request: EditProfileRequestDTO)
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
        case .accountUpdatedAt:
            return .authorization
        case .editProfile:
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
        case .accountUpdatedAt:
            return .plain
        case .editProfile:
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
        case .accountUpdatedAt:
            return .get
        case .editProfile:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .profileUser:
            return "/v2/user"
        case .profileFriend:
            return "/v1/friend"
        case .profileDeleteFriend(let id):
            return "/v1/friend/\(id)"
        case .deleteUser:
            return "/v1/user"
        case .purchaseInfo:
            return "/v1/purchase"
        case .accountUpdatedAt:
            return "/v1/user/data/account-updated-at"
        case .editProfile:
            return "/v1/user"
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
        case .accountUpdatedAt:
            return .requestPlain
        case let .editProfile(request):
            return .requestWithBody(request)
        }
    }
}
