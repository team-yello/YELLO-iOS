//
//  HighSchoolSearchRequestQueryDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/09/19.
//

import Foundation

// MARK: - HighSchoolSearchRequestQueryDTO
struct HighSchoolSearchRequestQueryDTO: Codable {
    let keyword: String
    let page: Int
}
