//
//  HTTPHeaderField.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/15.
//

import Foundation

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

enum ContentType: String {
    case json = "Application/json"
}
