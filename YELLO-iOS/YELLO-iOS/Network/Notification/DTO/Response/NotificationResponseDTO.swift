//
//  UserNotificationResponseDTO.swift
//  YELLO-iOS
//
//  Created by 변희주 on 1/28/24.
//

import Foundation

struct NotificationResponseDTO: Codable {
    let imageUrl: String
    let redirectUrl: String
    let startDate: String
    let endDate: String
    let isAvailable: Bool
    let type: String
    let title: String
}
