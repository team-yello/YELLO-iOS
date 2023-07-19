//
//  IdValidResponseDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/17.
//

import Foundation

// MARK: - IDValidResponseDTO
struct IDValidResponseDTO: Codable {
    let status: Int
    let message: String
    let data: Bool?
}
