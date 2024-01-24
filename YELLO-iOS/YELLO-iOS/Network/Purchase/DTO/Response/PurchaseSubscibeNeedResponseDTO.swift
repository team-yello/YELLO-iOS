//
//  PurchaseSubscibeNeedResponseDTO.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/18.
//

import Foundation

struct PurchaseSubscibeNeedResponseDTO: Codable {
    let id: Int
    let subscribe: String
    let expiredDate: String
}
