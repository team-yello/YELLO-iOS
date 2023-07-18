//
//  MyYelloResponseDTO.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/18.
//

import Foundation

// MARK: - DataClass
struct MyYelloResponseDTO: Codable {
    let totalCount: Int
    let votes: [Yello]
}

// MARK: - VoteElement
struct Yello: Codable {
    let id: Int
    let senderGender: String
    let senderName: String
    let nameHint: Int
    let vote: Vote
    let isHintUsed: Bool
    let isRead: Bool
    let createdAt: String
}

// MARK: - Vote
struct Vote: Codable {
    let nameHead: String?
    let nameFoot: String?
    let keywordHead: String?
    let keyword: String
    let keywordFoot: String?
}
