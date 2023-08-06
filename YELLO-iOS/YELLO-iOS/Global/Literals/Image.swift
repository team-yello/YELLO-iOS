//
//  Image.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import UIKit

enum ImageLiterals {
    enum Splash {
        static var splashYelloFace: UIImage { .load(named: "SplashYelloFace")}
    }
    enum OnBoarding {
        static var addFriends: UIImage { .load(named: "addFriends")}
        static var onboardingStart: UIImage { .load(named: "OnboardingStart")}
        static var icAlertCircle: UIImage { .load(named: "icAlertCircle")}
        
        static var icArrowLeft: UIImage { .load(named: "icArrowLeft").withTintColor(.white, renderingMode: .alwaysOriginal)}
        static var icChevronDown: UIImage { .load(named: "icChevronDown").withTintColor(.grayscales500, renderingMode: .alwaysOriginal) }
        static var icSearch: UIImage { .load(named: "icSearch").withTintColor(.grayscales500, renderingMode: .alwaysOriginal) }
        static var icX: UIImage { .load(named: "icX") }
        static var icYelloFace: UIImage { .load(named: "icYelloFace") }
        static var btnKakaoLogin: UIImage { .load(named: "btnKakaoLogin")}
        static var icXCircle: UIImage { .load(named: "icXCircle")}
        static var icCheckCircleYello: UIImage { .load(named: "icCheckCircleYello")}
        static var icCheckCircleEnable: UIImage { .load(named: "icCheckCircleEnable")}
        static var icCheckCircleFemale: UIImage { .load(named: "icCheckCircleFemale")}
        static var icCheckCircleMale: UIImage { .load(named: "icCheckCircleMale")}
        static var icCheckCircleGender: UIImage { .load(named: "icCheckCircleGender")}
        static var icYelloFaceMale: UIImage { .load(named: "icYelloFaceMale")}
        static var icYelloFaceFemale: UIImage { .load(named: "icYelloFaceFemale")}
        static var icCheck: UIImage { .load(named: "icCheck")}
    }
    
    enum TabBar {
        // not-Selected
        static var icPlusFriend: UIImage { .load(named: "icPlusFriend") }
        static var icFriendYello: UIImage { .load(named: "icFriendYello") }
        static var icHome: UIImage { .load(named: "icHome") }
        static var icMyYello: UIImage { .load(named: "icMyYello") }
        static var icProfile: UIImage { .load(named: "icProfile") }
        
        // selected
        static var icPlusFriendSelected: UIImage { .load(named: "icPlusFriendSelected") }
        static var icFriendYelloSelected: UIImage { .load(named: "icFriendYelloSelected") }
        static var icHomeSelected: UIImage { .load(named: "icHomeSelected") }
        static var icMyYelloSelected: UIImage { .load(named: "icMyYelloSelected") }
        static var icProfileSelected: UIImage { .load(named: "icProfileSelected") }
    }
    
    enum InvitingPopUp {
        static var icClose: UIImage { .load(named: "icClose") }
        static var icKakaoShare: UIImage { .load(named: "icKakaoShare") }
        static var icLinkCopy: UIImage { .load(named: "icLinkCopy") }
    }
    
    enum Voting {
        static var icPoint: UIImage { .load(named: "icPoint") }
        static var lbSpeechBubble: UIImage { .load(named: "lbSpeechBubble") }
        static var imgTimerViewBackground: UIImage { .load(named: "imgTimerViewBackground")}
        static var imgTimerBackground: UIImage { .load(named: "imgTimerBackground")}
        static var imgYelloBalloon1: UIImage { .load(named: "imgYelloBalloon1")}
        static var imgYelloBalloon2: UIImage { .load(named: "imgYelloBalloon2")}
        static var imgYelloBalloon3: UIImage { .load(named: "imgYelloBalloon3")}
        static var imgYelloBalloon4: UIImage { .load(named: "imgYelloBalloon4")}
        static var imgYelloBalloon5: UIImage { .load(named: "imgYelloBalloon5")}
        static var imgYelloBalloon6: UIImage { .load(named: "imgYelloBalloon6")}
        static var imgYelloBalloon7: UIImage { .load(named: "imgYelloBalloon7")}
        static var imgYelloBalloon8: UIImage { .load(named: "imgYelloBalloon8")}
        static var imgYelloBalloon9: UIImage { .load(named: "imgYelloBalloon9")}
        static var imgYelloBalloon10: UIImage { .load(named: "imgYelloBalloon10")}
        static var imgFace1: UIImage { .load(named: "imgFace1")}
        static var imgFace2: UIImage { .load(named: "imgFace2")}
        static var imgFace3: UIImage { .load(named: "imgFace3")}
        static var imgFace4: UIImage { .load(named: "imgFace4")}
        static var imgFace5: UIImage { .load(named: "imgFace5")}
        static var imgFace6: UIImage { .load(named: "imgFace6")}
        static var imgFace7: UIImage { .load(named: "imgFace7")}
        static var imgFace8: UIImage { .load(named: "imgFace8")}
        static var imgFace9: UIImage { .load(named: "imgFace9")}
        static var imgFace10: UIImage { .load(named: "imgFace10")}
        static var icShuffle: UIImage { .load(named: "icShuffle")}
        static var icSuffleLocked: UIImage { .load(named: "icSuffleLocked")}
        static var icSkip: UIImage { .load(named: "icSkip")}
        static var icSkipLocked: UIImage { .load(named: "icSkipLocked")}
        static var imgProgress1: UIImage { .load(named: "imgProgress1")}
        static var imgProgress2: UIImage { .load(named: "imgProgress2")}
        static var imgProgress3: UIImage { .load(named: "imgProgress3")}
        static var imgProgress4: UIImage { .load(named: "imgProgress4")}
        static var imgProgress5: UIImage { .load(named: "imgProgress5")}
        static var imgProgress6: UIImage { .load(named: "imgProgress6")}
        static var imgProgress7: UIImage { .load(named: "imgProgress7")}
        static var imgProgress8: UIImage { .load(named: "imgProgress8")}
        static var imgProgress9: UIImage { .load(named: "imgProgress9")}
        static var imgProgress10: UIImage { .load(named: "imgProgress10")}
        static var imgPointAccumulate: UIImage { .load(named: "imgPointAccumulate")}
        static var imgVotingLocked: UIImage { .load(named: "imgVotingLocked")}

    }
    
