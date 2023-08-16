//
//  IAPService.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/15.
//

import StoreKit

extension Notification.Name {
  static let iapServicePurchaseNotification = Notification.Name("IAPServicePurchaseNotification")
}

typealias ProductsRequestCompletion = (_ success: Bool, _ products: [SKProduct]?) -> Void

protocol IAPServiceType {
  var canMakePayments: Bool { get }
  
  func getProducts(completion: @escaping ProductsRequestCompletion)
  func buyProduct(_ product: SKProduct)
  func isProductPurchased(_ productID: String) -> Bool
  func restorePurchases()
}

final class IAPService: NSObject, IAPServiceType {
  private let productIDs: Set<String>
  private var purchasedProductIDs: Set<String>
  private var productsRequest: SKProductsRequest?
  private var productsCompletion: ProductsRequestCompletion?
  
  var canMakePayments: Bool {
    SKPaymentQueue.canMakePayments()
  }
  
  init(productIDs: Set<String>) {
    self.productIDs = productIDs
//      self.purchasedProductIDs = productIDs
//          .filter { UserDefaults.standard.bool(forKey: $0) == true }
      self.purchasedProductIDs = Set<String>()
    
    super.init()
    SKPaymentQueue.default().add(self)
      print("채은1")
  }
  
  func getProducts(completion: @escaping ProductsRequestCompletion) {
    self.productsRequest?.cancel()
    self.productsCompletion = completion
    self.productsRequest = SKProductsRequest(productIdentifiers: self.productIDs)
    self.productsRequest?.delegate = self
    self.productsRequest?.start()
      print("채은2")
  }
    
  func buyProduct(_ product: SKProduct) {
    SKPaymentQueue.default().add(SKPayment(product: product))
      print("채은3")
  }
    
  func isProductPurchased(_ productID: String) -> Bool {
    self.purchasedProductIDs.contains(productID)
  }
    
  func restorePurchases() {
    SKPaymentQueue.default().restoreCompletedTransactions()
      print("채은5")

  }
}

extension IAPService: SKProductsRequestDelegate {
  // didReceive
  func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    let products = response.products
    self.productsCompletion?(true, products)
    self.clearRequestAndHandler()
      print("채은6")

    products.forEach { print("Found product: \($0.productIdentifier) \($0.localizedTitle) \($0.price.floatValue)") }
  }
  
  // failed
  func request(_ request: SKRequest, didFailWithError error: Error) {
    print("Erorr: \(error.localizedDescription)")
    self.productsCompletion?(false, nil)
    self.clearRequestAndHandler()
      print("채은7")

  }
  
  private func clearRequestAndHandler() {
    self.productsRequest = nil
    self.productsCompletion = nil
      print("채은8")

  }
}

extension IAPService: SKPaymentTransactionObserver {
  func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    transactions.forEach {
      switch $0.transactionState {
      case .purchased:
          let productID = $0.payment.productIdentifier
          self.deliverPurchaseNotificationFor(id: productID, transaction: $0)
          print("completed transaction")
//          self.deliverPurchaseNotificationFor(id: $0.original?.payment.productIdentifier, transaction: $0)
//          print($0.original?.payment.productIdentifier)
//          print($0)
          let transactionID = $0.transactionIdentifier ?? ""
          print("Transaction ID: \(transactionID)")
          SKPaymentQueue.default().finishTransaction($0)
          print("채은888888")

      case .failed:
          if let transactionError = $0.error as NSError?,
           let description = $0.error?.localizedDescription,
           transactionError.code != SKError.paymentCancelled.rawValue {
          print("Transaction erorr: \(description)")
              print("채은9")
        }
        SKPaymentQueue.default().finishTransaction($0)
      case .restored:
        print("failed transaction")
          self.deliverPurchaseNotificationFor(id: $0.original?.payment.productIdentifier, transaction: $0)
        SKPaymentQueue.default().finishTransaction($0)
          print("채은10")

      case .deferred:
        print("deferred")
          print("채은11")

      case .purchasing:
        print("purchasing")
          print("채은12")

      default:
        print("unknown")
          print("채은13")

      }
    }
  }
    
    private func deliverPurchaseNotificationFor(id: String?, transaction: SKPaymentTransaction) {
      guard let id = id else {
          print("productID is nil")
          return
      }

      self.purchasedProductIDs.insert(id)
      UserDefaults.standard.set(true, forKey: id)
      print("채은14")
      NotificationCenter.default.post(
        name: .iapServicePurchaseNotification,
        object: id
      )
      print("Notification delivered for product ID: \(id)")
  }
  



}
