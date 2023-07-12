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
