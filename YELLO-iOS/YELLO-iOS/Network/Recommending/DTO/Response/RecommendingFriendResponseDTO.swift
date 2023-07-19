//
//  RecommendingFriendResponseDTO.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/17.
//

import Foundation

struct RecommendingFriendResponseDTO: Codable {
    let totalCount: Int
    let friends: [Friends]
}

struct Friends: Codable {
    let id: Int
    let name: String
    let group: String
    let profileImage: String?
}
