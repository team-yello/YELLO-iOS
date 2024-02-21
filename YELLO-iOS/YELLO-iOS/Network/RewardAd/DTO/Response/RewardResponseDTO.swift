//
//  RewardResponseDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2/18/24.
//

import Foundation

struct RewardResponseDTO: Codable {
    let rewardTag: String
    let rewardValue: Int
    let rewardTitle: String
    let rewardImage: String
}
