//
//  EditProfileRequestDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2/1/24.
//

import Foundation

// MARK: - EditProfileRequestDTO
struct EditProfileRequestDTO: Codable {
    let name, yelloID, gender, email: String
    let profileImageURL: String
    let groupID, groupAdmissionYear: Int

    enum CodingKeys: String, CodingKey {
        case name
        case yelloID = "yelloId"
        case gender, email
        case profileImageURL = "profileImageUrl"
        case groupID = "groupId"
        case groupAdmissionYear
    }
}
