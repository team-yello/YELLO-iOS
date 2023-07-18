//
//  JoinedFriendsResponseDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/18.
//

import Foundation
// MARK: - JoinedFriendsResponseDTO
struct JoinedFriendsResponseDTO: Codable {
    let totalCount: Int
    let friendList: [OnboardingFriendList]
}

// MARK: - FriendList
struct OnboardingFriendList: Codable {
    let group: String
    let id: Int
    let name, profileImage, groupName: String
}
