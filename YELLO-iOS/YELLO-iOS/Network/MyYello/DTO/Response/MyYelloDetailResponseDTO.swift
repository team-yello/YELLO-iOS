//
//  MyYelloDetailResponseDTO.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/18.
//

import Foundation

struct MyYelloDetailResponseDTO: Codable {
    let nameHint: Int
    let colorIndex: Int
    let isAnswerRevealed: Bool
    let senderName: String
    let senderGender: String
    let vote: Vote
}
