//
//  Image.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import UIKit

enum ImageLiterals {
    
    enum OnBoarding {
        static var icArrowLeft: UIImage { .load(named: "icArrowLeft") }
        static var icChevronDown: UIImage { .load(named: "icChevronDown") }
        static var icSearch: UIImage { .load(named: "icSearch") }
        static var icX: UIImage { .load(named: "icX") }
        static var icYelloFace: UIImage { .load(named: "icYelloFace") }
        static var btnKakaoLogin: UIImage { .load(named: "btnKakaoLogin")}
        static var icXCircle: UIImage { .load(named: "icXCircle")}
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
