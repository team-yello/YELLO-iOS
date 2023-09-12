//
//  PaymentPlusViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/10.
//

import UIKit

import Amplitude
import SnapKit
import StoreKit
import Then

final class PaymentPlusViewController: BaseViewController {
    
    enum PaymentStatus {
        case yelloPlus
        case nameKeyOne
        case nameKeyTwo
        case nameKeyFive
    }
    
    // MARK: - Variables
    // MARK: Constants
    let identify = AMPIdentify().setOnce("user_subscriptionbuy_count", value: NSNumber(value: 0))
                                .setOnce("", value: NSNumber(value: 0)) ?? AMPIdentify()
    // MARK: Component
    let paymentPlusView = PaymentPlusView()
    var paymentConfirmView = PaymentConfirmView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private var dimView = UIView()
    var subscribeStatus = "NORMAL" {
        didSet {
            if subscribeStatus == "NORMAL" {
                paymentPlusView.paymentNavigationBarView.subscribeView.isHidden = true
            } else {
                paymentPlusView.paymentNavigationBarView.subscribeView.isHidden = false
            }
        }
        
    }
    
    private var products = [SKProduct]()
    private let productOrder: [String] = [
        MyProducts.yelloPlusProductID,
        MyProducts.nameKeyOneProductID,
        MyProducts.nameKeyTwoProductID,
        MyProducts.nameKeyFiveProductID
    ]
    
