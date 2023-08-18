//  KakaoLoginResponseDTO.swift
//  YELLO-iOS

import Foundation

// MARK: - KakaoLogin
struct KakaoLoginResponseDTO: Codable {
    let accessToken, refreshToken: String
    let isResigned: Bool
}
