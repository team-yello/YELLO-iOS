//
//  KakaoLoginRequestDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/17.
//

import Foundation

// MARK: - KakaoLoginRequestDTO
struct KakaoLoginRequestDTO: Codable {
    let accessToken, social, deviceToken: String
}
