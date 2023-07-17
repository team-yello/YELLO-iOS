//
//  ProfileUserResponseDTO.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/17.
//

import Foundation

struct ProfileUserResponseDTO: Codable {
    let userId: Int
    let name: String
    let profileImageUrl: String?
    let group: String
    let yelloId: String
    let yelloCount: Int
    let friendCount: Int
    let point: Int
}
