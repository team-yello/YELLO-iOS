//
//  schoolSearchRequestDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/17.
//

import Foundation

// MARK: - SchoolSearchRequestDTO
struct SchoolSearchRequestQueryDTO: Codable {
    let keyword: String
    let page: Int
}
