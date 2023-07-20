//
//  VotingList.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/17.
//

import Foundation

struct VotingData {
    let nameHead: String
    let nameFoot: String
    let keywordHead: String
    let keywordFoot: String
    let friendList: [String]
    let keywordList: [String]
    let questionId: Int
    var friendId: [Int]
    let questionPoint: Int
}
