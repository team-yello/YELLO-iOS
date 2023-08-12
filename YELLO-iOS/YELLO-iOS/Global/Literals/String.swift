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
    
    enum Onboarding {
        static let selectHighText = "고등학생"
        static let selectUnivText = "대학생"
        static let selectFemaleText = "여자"
        static let selectMaleText = "남자"
        
        static let schoolSearchText = "학교가 어디인가요?"
        static let highSchoolSearchPlaceholder = "ex. 옐로고등학교"
        static let univSearchPlaceholder = "ex. 옐로대학교"
        static let selectLevelText = "몇 학년인가요?"
        static let selectClassText = "몇 반인가요?"
        static let selectClassPlaceholder = "ex. 1반"
        static let majorSearchText = "무슨 학과인가요?"
        static let majorSearchPlaceholder = "ex. 노랑학과"
        static let studentIdText = "몇 학번인가요?"
        static let studentIdPlaceholder = "ex. 23학번"
        
        static let nameHelper = "이름은 가입 후 바꿀 수 없으니 정확히 적어주세요!"
        static let nameError = "한글만 입력 가능해요."
        
        static let idTitle = "내가 사용할 아이디는?"
        static let idHelper = "인스타그램 아이디로 하면 친구들이 찾기 쉬워요!\n(최대 20자)"
        static let idPlaceholder = "yelloworld"
        static let idError = "문자, 숫자, 밑줄, 마침표만 사용할 수 있어요."
        
        static let idDuplicate = "이미 사용하고 있는 아이디에요."
        
        static let addFriendText = "친구를 추가하세요!"
        static let addFriendSubText = "친구가 많을수록 쪽지도 많이 받아요."
        
        static let recommandTitle = "추천인 코드"
        static let recommandSubTitle = "추천인의 아이디를 입력하면 +100 point!"
        static let recommandHelper = "추천인이 없다면 건너뛰어도 돼요."
        
        static let pushNotiText = "회원가입 끝! 알림을 드릴게요"
        static let pushNotiHelper = "친구들에게 비밀쪽지가 도착하면\n알림을 드릴게요."
        static let pushNotiButtonText = "알림 받기"
        
    }
    
    enum Inviting {
        static let title = "친구 초대하기"
        static let firstText = "친구가 내 추천인 코드로 가입하면"
        static let secondText = "40분 대기 초기화 + 100포인트 지급!"
        static let toastMessage = "링크가 복사되었습니다."
    }
    
    enum Recommending {
        enum Title {
            static let recommend = "추천친구"
            static let kakaoFriend = "카톡 친구들"
            static let schoolFriend = "학교 친구들"
            static let defaultProfileImageLink = "https://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg"
        }
        
        enum Empty {
            static let title = "지금 추천된 친구가 없어요!\n친구를 초대해볼까요?"
            static let inviteButton = "친구 초대하기"
        }
        
        enum Invite {
            static let invite = "친구 초대하기"
            static let inviteDescription = "찾는 친구가 없다면 친구를 초대해 보세요!"
        }
        
        enum Search {
            static let title = "친구 검색"
            static let placeholder = " 이름 또는 아이디를 입력해보세요!"
            static let myFriend = "내 친구"
            static let searching = "...친구를 찾는 중..."
        }
    }
    
    enum Around {
        static let around = "둘러보기"
        static let aroundDescription = "아직 구현되지 않은 기능이에요.\n조금만 기다려주세요!"
        static let female = "여학생"
        static let male = "남학생"
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
    
    enum MyYello {
        enum NavigationBar {
            static let myYello = "내 쪽지"
            static let yelloNumber = "받은 쪽지"
            static let shop = "상점"
        }
        
        enum Empty {
            static let title = "아직 쪽지가 온 게 없어요."
            static let description = "친구들이 나를 투표해주면 쪽지를 받을 수 있어요!"
        }
        
        enum List {
            static let maleTitle = "남학생이 보냄"
            static let femaleTitle = "여학생이 보냄"
            static let nameTitle = "님이 보냄"
            static let unlockButton = "누가 보냈는지 확인하기"
            static let keyButton = "누가 보냈는지 열어보기"
            static let toastMessage = "무슨 쪽지가 궁금한가요?"
        }
        
        enum Detail {
            static let sender = "???"
            static let send = "님이 보냄"
            static let female = "익명의 여학생"
            static let male = "익명의 남학생"
            static let instagram = "인스타그램 공유하기"
            static let keywordButton = "100포인트로 키워드 확인하기"
            static let sendButton = "300포인트로 초성 1개 확인하기"
            static let plusSendButton = "0포인트로 초성 1개 확인하기"
            static let senderButton = "누가 보냈는지 확인하기"
            static let logoTitle = "지금 누군가가 당신을 생각하고 있어요!"
            static let instagramID = "@yelloworld_official"
            static let findLabel = "보낸 사람을 알아냈어요!"
        }
        
        enum Alert {
            static let pointLack = "포인트가 부족해요!"
            static let myPoint = "내 포인트"
            static let point = "Point"
            static let yelloButton = "투표하고 포인트 받기"
            static let keywordPoint = " 포인트로 키워드를 얻을까요?"
            static let senderPoint = " 포인트로 초성을 얻을까요?"
            static let noButton = "아니요"
            static let keywordButton = "키워드 얻기"
            static let senderButton = "초성 얻기"
            static let keywordTitle = "쪽지의 키워드를 얻었어요!"
            static let senderTitle = "보낸 사람의 초성을 얻었어요!"
            static let senderDescription = "이름 중 랜덤으로 뽑은 초성이에요."
            static let afterPoint = "사용 후 포인트"
            static let confirmButton = "완료"
            static let useTicket = "열람권을 사용해서\n보낸 사람을 알아낼까요?"
            static let ticket = "열람권"
            static let count = "개"
            static let ticketButton = "이름 알아내기"
            static let getNameTitle = "보낸 사람의 이름을 얻었어요!"
            static let leftTicketCount = "남은 열람권"
        }
        
        enum Payment {
            static let title = "구독권 결제"
            static let description = "결제 기능은 아직 구현되지 않았어요.\n곧 기능을 준비할게요!"
            static let back = "나가기"
            static let paymentTitle = "옐로플러스로\n친구들의 속마음을 열어보세요!"
            static let paymentSender = "쪽지 보낸 사람을 알고 싶다면?"
            
            static let yelloPlusTitle = "옐로플러스의 특별한 혜택은?"
            static let subscribing = "옐로플러스 구독 중"
            static let yelloPlusSubscribe = "옐로플러스 구독하기"
            static let discount50Percent = "(50%할인)"
            static let yelloPlusPriceBefore = "7900원"
            static let yelloPlusPrice = "3900원"
            static let forWeek = "/주"
            
            static let nameKeyOne = "이름 열람권 1개"
            static let nameKeyOnePrice = "1400원"
            static let nameKeyTwo = "이름 열람권 2개"
            static let nameKeyTwoPrice = "2800원"
            static let nameKeyFive = "이름 열람권 5개"
            static let discount = "   할인!"
            static let nameKeyFivePriceBefore = "7000원"
            static let nameKeyFivePrice = "5900원"
            
            static let paymentAlertPlusTitle = "구독권을 얻었어요!"
            static let paymentAlertPlusDescription = "옐로플러스의 특별한 혜택을 마음껏 즐겨보세요."
            static let paymentAlertKeyOneTitle = "열람권 1개를 얻었어요!"
            static let paymentAlertKeyTwoTitle = "열람권 2개를 얻었어요!"
            static let paymentAlertKeyFiveTitle = "열람권 5개를 얻었어요!"
            static let paymentAlertKeyDescription = "열람권으로 누가 쪽지를 보냈는지 알아보세요."
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
            static let toastMessage = " 님과 친구 끊기를 완료했어요."
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
            static let caption = "계정 삭제 시 yell:o를 이용한 데이터는\n즉시 삭제되지 않고 30일간 보관됩니다.\n30일 이내에 로그인 시 데이터가 복구됩니다."
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
    
    enum PushAlarm {
        enum TypeName {
            static let available = "VOTE_AVAILABLE"
            static let newVote = "NEW_VOTE"
            static let newFriend = "NEW_FRIEND"
        }
    }
}
