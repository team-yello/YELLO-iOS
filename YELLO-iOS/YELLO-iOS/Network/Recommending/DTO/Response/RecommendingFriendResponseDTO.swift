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

struct Friends: Codable, Hashable {
    let id: Int
    let name: String
    let group: String
    let profileImage: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Friends, rhs: Friends) -> Bool {
        return lhs.id == rhs.id
    }
}
