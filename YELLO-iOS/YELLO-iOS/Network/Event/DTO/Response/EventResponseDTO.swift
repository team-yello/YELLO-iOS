//
//  EventResponseDTO.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2/6/24.
//

import Foundation

// MARK: - EventResponseDTO
struct EventResponseDTO: Codable {
    let tag: String
    let startDate, endDate: String
    let title, subTitle: String
    let animationList: [String]
    let eventReward: EventReward?
}

// MARK: - EventReward
struct EventReward: Codable {
    let startTime, endTime: String
    let rewardCount: Int
    let eventRewardItem: [EventRewardItem]
}

// MARK: - EventRewardItem
struct EventRewardItem: Codable {
    let tag, eventRewardTitle: String
    let eventRewardImage: String
    let maxRewardValue, minRewardValue, eventRewardProbability: Int
    let randomTag: String
}
