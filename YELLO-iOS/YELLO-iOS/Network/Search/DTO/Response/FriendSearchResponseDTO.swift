//
//  FriendSearchResponseDTO.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/14.
//

import Foundation

// MARK: - FriendSearchResponseDTO
struct FriendSearchResponseDTO: Codable {
    let totalCount: Int
    let friendList: [Friend]
}

struct Friend: Codable {
    let group, yelloId, name, profileImage: String
    let id: Int
    let isFriend: Bool
}
