//
//  MajorSearchRequestQueryDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/17.
//

import Foundation

// MARK: - MajorSearchRequestQueryDTO
struct MajorSearchRequestQueryDTO: Codable {
    let school: String
    let search: String
    let page: Int
}
