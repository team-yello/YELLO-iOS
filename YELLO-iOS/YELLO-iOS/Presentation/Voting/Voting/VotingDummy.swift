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
        return [VotingDummy(backgroundColorTop: UIColor(hex: "6437FF"),
                            backgroundColorBottom: UIColor(hex: "A892FF"),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon1,
                            yelloProgress: ImageLiterals.Voting.imgFace1),
                VotingDummy(backgroundColorTop: UIColor(hex: "62DFAF"),
                            backgroundColorBottom: UIColor(hex: "A5F475"),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon2,
                            yelloProgress: ImageLiterals.Voting.imgFace2),
                VotingDummy(backgroundColorTop: UIColor(hex: "FF4D8D"),
                            backgroundColorBottom: UIColor(hex: "FF7C7C"),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon3,
                            yelloProgress: ImageLiterals.Voting.imgFace3),
                VotingDummy(backgroundColorTop: UIColor(hex: "1DD4ED"),
                            backgroundColorBottom: UIColor(hex: "50D9C0"),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon4,
                            yelloProgress: ImageLiterals.Voting.imgFace4),
                VotingDummy(backgroundColorTop: UIColor(hex: "E170F3"),
                            backgroundColorBottom: UIColor(hex: "A892FF"),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon5,
                            yelloProgress: ImageLiterals.Voting.imgFace5),
                VotingDummy(backgroundColorTop: UIColor(hex: "2E9AFE"),
                            backgroundColorBottom: UIColor(hex: "02CBD8"),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon6,
                            yelloProgress: ImageLiterals.Voting.imgFace6),
                VotingDummy(backgroundColorTop: UIColor(hex: "FE5B5B"),
                            backgroundColorBottom: UIColor(hex: "F88B7C"),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon7,
                            yelloProgress: ImageLiterals.Voting.imgFace7),
                VotingDummy(backgroundColorTop: UIColor(hex: "31E3C7"),
                            backgroundColorBottom: UIColor(hex: "A5ECD7"),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon8,
                            yelloProgress: ImageLiterals.Voting.imgFace8),
                VotingDummy(backgroundColorTop: UIColor(hex: "FF3062"),
                            backgroundColorBottom: UIColor(hex: "FE584C"),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon9,
                            yelloProgress: ImageLiterals.Voting.imgFace9),
                VotingDummy(backgroundColorTop: UIColor(hex: "6E6EEC"),
                            backgroundColorBottom: UIColor(hex: "ECB2F6"),
                            yelloBalloon: ImageLiterals.Voting.imgYelloBalloon10,
                            yelloProgress: ImageLiterals.Voting.imgFace10)]
    }
    
}
