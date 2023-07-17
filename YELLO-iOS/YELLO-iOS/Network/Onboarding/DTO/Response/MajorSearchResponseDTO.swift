//
//  MajorSearchDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/17.
//

import Foundation

// MARK: - MajorSearchResponseDTO
// MARK: - MajorSearchResponseDTO
struct MajorSearchResponseDTO: Codable {
    let totalCount: Int
    let groupList: [GroupList]
}

// MARK: - GroupList
struct GroupList: Codable {
    let groupID: Int
    let departmentName: String

    enum CodingKeys: String, CodingKey {
        case groupID = "groupId"
        case departmentName
    }
}
