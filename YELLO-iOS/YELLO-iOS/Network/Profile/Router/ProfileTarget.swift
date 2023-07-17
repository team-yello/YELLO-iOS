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
}

extension ProfileTarget: TargetType {
    var method: HTTPMethod {
        switch self {
        case .profileUser:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .profileUser(let userId):
            return "/user/\(userId)"
        }
    }

    var parameters: RequestParams {
        switch self {
        case .profileUser:
            return .requestPlain
        }
    }
}
