//
//  FriendSearchRequestQueryDTO.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/14.
//

import Foundation

// MARK: - FriendSearchRequestQueryDTO
struct FriendSearchRequestQueryDTO: Codable {
    let keyword: String
    let page: Int
}
