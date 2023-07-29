//
//  VotingList.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/17.
//

import Foundation

struct VotingData: Codable {
    let nameHead: String
    let nameFoot: String
    let keywordHead: String
    let keywordFoot: String
    let friendList: [String]
    let keywordList: [String]
    let questionId: Int
    var friendId: [Int]
    let questionPoint: Int
}

// 구조체를 UserDefault에 저장하는 함수
func saveVotingData(_ userData: [VotingData]) {
    let encoder = JSONEncoder()
    if let encodedData = try? encoder.encode(userData) {
        UserDefaults.standard.set(encodedData, forKey: "saveVotingData")
    }
}

// UserDefault에서 구조체를 가져오는 함수
func loadVotingData() -> [VotingData]? {
    if let encodedData = UserDefaults.standard.data(forKey: "saveVotingData") {
        let decoder = JSONDecoder()
        if let userData = try? decoder.decode([VotingData].self, from: encodedData) {
            return userData
        }
    }
    return nil
}
