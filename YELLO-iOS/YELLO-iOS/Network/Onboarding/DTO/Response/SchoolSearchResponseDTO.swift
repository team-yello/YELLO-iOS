//
//  SchoolSearchResponseDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/17.
//

import Foundation

// MARK: - SchoolSearchResponseDTO
struct SchoolSearchResponseDTO: Codable {
    let totalCount: Int
    let groupNameList: [String]
}

