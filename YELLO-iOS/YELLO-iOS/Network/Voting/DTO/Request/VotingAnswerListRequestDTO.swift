//
//  VotingAnswerListRequestDTO.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/17.
//

import Foundation

struct VotingAnswerListRequestDTO: Encodable {
    let voteAnswerList: [VoteAnswerList]
    let totalPoint: Int
}

struct VoteAnswerList: Encodable {
    let friendId: Int
    let questionId: Int
    let keywordName: String
    let colorIndex: Int
}