    enum Around {
        static var imgAround: UIImage { .load(named: "imgAround") }
        static var icPolygon: UIImage { .load(named: "icPolygon") }
    }
    
    enum MyYello {
        static var imgMyYelloEmpty: UIImage { .load(named: "imgMyYelloEmpty") }
        static var imgGenderFemale: UIImage { .load(named: "imgGenderFemale") }
        static var imgGenderMale: UIImage { .load(named: "imgGenderMale") }
        static var icPoint: UIImage { .load(named: "icPoint") }
        static var icPointBlack: UIImage { .load(named: "icPointBlack") }
        static var icPointWhite: UIImage { .load(named: "icPointWhite") }
        static var imgInstagram: UIImage { .load(named: "imgInstagram") }
        static var icLock: UIImage { .load(named: "icLock") }
        static var imgLogo: UIImage { .load(named: "imgLogo") }
        static var imgYelloGroup: UIImage { .load(named: "imgYelloGroup") }
        static var icArrowLeft: UIImage { .load(named: "icArrowLeft") }
        static var icLockWhite: UIImage { .load(named: "icLockWhite") }
        static var icKey: UIImage { .load(named: "icKey") }
        static var icKeyWhite: UIImage { .load(named: "icKeyWhite") }
        static var icShop: UIImage { .load(named: "icShop") }
    }
    
    enum Profile {
        static var imgDefaultProfile: UIImage { .load(named: "imgDefaultProfile") }
        static var icPlus: UIImage { .load(named: "icPlus") }
        static var icArrowUp: UIImage { .load(named: "icArrowUp") }
        static var icArrowLeftWhite: UIImage { .load(named: "icArrowLeftWhite") }
        static var btnDelete: UIImage { .load(named: "btnDelete") }
    }
    
    enum Recommending {
        static var imgBannerInvite: UIImage { .load(named: "imgBannerInvite")}
        static var icAddFriendButton: UIImage { .load(named: "icAddFriendButton")}
        static var icAddFriendButtonTapped: UIImage { .load(named: "icAddFriendButtonTapped")}
        static var icRight: UIImage { .load(named: "icRight")}
        static var icSearchWhite: UIImage { .load(named: "icSearchWhite")}
    }
    
    enum Payment {
        static var imgPaymentFirst: UIImage { .load(named: "imgPaymentFirst")}
        static var imgPaymentSecond: UIImage { .load(named: "imgPaymentSecond")}
        static var imgPaymentThird: UIImage { .load(named: "imgPaymentThird")}
        static var btnSubscribe: UIImage { .load(named: "btnSubscribe")}
        static var btnFirstSubscribe: UIImage { .load(named: "btnFirstSubscribe")}
        static var btnSecondSubscribe: UIImage { .load(named: "btnSecondSubscribe")}
        static var btnThirdSubscribe: UIImage { .load(named: "btnThirdSubscribe")}
    }
  
    enum Withdrawal {
        static var imgWithdrawalCheck: UIImage { .load(named: "imgWithdrawalCheck")}
        static var imgWithdrawalFirst: UIImage { .load(named: "imgWithdrawalFirst")}
        static var imgWithdrawalSecond: UIImage { .load(named: "imgWithdrawalSecond")}
        static var imgWithdrawalThird: UIImage { .load(named: "imgWithdrawalThird")}
    }
}

extension UIImage {
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        return image
    }
    
    func resize(to size: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        return image
    }
}
