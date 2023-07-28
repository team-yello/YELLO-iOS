//
//  TokenRefreshResponseDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/22.
//

import Foundation

// MARK: - SignUpResponseDTO
struct TokenRefreshResponseDTO: Codable {
    let status: Int
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let accessToken, refreshToken: String
}

//// MARK: - KakaoLoginRequestDTO
//struct TokenRefreshResponseDTO: Codable {
//    let accessToken, refreshToken : String
//}
