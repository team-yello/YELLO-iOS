//
//  HTTPHeaderField.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/15.
//

import Foundation

enum HTTPHeaderFieldKey: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case accessToken = "accessToken"
    case refreshtoken = "refreshtoken"
}

enum HTTPHeaderFieldValue: String {
    case json = "Application/json"
    case accessToken
}

enum HTTPHeaderType {
    case plain
    case hasAccessToken
}
