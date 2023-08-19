//
//  VoteAnswerList.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/19.
//

import Foundation

struct VoteAnswerList: Codable {
    let friendId: Int
    let questionId: Int
    let keywordName: String
    let colorIndex: Int
}

// 구조체를 UserDefault에 저장하는 함수
func saveUserData(_ userData: [VoteAnswerList]) {
    let encoder = JSONEncoder()
    if let encodedData = try? encoder.encode(userData) {
        UserDefaults.standard.set(encodedData, forKey: "UserDataKey")
    }
}

// UserDefault에서 구조체를 가져오는 함수
func loadUserData() -> [VoteAnswerList]? {
    if let encodedData = UserDefaults.standard.data(forKey: "UserDataKey") {
        let decoder = JSONDecoder()
        if let userData = try? decoder.decode([VoteAnswerList].self, from: encodedData) {
            return userData
        }
    }
    return nil
}
