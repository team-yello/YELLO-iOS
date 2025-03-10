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
            static let around = "타임라인"
            static let home = "옐로하기"
            static let myYello = "내 쪽지"
            static let profile = "프로필"
        }
    }
    
    enum Onboarding {
        enum KakaoLogin {
            static let titleText = "Yell:o에 오신 걸 환영해요!"
            static let subTitleText = "가입을 시작해볼까요?"
            static let startButtonText = "카카오로 시작하기"
            static let privacyButtonText = "개인정보처리방침"
        }
        
        enum KakaoConnect {
            static let titleText = "나의 옐로 친구는 어딨을까?"
            static let subTitleText = "친구 목록을 불러와봐요!"
            static let connectButton = "카카오톡 친구 연결하기"
        }
        
        enum CheckName {
            static let checkYesButton = "네, 맞아요"
            static let checkNoButton = "제 이름이 아니에요"
            static let checkTitle = "님이 맞으신가요?"
            static let nextButtonText = "수정 완료"
        }
        
        enum SchoolSelect {
            static let selectHighText = "중/고등학생"
            static let selectUnivText = "대학생"
        }
        
        enum Search {
            static let schoolSearchTitle = "우리 학교 검색하기"
            static let schoolHelperText = "우리 학교가 없나요? 학교를 추가해보세요!"
            static let majorSearchTitle = "학과 검색하기"
            static let majorHelperText = "찾는 과가 없다면 클릭하세요!"
        }
        
        enum School {
            static let schoolSearchText = "학교가 어디인가요?"
            static let highSchoolSearchPlaceholder = "ex. 옐로중/고등학교"
            static let univSearchPlaceholder = "ex. 옐로대학교"
            static let selectLevelText = "몇 학년인가요?"
            static let selectClassText = "몇 반인가요?"
            static let selectClassPlaceholder = "ex. 1반"
            static let majorSearchText = "무슨 학과인가요?"
            static let majorSearchPlaceholder = "ex. 노랑학과"
            static let studentIdText = "몇 학번인가요?"
            static let studentIdPlaceholder = "ex. 23학번"
            static let universityToastText = "학교를 먼저 선택해주세요"
        }
        
        enum Name {
            static let title = "나의 이름은?"
            static let namePlaceHolder = "ex.김옐로"
            static let nameHelper = "이후에는 이름 수정이 어려우니 실제 이름을 적어주세요."
            static let nameError = "한글만 입력 가능해요."
        }
        
        enum Id {
            static let idTitle = "내가 사용할 아이디는?"
            static let idHelper = "인스타그램 아이디로 하면 친구들이 찾기 쉬워요!\n(최대 20자)"
            static let idPlaceholder = "yelloworld"
            static let idError = "문자, 숫자, 밑줄, 마침표만 사용할 수 있어요."
            
            static let idDuplicate = "이미 사용하고 있는 아이디에요."
        }
        
        enum Friend {
            static let addFriendText = "친구를 추가하세요!"
            static let addFriendSubText = "친구가 많을수록 쪽지도 많이 받아요."
        }
        
        enum Recommand {
            static let recommandTitle = "추천인 코드"
            static let recommandSubTitle = "추천인의 아이디를 입력하면 +100 point!"
            static let recommandHelper = "추천인이 없다면 건너뛰어도 돼요."
        }
        
        enum Notification {
            static let pushNotiText = "띵동! 쪽지 도착"
            static let pushNotiHelper = "친구들에게 비밀쪽지가 도착하면\n알림을 드릴게요."
            static let pushNotiButtonText = "쪽지 알림 받기"
        }
        
        enum End {
            static let endingTitle = "가입 포인트 지급"
            static let endingText = "튜토리얼 끝!\n옐로에서 환영 선물을 준비했어요!"
            static let endingSubText = "앞으로 투표가 끝날 때마다 포인트를 줄게요!"
            static let endingButton = "옐로하러 가기"
        }
    }
    
    enum Tutorial {
        static let firstTutorialText = "친구가 4명 이상 모이면?\n옐로할 수 있어요!"
        static let firstGuideText = "아무데나 클릭해서 넘기기"
        
        static let secondTutorialText = "빈칸이 있는 랜덤한 질문에"
        
        static let thirdTutorialText = "친구와 키워드를 선택해요!"
        
        static let fourthToastText = "’이 질문 건너뛰기’ 버튼을 누르면\n포인트는 지급되지 않아요"
        static let fourthSubText = "다른 친구와 키워드를 선택하고 싶다면?"
        static let fourthTutorialText = "친구 선택지를 바꾸거나 질문을 skip"
    }
    
    enum Inviting {
        static let title = "친구 초대하기"
        static let firstText = "친구가 내 추천인 코드로 가입하면,"
        static let secondText = "40분 대기 초기화 + 100포인트"
        static let thirdText = "내 추천인 코드가 처음 쓰였다면?!"
        static let fourthText = "열람권 1개 추가 지급!"
        static let toastMessage = "링크가 복사되었습니다."
    }
    
    enum Recommending {
        enum Title {
            static let recommend = "추천친구"
            static let kakaoFriend = "카톡 친구들"
            static let schoolFriend = "학교 친구들"
            static let defaultProfileImageLink = "https://k.kakaocdn.net/dn/1G9kp/btsAot8liOn/8CWudi3uy07rvFNUkk3ER0/img_640x640.jpg"
        }
        
        enum Empty {
            static let title = "찾는 친구가 없다면\n친구를 초대해볼까요?"
            static let timeLineAllTitle = "친구들이 받은 쪽지가 궁금하다면\n친구를 초대해볼까요?"
            static let timeLineMyTitle = "전하고 싶은 말이 있는 친구에게\n쪽지를 보내 보세요!"
            static let inviteButton = "친구 초대하고 리워드 받기"
            static let myInviteButton = "지금 바로 쪽지 보내기"
        }
        
        enum Invite {
            static let invite = "친구 초대하기"
            static let inviteDescription = "찾는 친구가 없다면 친구를 초대해 보세요!"
        }
        
        enum Search {
            static let title = "친구 검색"
            static let placeholder = " 이름/학교/아이디로 검색해보세요!"
            static let myFriend = "내 친구"
            static let loading = "친구를 찾는 중이에요..."
            static let searching = "찾는 친구의 결과가 없어요."
        }
    }
    
    enum Around {
        static let around = "타임라인"
        static let aroundDescription = "아직 구현되지 않은 기능이에요.\n조금만 기다려주세요!"
        static let female = "여학생"
        static let male = "남학생"
        static let receiveFemale = "여학생에게 받음"
        static let receiveMale = "남학생에게 받음"
        static let info = "쪽지를 보낸 사람의 이름은 공개되지 않아요."
        static let allYello = "모든 쪽지"
        static let myYello = "내가 보낸 쪽지"
        static let fromMe = "나에게 받음"
        
    }
    
    enum Voting {
        enum Locked {
            static let title = "옐로를 시작하고 싶다면?"
            static let text = "친구가 1명 이상 있어야 투표할 수 있어요.\n친구들을 초대해볼까요?"
            static let button = "친구 초대하고 옐로 시작하기"
        }
        
        enum Start {
            static let title = "누구에게 어떤 메세지를 보낼까?"
            static let myPoint = "내 포인트"
        }
        
        enum ProgressLottie {
            static let one = "pagenation_1"
            static let two = "pagenation_2"
            static let three = "pagenation_3"
            static let four = "pagenation_4"
            static let five = "pagenation_5"
            static let six = "pagenation_6"
            static let seven = "pagenation_7"
            static let eight = "pagenation_8"
        }
        
        enum VoteToast {
            static let skip = "한 번 선택하면 건너뛸 수 없어요."
            static let cancel = "한 번 선택하면 취소할 수 없어요."
            static let suffle = "이름을 선택하면 셔플을 사용할 수 없어요."
            static let moreFriend = "4명 이상의 친구를 가지면 선택지가 채워져요."
        }
        
        enum Vote {
            static let plusFriend = "친구를 추가해주세요!"
        }
        
        enum Point {
            static let yelloButtonText = "확인"
            static let cancelButtonText = "그냥 받기"
            static let rewardAdButtonText = "광고보고 2배로 받기"
            static let title = "투표 포인트 적립!"
            static let adTitle = "광고보고 2배로 받기"
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
            static let clickMe = "CLICK ME"
            static let yelloNumber = "받은 쪽지"
            static let shop = "상점"
            static let sale = "SALE"
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
            static let instagram = "스토리 공유"
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
            static let paymentSender = "쪽지를 열고 싶다면?"
            
            static let yelloPlusTitle = "옐로플러스의 특별한 혜택은?"
            static let subscribing = "구독 중"
            static let yelloPlusSubscribe = "옐로플러스 구독하기"
            static let discount50Percent = "(63%할인)"
            static let yelloPlusPriceBefore = "7900원"
            static let yelloPlusPrice = "2900원"
            static let forWeek = "/주"
            
            static let sale = "SALE!"
            static let nameKeyOne = "이름 열람권\n1개"
            static let nameKeyOnePrice = " "
            static let nameKeyOneSalePrice = "1400원"
            static let nameKeyTwo = "이름 열람권\n2개"
            static let nameKeyTwoPrice = "개당 950원"
            static let nameKeyTwoSalePrice = "1900원"
            static let nameKeyFive = "이름 열람권\n5개"
            static let discount = "할인!"
            static let nameKeyFivePriceBefore = "개당 780원"
            static let nameKeyFivePrice = "3900원"
            
            static let paymentAlertPlusTitle = "구독권을 얻었어요!"
            static let paymentAlertPlusDescription = "옐로플러스의 특별한 혜택을 마음껏 즐겨보세요."
            static let paymentAlertKeyOneTitle = "열람권 1개를 얻었어요!"
            static let paymentAlertKeyTwoTitle = "열람권 2개를 얻었어요!"
            static let paymentAlertKeyFiveTitle = "열람권 5개를 얻었어요!"
            static let paymentAlertKeyDescription = "열람권으로 누가 쪽지를 보냈는지 알아보세요."
            
            static let votingPointTitle = "투표하고 포인트 얻기"
            static let votingPoint = "최대 400p"
            static let adPointTitle = "광고 보고 무료 포인트 얻기"
            static let adPointsubTitle = "1시간에 한 번"
            static let adPoint = "10p"
            static let adPointErrorToast = "1시간에 한 번 재생할 수 있어요."
            
            static let descriptionLabel = "옐로플러스 구독안내\n- 구독은 매주 자동으로 갱신되며, Apple을 통해 해지하실 수 있습니다.\n- 결제를 진행하시면 관련 약관에 동의하는 것으로 간주됩니다."
            static let serviceButton = "서비스 이용 약관"
            static let privacyButton = "개인정보처리방침"
            
            static let fix = "페이지를 개선 중이에요!\n조금만 기다려 주세요"
        }
    }
    
    enum Profile {
        enum NavigationBar {
            static let profile = "프로필"
            static let setting = "설정"
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
            static let empty = "아직 친구가 없네요, 친구를 초대해 보세요!"
        }
        
        enum EditProfile {
            static let KakaoDefaultProfileURL = "https://k.kakaocdn.net/dn/1G9kp/btsAot8liOn/8CWudi3uy07rvFNUkk3ER0/img_640x640.jpg"
            static let profileInfoTitle = "프로필 정보"
            static let kakaoSync = "카카오톡 동기화"
            static let name = "이름"
            static let id = "아이디"
            static let school = "학교"
            static let major = "학과"
            static let studentId = "학번"
            static let grade = "학년"
            static let schoolClass = "반"
            static let defaultText = "-"
            
            static let profileEditTitle = "프로필 수정"
            static let guideText = "1년에 한 번만 수정할 수 있어요.\n신중히 수정해 주세요!"
            static let modifireDateText = "마지막 수정일 : "
            static let majorErrorMessage = "학과를 입력해야 수정할 수 있어요."
            static let editDateErrorMessage = "올해 안에 수정한 기록이 있어요."
            static let notYetErrorMessage = "수정할 정보가 없어요"
            
            static let saveButton = "저장"
            static let convertHighButton = "중/고등학생으로 전환"
            static let convertUnivButton = "대학생으로 전환"
            
            static let editCheckTitle = "올해 안에 한 번만 수정할 수 있어요.\n정말 변경하실 건가요?"
            static let noButton = "아니요"
            static let yesButton = "변경할게요"
        }
        
        enum Setting {
            static let setting = "설정"
            static let center = "고객센터"
            static let privacy = "개인정보 처리방침"
            static let service = "이용약관"
            static let logout = "로그아웃"
            static let version = "버전 "
            static let withdrawal = "계정 탈퇴"
        }
        
        enum Withdrawal {
            static let withdrawal = "계정 탈퇴"
            static let title = "탈퇴 주의사항이 있어요"
            static let description = "지금 계정을 탈퇴하시면\n아래의 데이터 및 엑세스 권한을 전부 잃게 돼요."
            static let warningTitle = "주의! 포인트 사라짐!"
            static let warningDescription = "다시 로그인을 하더라도,\n그동안 어렵게 모은 포인트는 영원히 사라져요."
            static let first = "회원님을 좋아하는 친구의\n마음을 알 수 없어요."
            static let second = "회원님의 마음을 친구에게\n전달할 수 없어요."
            static let third = "친구들이 받은 쪽지를 볼 수 없어요."
            static let keep = "그래도 계속하기"
            static let back = "다시 돌아가기"
        }
        
        enum WithdrawalCheck {
            static let withdrawal = "계정 탈퇴"
            static let title = "정말 계정을 삭제할 건가요?"
            static let description = "회원님을 떠올리는 친구들이 슬퍼할 거에요.\n잠시 쉬다 돌아오는 것은 어떤가요?"
            static let caption = "계정 삭제 시 yell:o를 이용한 데이터는\n즉시 삭제되지 않고 30일간 보관됩니다.\n30일 이내에 로그인 시 데이터가 복구됩니다."
            static let confirm = "탈퇴하기"
        }
        
        enum WithdrawalAlert {
            static let title = "정말 탈퇴하시겠습니까?"
            static let no = "아니요"
            static let yes = "네, 탈퇴합니다"
        }
        
        enum WithdrawalNoFriend {
            static let title = "친구가 없다면\n친구를 초대할 수도 있어요."
            static let nextLabel = "다음에 할게요"
            static let wowLabel = "오, 그런 방법이!"
        }
        
        enum WithdrawalReason {
            static let title = "탈퇴 사유를 적어주세요."
            static let nobody = "앱에 아는 친구들이 없어서"
            static let expensive = "구독권과 열람권의 가격이 비싸서"
            static let error = "오류가 많아서"
            static let notFunny = "재밌는 콘텐츠 또는 질문이 없어서"
            static let lessPoint = "포인트를 너무 적게 줘서"
            static let delete = "내 정보를 삭제하고 싶어서"
            static let otherApp = "다른 앱이 더 재밌어서"
            static let etc = "기타"
            static let etcReason = "사유를 적어주세요.(최대 30자)"
            static let complete = "완료"
        }
    }
    
    enum PushAlarm {
        enum TypeName {
            static let available = "VOTE_AVAILABLE"
            static let newVote = "NEW_VOTE"
            static let newFriend = "NEW_FRIEND"
            static let recommend = "RECOMMEND"
            static let firstRecommend = "FIRST_RECOMMEND"
            static let openVote = "OPEN_VOTE"
            static let lunchEvent = "LUNCH_EVENT"
        }
    }
    
    enum SubscriptionExtension {
        static let titleLabel = "곧 옐로플러스의\n특별한 혜택을 잃게 돼요"
        static let dateOfTerminationLabel = "에 만료 예정인"
        static let unsubscribeLabel = "옐로플러스의 구독을 해지했어요."
        static let benefitLabel = "곧 위와 같은 혜택을 누릴 수 없게 돼요.\n\n옐로플러스의 특별한 서비스를\n계속 이용하시려면, 버튼을 눌러\n구독을 계속해 보세요!"
    }
    
    enum Notification {
        static let doNotSeeAgainLabel = "오늘 하루 보지 않기"
        static let close = "닫기"
    }
    
    enum Event {
        static let eventTime = "EVENT TIME"
        static let present = "점심시간 깜짝 선물!"
        static let time = "평일 12~14시 최대 1회까지 참여 가능"
        static let touch = "어떤 게 나올까요? 아래 박스를 터치해보세요!"
        static let point = "포인트를 얻었어요!"
        static let nextTime = "다음 점심 시간에 또 만나요!"
        static let ticket = "열람권 1개를 얻었어요!"
    }
    
    enum Reward {
        static let admobReward = "ADMOB_POINT"
        static let admobMultipleReward = "ADMOB_MULTIPLE_POINT"
        static let fix = "FIXED"
        static let random = "ADMOB_RANDOM"
    }
}
