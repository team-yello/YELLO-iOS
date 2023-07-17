//
//  VotingListDTO.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/17.
//

import Foundation

struct VotingListResponseDTO: Decodable {
    let question: Question
    let friendList: [String]
    let keywordList: [String]
    let questionPoint: Int
}

struct Question: Decodable {
    let questionID: Int
    let nameHead: String
    let nameFoot, keywordHead: String?
    let keywordFoot: String
}
