//
//  PurchaseInfoResponseDTO.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/18.
//

import Foundation

struct PurchaseInfoResponseDTO: Codable {
    let subscribeState: String
    let isSubscribe: Bool
    let ticketCount: Int
}

