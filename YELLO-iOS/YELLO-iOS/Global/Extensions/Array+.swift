//
//  Array+.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2/10/24.
//

import Foundation

extension Array {
    subscript (safe index: Array.Index) -> Element? {
        get {
            return indices ~= index ? self[index] : nil
        }
        set {
            guard let element = newValue else { return }
            self[index] = element
        }
    }
}
