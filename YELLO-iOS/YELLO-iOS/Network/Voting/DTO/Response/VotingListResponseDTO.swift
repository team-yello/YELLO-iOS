//
//  VotingListDTO.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/17.
//

import Foundation

struct VotingListResponseDTO: Decodable {
    let question: Question
    let friendList: [FriendList]
    let keywordList: [String]
    let questionPoint: Int
}

struct Question: Decodable {
    let questionId: Int
    let nameHead: String?
    let nameFoot, keywordHead: String?
    let keywordFoot: String?
}

struct FriendList: Decodable {
    let id: Int
    let yelloId, name: String
}
