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
    let ticketCount: Int
    let votes: [Yello]
}

// MARK: - VoteElement
struct Yello: Codable, Hashable {
    let id: Int
    let senderGender: String
    let senderName: String
    var nameHint: Int
    let vote: Vote
    var isHintUsed: Bool
    var isRead: Bool
    let createdAt: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Yello, rhs: Yello) -> Bool {
        return lhs.id == rhs.id
    }
}

// Diffable Data Source를 적용할 때 사용할 스냅샷 구조체
struct MyYelloSnapshot {
    var items: [Yello]
    static var empty: MyYelloSnapshot {
        return MyYelloSnapshot(items: [])
    }
}

// MARK: - Vote
struct Vote: Codable {
    let nameHead: String?
    let nameFoot: String?
    let keywordHead: String?
    let keyword: String
    let keywordFoot: String?
}
