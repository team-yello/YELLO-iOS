//
//  HighSchoolSearchResponseDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/09/19.
//

import Foundation

// MARK: - HighSchoolSearchResponseDTO
struct HighSchoolSearchResponseDTO: Codable {
    let totalCount: Int
    let groupNameList: [String]
}
