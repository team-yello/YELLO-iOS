//
//  TokenRefreshRequestDTO.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/20.
//

import Foundation

struct TokenRefreshRequestDTO: Codable {
    let accessToken, refreshToken: String
}
