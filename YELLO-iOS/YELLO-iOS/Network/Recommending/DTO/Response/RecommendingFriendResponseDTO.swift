//
//  RecommendingFriendResponseDTO.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/17.
//

import Foundation

struct RecommendingFriendResponseDTO: Codable {
    let recommendingKakaoFriend: [RecommendingFriendListData]
}

struct RecommendingFriendListData: Codable {
    let id: String
    let name: String
    let group: String
    let profileImage: String?
}
