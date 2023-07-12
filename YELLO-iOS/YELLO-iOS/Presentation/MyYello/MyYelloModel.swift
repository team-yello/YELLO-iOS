//
//  MyYelloModel.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import Foundation

// MARK: - MyYelloModel
struct MyYelloModel: Codable {
    let status: Int
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let totalCount: Int
    let yello: [Yello]
}

// MARK: - Yello
struct Yello: Codable {
    let id: Int
    let gender: String
    let nameHint: Int
    let senderName: String
    let vote: Vote
    let isHintUsed, isRead: Bool
    let createdAt: String
}

// MARK: - Vote
struct Vote: Codable {
    let nameHead, nameFoot, keywordHead, keyword: String
    let keywordFoot: String
}

var MyYelloModelDummy: [Yello] = [
    Yello(id: 1, gender: "M", nameHint: -1, senderName: "권세훈", vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: false, isRead: true, createdAt: "1시간 전"),
    Yello(id: 2, gender: "F", nameHint: 0, senderName: "정채은", vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: true, isRead: true, createdAt: "1시간 전"),
    Yello(id: 3, gender: "F", nameHint: 1, senderName: "이지희", vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: true, isRead: true, createdAt: "1시간 전"),
    Yello(id: 4, gender: "M", nameHint: 0, senderName: "김효원", vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: true, isRead: true, createdAt: "1시간 전"),
    Yello(id: 5, gender: "M", nameHint: 1, senderName: "권세훈", vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: true, isRead: true, createdAt: "1시간 전"),
    Yello(id: 6, gender: "F", nameHint: -1, senderName: "강국희", vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: false, isRead: false, createdAt: "1시간 전"),
    Yello(id: 7, gender: "M", nameHint: -1, senderName: "권세훈", vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: false, isRead: false, createdAt: "1시간 전"),
    Yello(id: 8, gender: "F", nameHint: 0, senderName: "권세훈", vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: true, isRead: true, createdAt: "1시간 전")
]
