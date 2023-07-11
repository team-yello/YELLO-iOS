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
    
    enum Inviting {
        static let lockedTitle = "친구 초대하고 투표 시작하기"
        static let lockedText = "친구가 4명 이상 모이면\n투표를 시작할 수 있어요!"
        static let unLockedTitle = "친구 초대하고 기다리지 않기"
        static let unLockedText = "친구가 내 추천인 코드로 가입하면\n기다리지 않고 바로 투표할 수 있어요!"
    }
    
    enum Recommending {
        enum Title {
            static let recommend = "추천친구"
            static let kakaoFriend = "카톡 친구들"
            static let schoolFriend = "학교 친구들"
        }
    }
    
    enum Around {
        static let around = "둘러보기"
        static let aroundDescription = "아직 구현되지 않은 기능이에요.\n조금만 기다려주세요!"
    }
    
    enum Voting {
        enum Locked {
            static let title = "투표를 시작할 수 없어요"
            static let text = "친구가 4명 이상 모이면 투표할 수 있어요.\n친구들을 초대해볼까요?"
        }
        enum Start {
            static let title = "누구에게 어떤 메세지를 보낼까?"
            static let myPoint = "내 포인트"
        }
        
        enum VoteName {
            static let one = "김효원\n@kev_hy1042"
            static let two = "권세훈\n@hj__p_"
            static let three = "이강민\n@_euije"
            static let four = "이의제\n@nahyunyou"
        }
        
        enum VoteKeyword {
            static let one = "99대장 나선욱이랑"
            static let two = "skkr하는 송민호랑"
            static let three = "범죄도시 손석구랑"
            static let four = "코딩하는 강동원이랑"
        }
        
        enum VoteToast {
            static let skip = "한 번 선택하면 건너뛸 수 없어요."
            static let cancel = "한 번 선택하면 취소할 수 없어요."
            static let suffle = "이름을 선택하면 셔플을 사용할 수 없어요."
        }
        
        enum Point {
            static let title = "투표 포인트 적립!"
            static let text = "투표로 포인트를 모아 쪽지를 열어보세요."
        }
        
        enum Timer {
            static let title = "다음 투표까지 남은 시간"
            static let text = "시간이 지나면 다시 투표할 수 있어요!"
        }
    }
    
}
