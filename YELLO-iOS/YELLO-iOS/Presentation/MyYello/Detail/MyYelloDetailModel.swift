//
//  MyYelloDetailModel.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/13.
//

import UIKit


// MARK: - MyYelloDetailModel
struct MyYelloDetailModel: Codable {
    let status: Int
    let message: String
    let data: MyYelloDetailModelData
}

// MARK: - MyYelloDetailModelData
struct MyYelloDetailModelData: Codable {
    let nameHint, colorIndex: Int
    let isAnswerRevealed: Bool
    let senderName: String
    let vote: Vote
}

var MyYelloDetailModelDummy: [MyYelloDetailModelData] = [
    MyYelloDetailModelData(nameHint: -1, colorIndex: 1, isAnswerRevealed: false, senderName: "권세훈", vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야")),
    MyYelloDetailModelData(nameHint: -1, colorIndex: 2, isAnswerRevealed: false, senderName: "정채은", vote: Vote(nameHead: "나는", nameFoot: "와", keywordHead: "한강에서", keyword: "산책하고", keywordFoot: "싶어")),
    MyYelloDetailModelData(nameHint: -1, colorIndex: 3, isAnswerRevealed: false, senderName: "이지희", vote: Vote(nameHead: "", nameFoot: "는 학교에서", keywordHead: "", keyword: "연예인", keywordFoot: "역할을 맡을 것 같아")),
    MyYelloDetailModelData(nameHint: -1, colorIndex: 4, isAnswerRevealed: false, senderName: "김효원", vote: Vote(nameHead: "세상에", nameFoot: "랑 둘이", keywordHead: "남으면", keyword: "모르는 척 하고", keywordFoot: "싶어")),
    MyYelloDetailModelData(nameHint: -1, colorIndex: 5, isAnswerRevealed: false, senderName: "권세훈", vote: Vote(nameHead: "", nameFoot: "의 MBTI는", keywordHead: "", keyword: "CUTE", keywordFoot: "일 것 같아")),
    MyYelloDetailModelData(nameHint: -1, colorIndex: 6, isAnswerRevealed: false, senderName: "강국희", vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야")),
    MyYelloDetailModelData(nameHint: -1, colorIndex: 1, isAnswerRevealed: false, senderName: "권세훈", vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"))
]


struct MyYelloBackgroundColorDummy {
    let backgroundColorTop: UIColor
    let backgroundColorBottom: UIColor
}

struct MyYelloBackgroundColorStringDummy {
    let backgroundColorTop: String
    let backgroundColorBottom: String
}

var myYelloBackgroundColorDummy: [MyYelloBackgroundColorDummy] =
        [MyYelloBackgroundColorDummy(backgroundColorTop: UIColor(hex: "6437FF"),
                      backgroundColorBottom: UIColor(hex: "A892FF")),
         MyYelloBackgroundColorDummy(backgroundColorTop: UIColor(hex: "62DFAF"),
                      backgroundColorBottom: UIColor(hex: "A5F475")),
         MyYelloBackgroundColorDummy(backgroundColorTop: UIColor(hex: "FF4D8D"),
                      backgroundColorBottom: UIColor(hex: "FF7C7C")),
         MyYelloBackgroundColorDummy(backgroundColorTop: UIColor(hex: "1DD4ED"),
                      backgroundColorBottom: UIColor(hex: "50D9C0")),
         MyYelloBackgroundColorDummy(backgroundColorTop: UIColor(hex: "E170F3"),
                      backgroundColorBottom: UIColor(hex: "A892FF")),
         MyYelloBackgroundColorDummy(backgroundColorTop: UIColor(hex: "2E9AFE"),
                      backgroundColorBottom: UIColor(hex: "02CBD8")),
         MyYelloBackgroundColorDummy(backgroundColorTop: UIColor(hex: "FE5B5B"),
                      backgroundColorBottom: UIColor(hex: "F88B7C")),
         MyYelloBackgroundColorDummy(backgroundColorTop: UIColor(hex: "31E3C7"),
                      backgroundColorBottom: UIColor(hex: "A5ECD7")),
         MyYelloBackgroundColorDummy(backgroundColorTop: UIColor(hex: "FF3062"),
                      backgroundColorBottom: UIColor(hex: "FE584C")),
         MyYelloBackgroundColorDummy(backgroundColorTop: UIColor(hex: "6E6EEC"),
                      backgroundColorBottom: UIColor(hex: "ECB2F6"))]

var myYelloBackgroundColorStringDummy: [MyYelloBackgroundColorStringDummy] =
        [MyYelloBackgroundColorStringDummy(backgroundColorTop: "6437FF",
                      backgroundColorBottom: "A892FF"),
         MyYelloBackgroundColorStringDummy(backgroundColorTop: "62DFAF",
                      backgroundColorBottom: "A5F475"),
         MyYelloBackgroundColorStringDummy(backgroundColorTop: "FF4D8D",
                      backgroundColorBottom: "FF7C7C"),
         MyYelloBackgroundColorStringDummy(backgroundColorTop: "1DD4ED",
                      backgroundColorBottom: "50D9C0"),
         MyYelloBackgroundColorStringDummy(backgroundColorTop: "E170F3",
                      backgroundColorBottom: "A892FF"),
         MyYelloBackgroundColorStringDummy(backgroundColorTop: "2E9AFE",
                      backgroundColorBottom: "02CBD8"),
         MyYelloBackgroundColorStringDummy(backgroundColorTop: "FE5B5B",
                      backgroundColorBottom: "F88B7C"),
         MyYelloBackgroundColorStringDummy(backgroundColorTop: "31E3C7",
                      backgroundColorBottom: "A5ECD7"),
         MyYelloBackgroundColorStringDummy(backgroundColorTop: "FF3062",
                      backgroundColorBottom: "FE584C"),
         MyYelloBackgroundColorStringDummy(backgroundColorTop: "6E6EEC",
                      backgroundColorBottom: "ECB2F6")]
