//
//  SignUpRequestDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/17.
//

import Foundation

// MARK: - SignUpRequestDTO
struct SignUpRequestDTO: Codable {
    let social, uuid, deviceToken, email, profileImage: String
    let groupID, groupAdmissionYear: Int
    let name, yelloID, gender: String
    let friends: [Int]
    let recommendID: String?

    enum CodingKeys: String, CodingKey {
        case social, uuid, deviceToken, email, profileImage
        case groupID = "groupId"
        case groupAdmissionYear, name
        case yelloID = "yelloId"
        case gender, friends
        case recommendID = "recommendId"
    }
}
