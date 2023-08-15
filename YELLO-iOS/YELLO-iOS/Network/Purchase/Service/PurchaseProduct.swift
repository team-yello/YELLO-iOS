//
//  PurchaseProduct.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/15.
//

import Foundation

enum PurchaseProduct {
  static let productID = "YELLO.iOS.yelloPlus.monthly"
  static let iapService: IAPServiceType = IAPService(productIDs: Set<String>([productID]))
  
  static func getResourceProductName(_ id: String) -> String? {
    id.components(separatedBy: ".").last
  }
}