    // MARK: - Function
    // MARK: LifeCycle
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        getProducts()
        setNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        paymentPlusView.paymentView.bannerTimer()
        purchaseSubscribeNeed()
    }
    
    func getProducts() {
        MyProducts.iapService.getProducts { [self] success, products in
            print("load products \(products ?? [])")
            if success, let products = products {
                DispatchQueue.main.async {
                    // 배열을 사용하여 제품을 원하는 순서대로 정렬합니다.
                    self.products = self.sortProducts(products)
                    print(self.products)
                    self.setAddTarget()
                }
            }
        }
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(hideLoadingIndicator),
            name: Notification.Name("HideLoadingIndicator"),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePurchaseNoti(_:)),
            name: .iapServicePurchaseNotification,
            object: nil
        )
    }
    
    override func setLayout() {
        
        view.addSubviews(paymentPlusView)
        
        paymentPlusView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        paymentPlusView.paymentNavigationBarView.handleBackButtonDelegate = self
    }
    
    private func setAddTarget() {
        paymentPlusView.paymentYelloPlusButton.addTarget(self, action: #selector(paymentYelloPlusButtonTapped), for: .touchUpInside)
        paymentPlusView.nameKeyOneButton.addTarget(self, action: #selector(paymentNameKeyOneButtonTapped), for: .touchUpInside)
        paymentPlusView.nameKeyTwoButton.addTarget(self, action: #selector(paymentNameKeyTwoButtonTapped), for: .touchUpInside)
        paymentPlusView.nameKeyFiveButton.addTarget(self, action: #selector(paymentNameKeyFiveButtonTapped), for: .touchUpInside)
        paymentPlusView.serviceButton.addTarget(self, action: #selector(serviceButtonTapped), for: .touchUpInside)
        paymentPlusView.privacyButton.addTarget(self, action: #selector(privacyButtonTapped), for: .touchUpInside)
    }
}

// MARK: HandleMyYelloCellDelegate
extension PaymentPlusViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PaymentPlusViewController: HandleConfirmPaymentButtonDelegate {
    func confirmPaymentButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PaymentPlusViewController {
    
    @objc private func privacyButtonTapped() {
        // 개인정보 처리방침 링크 연결
        let url = URL(string: "https://yell0.notion.site/97f57eaed6c749bbb134c7e8dc81ab3f")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
        
    @objc private func serviceButtonTapped() {
        // 이용약관 링크 연결
        let url = URL(string: "https://yell0.notion.site/2afc2a1e60774dfdb47c4d459f01b1d9")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc private func paymentYelloPlusButtonTapped() {
        showLoadingIndicator()
        if self.subscribeStatus == "NORMAL" {
            print("구독하고 있지 않는 사용자입니다.")
            // 첫 구매 일자 구하기
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = dateFormatter.string(from: currentDate)
            identify.setOnce("user_buy_date", value: NSString(string: formattedDate))
                    .add("user_subscriptionbuy_count", value: NSNumber(value: 1))
            Amplitude.instance().identify(identify)
            
            MyProducts.iapService.buyProduct(self.products[0])
        } else {
            print("구독하고 있는 사용자입니다.")
            self.showAlertView(title: "현재 구독 중", message: "이미 구독하고 있는 상품입니다.")
            self.hideLoadingIndicator()
        }
      
        Amplitude.instance().logEvent("click_shop_buy", withEventProperties: ["buy_type":"subscribe"])
    }
    
    @objc private func paymentNameKeyOneButtonTapped() {
        showLoadingIndicator()

        MyProducts.iapService.buyProduct(products[1])
        print("이름 열람권 1개 구입")
        
        Amplitude.instance().logEvent("click_shop_buy", withEventProperties: ["buy_type":"ticket1"])
    }
    
    @objc private func paymentNameKeyTwoButtonTapped() {
        showLoadingIndicator()
        
        MyProducts.iapService.buyProduct(products[2])
        print("이름 열람권 2개 구입")
      
        Amplitude.instance().logEvent("click_shop_buy", withEventProperties: ["buy_type":"ticket2"])
    }
    
    @objc private func paymentNameKeyFiveButtonTapped() {
        showLoadingIndicator()
        
        MyProducts.iapService.buyProduct(products[3])
        print("이름 열람권 5개 구입")
      
        Amplitude.instance().logEvent("click_shop_buy", withEventProperties: ["buy_type":"ticket5"])
    }
    
    func showPaymentConfirmView(state: PaymentStatus) {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        paymentConfirmView.removeFromSuperview()
        paymentConfirmView = PaymentConfirmView()
        switch state {
        case .yelloPlus:
            paymentConfirmView.titleLabel.text = StringLiterals.MyYello.Payment.paymentAlertPlusTitle
            paymentConfirmView.descriptionLabel.text = StringLiterals.MyYello.Payment.paymentAlertPlusDescription
            paymentConfirmView.paymentImageView.image = ImageLiterals.Payment.imgYelloPlus
            
        case .nameKeyOne:
            paymentConfirmView.titleLabel.text = StringLiterals.MyYello.Payment.paymentAlertKeyOneTitle
            paymentConfirmView.descriptionLabel.text = StringLiterals.MyYello.Payment.paymentAlertKeyDescription
            paymentConfirmView.paymentImageView.image = ImageLiterals.Payment.imgNameKeyOneCheck
            
        case .nameKeyTwo:
            paymentConfirmView.titleLabel.text = StringLiterals.MyYello.Payment.paymentAlertKeyTwoTitle
            paymentConfirmView.descriptionLabel.text = StringLiterals.MyYello.Payment.paymentAlertKeyDescription
            paymentConfirmView.paymentImageView.image = ImageLiterals.Payment.imgNameKeyTwoCheck
            
        case .nameKeyFive:
            paymentConfirmView.titleLabel.text = StringLiterals.MyYello.Payment.paymentAlertKeyFiveTitle
            paymentConfirmView.descriptionLabel.text = StringLiterals.MyYello.Payment.paymentAlertKeyDescription
            paymentConfirmView.paymentImageView.image = ImageLiterals.Payment.imgNameKeyFiveCheck
            
        default:
            return
        }
        
        paymentConfirmView.handleConfirmPaymentButtonDelegate = self
        paymentConfirmView.frame = viewController.view.bounds
        paymentConfirmView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.addSubview(paymentConfirmView)
    }
    
    @objc private func restore() {
        MyProducts.iapService.restorePurchases()
    }
    
    @objc private func handlePurchaseNoti(_ notification: Notification) {
        guard let productID = notification.object as? String else { return }
        
        guard let transactionID = notification.userInfo?["transactionID"] as? String else { return }
        
        // 상품 구매
        if productID == MyProducts.nameKeyOneProductID ||
            productID == MyProducts.nameKeyTwoProductID ||
            productID == MyProducts.nameKeyFiveProductID {
            print(transactionID)
            verifyConsumablePurchase(transactionID: transactionID, productID: productID)
        }
        
        // 구독 상품 구매
        if productID == MyProducts.yelloPlusProductID {
            verifySubscriptionPurchase(transactionID: transactionID)
            
        }
        print("여기")
    }
    
    private func verifyConsumablePurchase(transactionID: String, productID: String) {
        let productID = productID
        let transactionID = transactionID
        self.purchaseTicket(transactionID: transactionID, productID: productID)
        print("상품 구매 완료: \(productID)")
        print("transactionID: \(transactionID)")
        
        identify.add("user_singlebuy_count", value: NSNumber(value: 1))
        
        switch productID {
        case MyProducts.yelloPlusProductID:
            Amplitude.instance().logEvent("complete_shop_buy", withEventProperties: ["buy_type": "subscribe", "buy_price": 3900])
            identify.add("user_revenue", value: NSNumber(value: 3900))
        case MyProducts.nameKeyOneProductID:
            Amplitude.instance().logEvent("complete_shop_buy", withEventProperties: ["buy_type": "ticket1", "buy_price": 1400])
            identify.add("user_revenue", value: NSNumber(value: 1400))
        case MyProducts.nameKeyTwoProductID:
            Amplitude.instance().logEvent("complete_shop_buy", withEventProperties: ["buy_type": "ticket2", "buy_price": 2800])
            identify.add("user_revenue", value: NSNumber(value: 2800))
        case MyProducts.nameKeyFiveProductID:
            Amplitude.instance().logEvent("complete_shop_buy", withEventProperties: ["buy_type": "ticket5", "buy_price": 5900])
            identify.add("user_revenue", value: NSNumber(value: 5900))
        default:
            break
        }
        
        Amplitude.instance().identify(identify)
        
    }
    
    private func verifySubscriptionPurchase(transactionID: String) {
        self.purchaseSubscibe(transactionID: transactionID)
        print("구독 상품 구매 완료")
    }
    
    func purchaseSubscibe(transactionID: String) {
        let requestDTO = PurchaseRequestDTO(transactionId: transactionID, productId: MyProducts.yelloPlusProductID)
        NetworkService.shared.purchaseService.purchaseSubscibe(requestDTO: requestDTO) { result in
            switch result {
            case .success(let data):
                if data.status == 200 {
                    self.showPaymentConfirmView(state: .yelloPlus)
                } else if (500...599).contains(data.status) {
                    self.showAlertView(title: "상품 지급 오류", message: "오류로 인해 상품이 지급되지 않았어요. 옐로 공식 카카오 채널로 문의주시면 해결을 도와드리겠습니다.")
                    // 서버 통신 실패, 환불 로직 추가
                    print("서버 내부 오류 발생")
                } else {
                    self.showAlertView(title: "결제 실패", message: "결제를 실패했습니다. 다시 시도해주세요.")
                }
            default:
                print("network failure")
                return
            }
            self.hideLoadingIndicator()
        }
    }
    
    func purchaseTicket(transactionID: String, productID: String) {
        let requestDTO = PurchaseRequestDTO(transactionId: transactionID, productId: productID)
        NetworkService.shared.purchaseService.purchaseTicket(requestDTO: requestDTO) { result in
            switch result {
            case .success(let data):
                print(productID)
                if data.status == 200 {
                    switch productID {
                    case MyProducts.nameKeyOneProductID:
                        self.showPaymentConfirmView(state: .nameKeyOne)
                        
                    case MyProducts.nameKeyTwoProductID:
                        self.showPaymentConfirmView(state: .nameKeyTwo)
                        
                    case MyProducts.nameKeyFiveProductID:
                        self.showPaymentConfirmView(state: .nameKeyFive)
                        
                    default:
                        return
                    }
                } else if (500...599).contains(data.status) {
                    self.showAlertView(title: "상품 지급 오류", message: "오류로 인해 상품이 지급되지 않았어요. 옐로 공식 카카오 채널로 문의주시면 해결을 도와드리겠습니다.")
                    print("서버 내부 오류 발생")
                } else {
                    self.showAlertView(title: "결제 실패", message: "결제를 실패했습니다. 다시 시도해주세요.")
                }
            default:
                print("network failure")
                return
            }
            self.hideLoadingIndicator()
        }
    }
    
    func purchaseSubscribeNeed() {
        NetworkService.shared.purchaseService.purchaseSubscibeNeed { result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                self.subscribeStatus = data.subscribe
            default:
                print("network failure")
                return
            }
        }
    }
    
    // 원하는 순서대로 제품을 정렬하는 함수입니다.
    private func sortProducts(_ products: [SKProduct]) -> [SKProduct] {
        var sortedProducts: [SKProduct] = []
        
        for productID in productOrder {
            if let product = products.first(where: { $0.productIdentifier == productID }) {
                sortedProducts.append(product)
            }
        }
        return sortedProducts
    }
    
    private func showLoadingIndicator() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.5) // 어둡게 딤처리된 배경색 설정
        
        loadingIndicator.startAnimating()
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubviews(dimView, loadingIndicator)
        dimView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc private func hideLoadingIndicator() {        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
        dimView.removeFromSuperview()
    }
    
    func showAlertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
