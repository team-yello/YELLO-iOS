//
//  CheckDuplicateRequestDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/16.
//

import Foundation

// MARK: - CheckDuplicate
struct CheckDuplicateResponeDTO: Codable {
    let status: Int
    let message: String
    let data: Bool
}
