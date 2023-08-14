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
    let friendVotes: [AroundFriendVote]
}

// MARK: - FriendVote
struct AroundFriendVote: Codable {
    let id: Int
    let receiverName, senderGender: String
    let vote: AroundVote
    let isHintUsed: Bool
    let createdAt: String
}

// MARK: - Vote
struct AroundVote: Codable {
    let nameHead, nameFoot, keywordHead, keyword, keywordFoot: String
}
