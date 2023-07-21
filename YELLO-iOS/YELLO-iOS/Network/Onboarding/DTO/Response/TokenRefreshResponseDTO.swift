//
//  TokenRefreshResponseDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/22.
//

import Foundation

// MARK: - KakaoLoginRequestDTO
struct TokenRefreshResponseDTO: Codable {
    let accessToken, refreshToken : String
}
