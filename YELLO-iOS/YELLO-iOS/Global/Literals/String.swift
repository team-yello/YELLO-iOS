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
        static let recommendTitle  = "친구 초대하기"
        static let recommendText = "찾는 친구가 없다면 친구를 초대해 보세요!\n함께 옐로할 수 있어요."
    }
    
    enum Recommending {
        enum Title {
            static let recommend = "추천친구"
            static let kakaoFriend = "카톡 친구들"
            static let schoolFriend = "학교 친구들"
        }
        
        enum Empty {
            static let title = "지금 추천된 친구가 없어요!\n친구를 초대해볼까요?"
            static let inviteButton = "친구 초대하기"
        }
        
        enum Invite {
            static let invite = "친구 초대하기"
            static let inviteDescription = "찾는 친구가 없다면 친구를 초대해 보세요!"
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
            static let two = "박현정\n@hj__p_"
            static let three = "이의제\n@_euije"
            static let four = "김나현\n@nahyunyou"
            static let five = "김상호\n@sangho.kk"
            static let six = "권세훈\n@sehoonq"
            static let seven = "변희주\n@hj_byunn"
            static let eight = "이강민\n@k.mean.e"
            static let nine = "박민주\n@filminju_"
            static let ten = "여민서\n@minseo_mx"
            static let eleven = "전채연\n@chae.yeon1004"
            static let twelve = "정채은\n@chaentopia"
            static let thirteen = "이지희\n@9.ysaeee29"
            static let fourteen = "강국희\n@kangcookie"
            
            static func getRandomName() -> String? {
                let names = [one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen]
                return names.randomElement()
            }
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
        
        enum Friend {
            static let message = "받은 쪽지"
            static let friendNumber = "친구 수"
            static let delete = "친구 끊기"
            static let description = "정말로 친구를 끊으실 건가요?"
            static let cancel = "취소"
            static let confirm = "네, 친구를 끊을게요"
        }
        
        enum Setting {
            static let setting = "프로필 관리"
            static let center = "고객센터"
            static let privacy = "개인정보 처리방침"
            static let service = "이용약관"
            static let logout = "로그아웃"
            static let version = "버전 1.0"
            static let withdrawal = "계정 탈퇴"
        }
        
        enum Withdrawal {
            static let withdrawal = "계정 탈퇴"
            static let title = "이러한 기능을 사용하지 못하게 돼요"
            static let description = "지금 계정을 탈퇴하시면\n이와 같은 데이터 및 엑세스 권한을 전부 잃게 됩니다."
            static let first = "회원님의 좋아하는 친구 마음을 알 수 없어요."
            static let second = "회원님의 마음을 친구에게 전달할 수 없어요."
            static let third = "친구들이 받은 쪽지를 볼 수 없어요."
            static let caption = "계정 삭세 시 yell:o를 이용한 데이터는\n즉시 삭제되지 않고 30일간 보관됩니다.\n30일 이내에 로그인 시 데이터가 복구됩니다."
            static let confirm = "탈퇴하기"
        }
        
        enum WithdrawalCheck {
            static let withdrawal = "계정 탈퇴"
            static let title = "정말 계정을 삭제할 건가요?"
            static let description = "회원님을 떠올리는 친구들이 슬퍼할 거에요.\n잠시 쉬다 돌아오는 것은 어떤가요?"
            static let keep = "그래도 계속하기"
            static let back = "다시 돌아가기"
        }
        
        enum WithdrawalAlert {
            static let title = "정말 탈퇴하시겠습니까?"
            static let no = "아니요"
            static let yes = "네, 탈퇴합니다"
        }
    }
}
