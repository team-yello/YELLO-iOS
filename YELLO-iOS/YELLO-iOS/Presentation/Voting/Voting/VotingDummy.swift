//
//  VotingDummy.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/10.
//

import UIKit

struct VotingDummy {
    let yelloBalloon: UIImage
}

extension VotingDummy {
    static func dummy() -> [VotingDummy] {
        return [VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon1),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon2),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon3),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon4),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon5),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon6),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon7),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon8),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon9),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon10)]
    }
}
