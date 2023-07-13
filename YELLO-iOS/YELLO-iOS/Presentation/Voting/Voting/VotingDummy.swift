//
//  VotingDummy.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/10.
//

import UIKit

struct VotingDummy {
    let backgroundColorTop: UIColor
    let backgroundColorBottom: UIColor
    let yelloBalloon: UIImage
    let yelloProgress: UIImage
}

extension VotingDummy {
    static func dummy() -> [VotingDummy] {
        return [VotingDummy(backgroundColorTop: UIColor(hex: BackGroundColor.BackgroundColorTop.one),
                            backgroundColorBottom: UIColor(hex: BackGroundColor.BackgroundColorBottom.one),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon1,
                            yelloProgress: ImageLiterals.Voting.imgFace1),
                VotingDummy(backgroundColorTop: UIColor(hex: BackGroundColor.BackgroundColorTop.two),
                            backgroundColorBottom: UIColor(hex: BackGroundColor.BackgroundColorBottom.two),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon2,
                            yelloProgress: ImageLiterals.Voting.imgFace2),
                VotingDummy(backgroundColorTop: UIColor(hex: BackGroundColor.BackgroundColorTop.three),
                            backgroundColorBottom: UIColor(hex: BackGroundColor.BackgroundColorBottom.three),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon3,
                            yelloProgress: ImageLiterals.Voting.imgFace3),
                VotingDummy(backgroundColorTop: UIColor(hex: BackGroundColor.BackgroundColorTop.four),
                            backgroundColorBottom: UIColor(hex: BackGroundColor.BackgroundColorBottom.four),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon4,
                            yelloProgress: ImageLiterals.Voting.imgFace4),
                VotingDummy(backgroundColorTop: UIColor(hex: BackGroundColor.BackgroundColorTop.five),
                            backgroundColorBottom: UIColor(hex: BackGroundColor.BackgroundColorBottom.five),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon5,
                            yelloProgress: ImageLiterals.Voting.imgFace5),
                VotingDummy(backgroundColorTop: UIColor(hex: BackGroundColor.BackgroundColorTop.six),
                            backgroundColorBottom: UIColor(hex: BackGroundColor.BackgroundColorBottom.six),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon6,
                            yelloProgress: ImageLiterals.Voting.imgFace6),
                VotingDummy(backgroundColorTop: UIColor(hex: BackGroundColor.BackgroundColorTop.seven),
                            backgroundColorBottom: UIColor(hex: BackGroundColor.BackgroundColorBottom.seven),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon7,
                            yelloProgress: ImageLiterals.Voting.imgFace7),
                VotingDummy(backgroundColorTop: UIColor(hex: BackGroundColor.BackgroundColorTop.eight),
                            backgroundColorBottom: UIColor(hex: BackGroundColor.BackgroundColorBottom.eight),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon8,
                            yelloProgress: ImageLiterals.Voting.imgFace8),
                VotingDummy(backgroundColorTop: UIColor(hex: BackGroundColor.BackgroundColorTop.nine),
                            backgroundColorBottom: UIColor(hex: BackGroundColor.BackgroundColorBottom.nine),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon9,
                            yelloProgress: ImageLiterals.Voting.imgFace9),
                VotingDummy(backgroundColorTop: UIColor(hex: BackGroundColor.BackgroundColorTop.ten),
                            backgroundColorBottom: UIColor(hex: BackGroundColor.BackgroundColorBottom.ten),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon10,
                            yelloProgress: ImageLiterals.Voting.imgFace10)]
    }
    
}
