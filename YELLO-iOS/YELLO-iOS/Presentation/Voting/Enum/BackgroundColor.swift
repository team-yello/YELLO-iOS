//
//  BackgroundColor.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/12.
//

import UIKit

enum BackGroundColor {
    enum BackgroundColorTop {
        static let one = "6437FF"
        static let two = "62DFAF"
        static let three = "FF4D8D"
        static let four = "1DD4ED"
        static let five = "E170F3"
        static let six = "2E9AFE"
        static let seven = "FE5B5B"
        static let eight = "31E3C7"
        static let nine = "FF3062"
        static let ten = "6E6EEC"
        static let eleven = "1B8CFF"
        static let tweleve = "EF318B"
    }
    
    enum BackgroundColorBottom {
        static let one = "A892FF"
        static let two = "A5F475"
        static let three = "FF7C7C"
        static let four = "50D9C0"
        static let five = "A892FF"
        static let six = "02CBD8"
        static let seven = "F88B7C"
        static let eight = "A5ECD7"
        static let nine = "FE584C"
        static let ten = "ECB2F6"
        static let eleven = "A1CFFF"
        static let tweleve = "FF7CBB"
    }
}

func selectTopColors(startIndex: Int) -> [String] {
    let allColors = [
        BackGroundColor.BackgroundColorTop.one,
        BackGroundColor.BackgroundColorTop.two,
        BackGroundColor.BackgroundColorTop.three,
        BackGroundColor.BackgroundColorTop.four,
        BackGroundColor.BackgroundColorTop.five,
        BackGroundColor.BackgroundColorTop.six,
        BackGroundColor.BackgroundColorTop.seven,
        BackGroundColor.BackgroundColorTop.eight,
        BackGroundColor.BackgroundColorTop.nine,
        BackGroundColor.BackgroundColorTop.ten,
        BackGroundColor.BackgroundColorTop.eleven,
        BackGroundColor.BackgroundColorTop.tweleve
    ]
    
    var selectedColors: [String]
    
    if startIndex <= 2 {
        let endIndex = startIndex + 9
        selectedColors = Array(allColors[startIndex...endIndex])
    } else {
        let endIndex = startIndex - 3
        selectedColors = Array(allColors[startIndex...] + allColors[0...endIndex])
    }
    
    return selectedColors
}

func selectBottomColors(startIndex: Int) -> [String] {
    let allColors = [
        BackGroundColor.BackgroundColorBottom.one,
        BackGroundColor.BackgroundColorBottom.two,
        BackGroundColor.BackgroundColorBottom.three,
        BackGroundColor.BackgroundColorBottom.four,
        BackGroundColor.BackgroundColorBottom.five,
        BackGroundColor.BackgroundColorBottom.six,
        BackGroundColor.BackgroundColorBottom.seven,
        BackGroundColor.BackgroundColorBottom.eight,
        BackGroundColor.BackgroundColorBottom.nine,
        BackGroundColor.BackgroundColorBottom.ten,
        BackGroundColor.BackgroundColorBottom.eleven,
        BackGroundColor.BackgroundColorBottom.tweleve
    ]
    
    var selectedColors: [String]
    
    if startIndex <= 2 {
        let endIndex = startIndex + 9
        selectedColors = Array(allColors[startIndex...endIndex])
    } else {
        let endIndex = startIndex - 3
        selectedColors = Array(allColors[startIndex...] + allColors[0...endIndex])
    }
    
    return selectedColors
}

class Color {
    
    var startIndex = 0
    var selectedTopColors: [String] = []
    var selectedBottomColors: [String] = []

    static let shared = Color()
    
    private init() {}
}
