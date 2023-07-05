//
//  Image.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import UIKit

enum ImageLiterals{
    enum OnBoarding{
        static var icArrowLeft: UIImage { .load(named: "icArrowLeft") }
        static var icChevronDown: UIImage { .load(named: "icChevronDown") }
        static var icSearch: UIImage { .load(named: "icSearch") }
        static var icX: UIImage { .load(named: "icX") }
        static var icYelloFace: UIImage { .load(named: "icYelloFace") }
        static var btnKakaoLogin: UIImage { .load(named: "btnKakaoLogin")}
    }
    enum TabBar{
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