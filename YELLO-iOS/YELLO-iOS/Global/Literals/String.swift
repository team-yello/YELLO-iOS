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
        
        enum Point {
            static let title = "투표 포인트 적립!"
            static let text = "투표로 포인트를 모아 쪽지를 열어보세요."
        }
        
        enum Timer {
            static let title = "다음 투표까지 남은 시간"
            static let text = "시간이 지나면 다시 투표할 수 있어요!"
        }
    }
    
    enum Profile {
        enum NavigationBar {
            static let profile = "프로필"
            static let setting = "관리"
        }
        
        enum Count {
            static let message = "받은 쪽지"
            static let friend = "내 친구 수"
            static let point = "내 포인트"
        }
        
        enum MyProfile {
            static let addGroup = "그룹 추가"
        }
        
        enum FriendCount {
            static let myFriend = "내 친구들"
            static let friendNumber = "친구 수"
        }
        
        enum Setting {
            static let setting = "프로필 관리"
            static let center = "고객 센터"
            static let privacy = "개인정보 처리방침"
            static let service = "이용약관"
            static let logout = "로그아웃"
            static let version = "버전 1.0"
            static let withdrawal = "탈퇴"
        }
    }
}
