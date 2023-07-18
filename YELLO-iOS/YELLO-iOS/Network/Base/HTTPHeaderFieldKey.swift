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
    case accessToken = "Bearer eyJ0eXBlIjoiYWNjZXNzVG9rZW4iLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyOTExNzI0MDAyIiwianRpIjoiMTQ4IiwiaWF0IjoxNjg5NjE5NzkzLCJleHAiOjE2ODk3MDYxOTN9.pBvnzLuwAg2wDZZ77HUBbdZvE0-Xvp6XRhqF9ZDA1xc"
}

enum HTTPHeaderType {
    case plain
    case hasAccessToken
}
