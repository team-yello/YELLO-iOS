//
//  EventRewardRsponseDTO.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2/7/24.
//

import Foundation

// MARK: - DataClass
struct EventRewardRsponseDTO: Codable {
    let rewardTag: String
    let rewardValue: Int
    let rewardTitle: String
    let rewardImage: String
}
