//
//  ProfileUserResponseDTO.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/17.
//

import Foundation

struct ProfileUserResponseDTO: Codable {
    let userID: Int
    let name, yelloID, gender, email: String
    let profileImageURL, social, uuid, deviceToken: String
    let groupID: Int
    let group, groupType, groupName, subGroupName: String
    let groupAdmissionYear, recommendCount, ticketCount, point: Int
    let subscribe: String
    let yelloCount, friendCount: Int

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case name
        case yelloID = "yelloId"
        case gender, email
        case profileImageURL = "profileImageUrl"
        case social, uuid, deviceToken
        case groupID = "groupId"
        case group, groupType, groupName, subGroupName, groupAdmissionYear, recommendCount, ticketCount, point, subscribe, yelloCount, friendCount
    }
}
