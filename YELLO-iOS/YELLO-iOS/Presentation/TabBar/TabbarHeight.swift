//
//  TabbarHeight.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit


func safeAreaBottomInset() -> CGFloat {
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        return bottomPadding ??  0.0
    } else {
        return 0.0
    }
}
