//
//  NSObject+.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
