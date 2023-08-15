//
//  SearchTarget.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/14.
//

import Foundation
import Alamofire

@frozen
enum SearchTarget {
    case friendSearch(_ dto: FriendSearchRequestQueryDTO) /// 학교 검색
}

extension SearchTarget: TargetType {
    var headerType: HTTPHeaderType {
        switch self {
        case .friendSearch:
            return .plain
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .friendSearch:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .friendSearch:
            return "/friend/search"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .friendSearch(let dto):
            return .requestQuery(dto)
        }
    }
}
