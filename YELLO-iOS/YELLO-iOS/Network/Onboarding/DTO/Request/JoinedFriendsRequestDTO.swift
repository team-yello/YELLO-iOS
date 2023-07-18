//
//  AddFriendsRequestQueryDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/17.
//

import Foundation

// MARK: - JoinedFriendsRequestDTO
struct JoinedFriendsRequestDTO: Codable {
    let friendKakaoID: [String]
    let groupID: Int

    enum CodingKeys: String, CodingKey {
        case friendKakaoID = "friendKakaoId"
        case groupID = "groupId"
    }
}
