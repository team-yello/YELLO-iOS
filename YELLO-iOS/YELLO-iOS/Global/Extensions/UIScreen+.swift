//
//  UIScreen+.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/15.
//

import UIKit

extension UIScreen {
    /// - Mini, SE: 375.0
    /// - pro: 390.0
    /// - pro max: 428.0
    var isWiderThan375pt: Bool { self.bounds.size.width > 375 }
    var isLongerThan812pt: Bool {self.bounds.size.height >= 812}
}
