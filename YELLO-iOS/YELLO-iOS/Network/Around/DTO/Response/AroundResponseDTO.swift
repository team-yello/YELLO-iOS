//
//  AroundResponseDTO.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/14.
//

import Foundation

// MARK: - AroundResponseDTO
struct AroundResponseDTO: Codable {
    let totalCount: Int
    let friendVotes: [FriendVote]
}

// MARK: - FriendVote
struct FriendVote: Codable {
    let id: Int
    let receiverName, senderGender: String
    let vote: Vote
    let isHintUsed: Bool
    let createdAt: String
}
