//
//  RewardRequestDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2/18/24.
//

import Foundation

struct RewardRequestDTO: Codable {
    let rewardType, randomType, uuid: String
    let rewardNumber: Int
}
