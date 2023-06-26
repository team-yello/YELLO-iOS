//
//  Int+.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

// ex)
// priceLabel.text = carrot.price.priceText

import Foundation

extension Int {
    
    var priceText: String {
        get {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            var priceString = numberFormatter.string(for: self) ?? "-1"
            priceString = priceString + "원"
            return priceString
        }
    }
}
