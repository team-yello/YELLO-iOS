//
//  VotingDummy.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/10.
//

import UIKit

struct VotingDummy {
    let yelloBalloon: String
    let yelloProgress: UIImage
}

extension VotingDummy {
    static func dummy() -> [VotingDummy] {
        return [VotingDummy(yelloBalloon: StringLiterals.Voting.ProgressLottie.one,
                            yelloProgress: ImageLiterals.Voting.imgFace1),
                VotingDummy(yelloBalloon: StringLiterals.Voting.ProgressLottie.two,
                            yelloProgress: ImageLiterals.Voting.imgFace2),
                VotingDummy(yelloBalloon: StringLiterals.Voting.ProgressLottie.three,
                            yelloProgress: ImageLiterals.Voting.imgFace3),
                VotingDummy(yelloBalloon: StringLiterals.Voting.ProgressLottie.four,
                            yelloProgress: ImageLiterals.Voting.imgFace4),
                VotingDummy(yelloBalloon: StringLiterals.Voting.ProgressLottie.five,
                            yelloProgress: ImageLiterals.Voting.imgFace5),
                VotingDummy(yelloBalloon: StringLiterals.Voting.ProgressLottie.six,
                            yelloProgress: ImageLiterals.Voting.imgFace6),
                VotingDummy(yelloBalloon: StringLiterals.Voting.ProgressLottie.seven,
                            yelloProgress: ImageLiterals.Voting.imgFace7),
                VotingDummy(yelloBalloon: StringLiterals.Voting.ProgressLottie.eight,
                            yelloProgress: ImageLiterals.Voting.imgFace8)]
    }
}
