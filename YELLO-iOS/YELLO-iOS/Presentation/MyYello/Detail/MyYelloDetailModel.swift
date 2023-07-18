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
    let data: MyYelloDetailResponseDTO
}

var MyYelloDetailModelDummy: [MyYelloDetailResponseDTO] = []


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
