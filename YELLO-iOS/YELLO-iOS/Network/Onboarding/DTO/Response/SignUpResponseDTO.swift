//
//  SignInRequestDTO.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/15.
//

import Foundation

// MARK: - SignIn
struct SignInResponseDTO: Codable {
    let social, email: String
    let profileImage: String
    let groupID, groupAdmissionYear: Int
    let name, yelloID, gender: String
    let friends: [Int]
    let recommendID: String

    enum CodingKeys: String, CodingKey {
        case social, email, profileImage
        case groupID = "groupId"
        case groupAdmissionYear, name
        case yelloID = "yelloId"
        case gender, friends
        case recommendID = "recommendId"
    }
}
