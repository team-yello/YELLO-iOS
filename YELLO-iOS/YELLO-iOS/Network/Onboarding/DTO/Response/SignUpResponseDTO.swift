//
//  SignInRequestDTO.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/15.
//

import Foundation

// MARK: - SignIn
// MARK: - SignUpResponseDTO
struct SignUpResponseDTO: Codable {
    let yelloID, accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case yelloID = "yelloId"
        case accessToken, refreshToken
    }
}
