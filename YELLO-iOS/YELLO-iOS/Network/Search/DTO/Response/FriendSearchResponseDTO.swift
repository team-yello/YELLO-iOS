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
    let friends: [Friend]
}

// MARK: - Friend
struct Friend: Codable {
    let id: Int
    let name, group, profileImage: String
}
