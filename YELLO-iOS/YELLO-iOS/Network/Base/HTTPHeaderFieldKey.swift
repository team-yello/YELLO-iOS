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
    case accessToken = "Bearer eyJ0eXBlIjoiYWNjZXNzVG9rZW4iLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyOTExNzI0MDAyIiwianRpIjoiMTQ4IiwiaWF0IjoxNjg5NzA3NTUyLCJleHAiOjE2ODk3OTM5NTJ9.u5nsIFvwcDDl1aUjti_d1cMclqdCzkmRg4ZYqElg7lE"
}

enum HTTPHeaderType {
    case plain
    case hasAccessToken
}
