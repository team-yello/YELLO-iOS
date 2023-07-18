//
//  VotingDummy.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/10.
//

import UIKit

struct VotingDummy {
    let yelloBalloon: UIImage
    let yelloProgress: UIImage
}

extension VotingDummy {
    static func dummy() -> [VotingDummy] {
        return [VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon1,
                            yelloProgress: ImageLiterals.Voting.imgFace1),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon2,
                            yelloProgress: ImageLiterals.Voting.imgFace2),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon3,
                            yelloProgress: ImageLiterals.Voting.imgFace3),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon4,
                            yelloProgress: ImageLiterals.Voting.imgFace4),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon5,
                            yelloProgress: ImageLiterals.Voting.imgFace5),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon6,
                            yelloProgress: ImageLiterals.Voting.imgFace6),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon7,
                            yelloProgress: ImageLiterals.Voting.imgFace7),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon8,
                            yelloProgress: ImageLiterals.Voting.imgFace8),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon9,
                            yelloProgress: ImageLiterals.Voting.imgFace9),
                VotingDummy(yelloBalloon: ImageLiterals.Voting.imgYelloBalloon10,
                            yelloProgress: ImageLiterals.Voting.imgFace10)]
    }
    
}
