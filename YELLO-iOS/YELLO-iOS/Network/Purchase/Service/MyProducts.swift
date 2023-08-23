//
//  PurchaseProduct.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/15.
//

import Foundation

enum MyProducts {
    static let yelloPlusProductID = "YELLO.iOS.yelloPlus.monthly"
    static let nameKeyOneProductID = "YELLO.iOS.nameKey.one"
    static let nameKeyTwoProductID = "YELLO.iOS.nameKey.two"
    static let nameKeyFiveProductID = "YELLO.iOS.nameKey.five"
    
    static let iapService: IAPServiceType = IAPService(productIDs: Set<String>([yelloPlusProductID, nameKeyOneProductID, nameKeyTwoProductID, nameKeyFiveProductID]))
    
    static func getResourceProductName(_ id: String) -> String? {
        id.components(separatedBy: ".").last
    }
}
