//
//  f.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/15.
//

import Foundation

struct VotingAvailableResponseDTO: Decodable {
    let isStart: Bool
    let point: Int
    let createdAt: String
}
