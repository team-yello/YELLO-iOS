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
    
    // App Store Connect에 등록된 productsID
    private let productIDs: Set<String>
    // App Stroe Connect에 등록된 product 중 구매한 productsID
    private var purchasedProductIDs: Set<String>
    private var productsRequest: SKProductsRequest?
    private var productsCompletion: ProductsRequestCompletion?
    
    // 구매 가능 여부
    var canMakePayments: Bool {
        SKPaymentQueue.canMakePayments()
    }
    
    init(productIDs: Set<String>) {
        self.productIDs = productIDs
        self.purchasedProductIDs = productIDs
            .filter { UserDefaults.standard.bool(forKey: $0) == true }
        //        self.purchasedProductIDs = Set<String>()
        
        super.init()
        
        // App Store Connect와 동기화
        SKPaymentQueue.default().add(self)
        print("채은1")
    }
    
    // App Store Connect가 갖고 있는 products 조회
    func getProducts(completion: @escaping ProductsRequestCompletion) {
        self.productsRequest?.cancel()
        self.productsCompletion = completion
        self.productsRequest = SKProductsRequest(productIdentifiers: self.productIDs)
        self.productsRequest?.delegate = self
        self.productsRequest?.start()
        print("채은2")
    }
    
    // 구매
    func buyProduct(_ product: SKProduct) {
        SKPaymentQueue.default().add(SKPayment(product: product))
        print("채은3")
    }
    
    // 구매 여부 확인
    func isProductPurchased(_ productID: String) -> Bool {
        self.purchasedProductIDs.contains(productID)
    }
    
    // 복원
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
        print("채은5")
    }
}

// 앱스토어에 보낸 상품 리스트 요청에 대한 응답을 받는 delegate
extension IAPService: SKProductsRequestDelegate {
    
    // 인앱결제 상품 리스트 로드 완료
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        self.productsCompletion?(true, products)
        self.clearRequestAndHandler()
        print("채은6")
        products.forEach { print("Found product: \($0.productIdentifier) \($0.localizedTitle) \($0.price.floatValue)") }
    }
    
    // 인앱결제 상품 리스트 로드 실패
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Erorr: \(error.localizedDescription)")
        self.productsCompletion?(false, nil)
        self.clearRequestAndHandler()
        print("채은7")
    }
    
    // 핸들러 초기화
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
                // 구입 성공
                let productID = $0.payment.productIdentifier
                self.deliverPurchaseNotificationFor(id: productID, transaction: $0)
                print("completed transaction")
                SKPaymentQueue.default().finishTransaction($0)
                print("채은888888")
            case .failed:
                // 구입 실패
                if let transactionError = $0.error as NSError?,
                   let description = $0.error?.localizedDescription,
                   transactionError.code != SKError.paymentCancelled.rawValue {
                    print("Transaction erorr: \(description)")
                    print("채은9")
                }
                SKPaymentQueue.default().finishTransaction($0)
                NotificationCenter.default.post(name: Notification.Name("HideLoadingIndicator"), object: nil)
            case .restored:
                // 복원 성공
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
        
        let transactionID = transaction.transactionIdentifier ?? ""
        print("Transaction ID: \(transactionID)")
        
        self.purchasedProductIDs.insert(id)
        UserDefaults.standard.set(true, forKey: id)
        print("채은14")
        NotificationCenter.default.post(
            name: .iapServicePurchaseNotification,
            object: id,
            userInfo: ["transactionID": transactionID] // transactionID를 userInfo에 추가
        )
        print("Notification delivered for product ID: \(id)")
    }
}
