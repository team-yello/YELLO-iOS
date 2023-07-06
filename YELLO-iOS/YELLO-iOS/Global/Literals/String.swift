//
//  String.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import Foundation

enum StringLiterals {

    enum TabBar {
        enum ItemTitle {
            static let recommend = "추천친구"
            static let around = "둘러보기"
            static let home = "옐로하기"
            static let myYello = "내 쪽지"
            static let profile = "프로필"
        }
    }
    
    enum Around {
        static let around = "둘러보기"
        static let aroundDescription = "아직 구현되지 않은 기능이에요.\n조금만 기다려주세요!"
    }
    
    enum Voting {
        enum Locked {
            static let white = "투표를 시작할 수 없어요"
            static let gray = "친구가 4명 이상 모이면 투표할 수 있어요.\n친구들을 초대해볼까요?"
        }
    }
    
}
