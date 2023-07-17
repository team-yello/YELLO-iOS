//
//  VotingListDTO.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/17.
//

import Foundation

struct VotingListResponseDTO: Decodable {
    let questionPoint: Int
    let keywordList: [String]
    let question: Question
    let friendList: [FriendListData]
}

struct Question: Decodable {
    let questionID: Int
    let nameHead: String?
    let nameFoot: String
    let keywordHead: String?
    let keywordFoot: String?
}

struct FriendListData: Decodable {
    let id: Int?
    let yelloId: String?
    let name: String?
}
