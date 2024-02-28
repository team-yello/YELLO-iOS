//
//  PaymentPlusViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/10.
//

import UIKit

import Amplitude
import GoogleMobileAds
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
    let uuid = UUID().uuidString
    
    // MARK: Property
    var isRewardPossible = true
    var countdownTimer: Timer?
    var remainingSeconds: TimeInterval? {
        didSet {
            paymentPlusView.adPointButton.isEnabled = true
            if let remainingSeconds {
                paymentPlusView.adPointButton.subTitleLabel.text = String(format: "%02d:%02d", Int(remainingSeconds/60), Int(remainingSeconds.truncatingRemainder(dividingBy: 60)))
            }
            if remainingSeconds == 0 {
                isRewardPossible = true
                stop()
                UIView.transition(with: self.navigationController!.view, duration: 0.001, options: .transitionCrossDissolve, animations: {
                    self.paymentPlusView.adPointButton.pointTitleLabel.textColor = .purpleSub100
                    self.paymentPlusView.adPointButton.pointLabel.textColor = .purpleSub100
                    self.paymentPlusView.adPointButton.makeBorder(width: 1, color: .purpleSub800)
                    self.paymentPlusView.adPointButton.subTitleLabel.text = StringLiterals.MyYello.Payment.adPointsubTitle
                })
            }
        }
    }
    
    // MARK: Component
    private var rewardedAd: GADRewardedAd?
    let paymentPlusView = PaymentPlusView()
    var paymentConfirmView = PaymentConfirmView()
    private let eventPointView = EventPointView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private var dimView = UIView()
    var subscribeStatus = "normal" {
        didSet {
            if subscribeStatus == "normal" || !UserManager.shared.isYelloPlus {
                paymentPlusView.subscribeBackgroundView.isHidden = true
            } else {
                paymentPlusView.subscribeBackgroundView.isHidden = false
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
        checkRewardPossible()
        tabBarController?.tabBar.isHidden = true
        setInitialUI()
        paymentPlusView.paymentView.startBannerTimer()
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
        paymentPlusView.votingPointButton.addTarget(self, action: #selector(votingPointButtonTapped), for: .touchUpInside)
        paymentPlusView.adPointButton.addTarget(self, action: #selector(adPointButtonTapped), for: .touchUpInside)
    }
    
    private func setInitialUI() {
        self.paymentPlusView.adPointButton.isEnabled = true
        paymentPlusView.paymentNavigationBarView.pointCountView.countLabel.text = String(UserManager.shared.userPoint)
        paymentPlusView.paymentNavigationBarView.keyCountView.countLabel.text = String(UserManager.shared.userTicketCount)
        if UserManager.shared.isYelloPlus {
            paymentPlusView.subscribeBackgroundView.isHidden = false
        } else {
            paymentPlusView.subscribeBackgroundView.isHidden = true
        }
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
        }
        
        paymentConfirmView.handleConfirmPaymentButtonDelegate = self
        paymentConfirmView.frame = viewController.view.bounds
        paymentConfirmView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.addSubview(paymentConfirmView)
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
            Amplitude.instance().logEvent("complete_shop_buy", withEventProperties: ["buy_type": "subscribe", "buy_price": 2900])
            identify.add("user_revenue", value: NSNumber(value: 2900))
        case MyProducts.nameKeyOneProductID:
            Amplitude.instance().logEvent("complete_shop_buy", withEventProperties: ["buy_type": "ticket1", "buy_price": 990])
            identify.add("user_revenue", value: NSNumber(value: 990))
        case MyProducts.nameKeyTwoProductID:
            Amplitude.instance().logEvent("complete_shop_buy", withEventProperties: ["buy_type": "ticket2", "buy_price": 1900])
            identify.add("user_revenue", value: NSNumber(value: 1900))
        case MyProducts.nameKeyFiveProductID:
            Amplitude.instance().logEvent("complete_shop_buy", withEventProperties: ["buy_type": "ticket5", "buy_price": 3900])
            identify.add("user_revenue", value: NSNumber(value: 3900))
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
                Amplitude.instance().setUserProperties(["user_subscription": "yes"])
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
    
    func showAlertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // 광고 관련 Custom Function
    func checkRewardPossible() {
        NetworkService.shared.rewardService.checkRewardPossible(tag: StringLiterals.Reward.admobReward) { result in
            switch result {
            case .success(let data):
                if let data = data.data {
                    self.isRewardPossible = data.isPossible
                    if data.isPossible {
                        self.paymentPlusView.adPointButton.pointTitleLabel.textColor = .purpleSub100
                        self.paymentPlusView.adPointButton.pointLabel.textColor = .purpleSub100
                        self.paymentPlusView.adPointButton.subTitleLabel.text = StringLiterals.MyYello.Payment.adPointsubTitle
                        self.paymentPlusView.adPointButton.makeBorder(width: 1, color: .purpleSub800)
                    } else {
                        self.startTimerFormat(data.createdAt)
                        self.paymentPlusView.adPointButton.pointTitleLabel.textColor = .grayscales500
                        self.paymentPlusView.adPointButton.pointLabel.textColor = .grayscales500
                        self.paymentPlusView.adPointButton.makeBorder(width: 1, color: .grayscales800)
                    }
                }
            default:
                debugPrint("Failed to communicate availability of rewarded ads")
            }
        }
    }
    
    func getReward() {
        let request = RewardRequestDTO(rewardType: StringLiterals.Reward.admobReward,
                                       randomType: StringLiterals.Reward.fix,
                                       uuid: uuid,
                                       rewardNumber: 10)
        NetworkService.shared.rewardService.postRewardAd(requestDTO: request) { result in
            switch result {
            case .success(let data):
                if let data = data.data {
                    self.eventPointView.pointLabel.text = data.rewardTitle
                    self.eventPointView.nextTimeLabel.text = ""
                    UserManager.shared.userPoint += data.rewardValue
                    self.paymentPlusView.paymentNavigationBarView.pointCountView.countLabel.text = String(UserManager.shared.userPoint)
                    self.paymentPlusView.adPointButton.pointTitleLabel.textColor = .grayscales500
                    self.paymentPlusView.adPointButton.pointLabel.textColor = .grayscales500
                    self.paymentPlusView.adPointButton.makeBorder(width: 1, color: .grayscales800)
                    self.paymentPlusView.adPointButton.isEnabled = false
                    self.showEventPointView()
                }
                
            default:
                self.view.showToast(message: "광고 보상 포인트 받기에 실패했습니다.\n잠시 후 다시 시도해주세요", at: 100.adjustedHeight)
                debugPrint("보상형 광고 보상 실패")
            }
        }
    }
    
    func loadRewardedAd(completion: @escaping (Bool) -> Void) {
        showLoadingIndicator()
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID: Config.rewardAd,
                           request: request,
                           completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load rewarded ad with error: \(error.localizedDescription)")
                view.showToast(message: "광고 보기에 실패했습니다.", at: 100.adjustedHeight)
                self.hideLoadingIndicator()
                return
            }
            rewardedAd = ad
            let options = GADServerSideVerificationOptions()
            options.customRewardString = uuid
            rewardedAd?.serverSideVerificationOptions = options
            rewardedAd?.fullScreenContentDelegate = self
            print("Rewarded ad loaded.")
            completion(true)
        }
        )
    }
    
    func show() {
        if let ad = rewardedAd {
            ad.present(fromRootViewController: self) {
                let reward = ad.adReward
                debugPrint("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
            }
        }
    }
    
    private func showEventPointView() {
        self.eventPointView.frame = self.view.bounds
        self.eventPointView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.startTimerFormat(Date().toString())
        self.view.addSubview(self.eventPointView)
        
        self.eventPointView.checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    // MARK: Objc Function
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
        if self.subscribeStatus == "normal" {
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
        
        Amplitude.instance().logEvent("click_shop_buy", withEventProperties: ["buy_type": "subscribe"])
    }
    
    @objc private func paymentNameKeyOneButtonTapped() {
        showLoadingIndicator()
        
        MyProducts.iapService.buyProduct(products[1])
        print("이름 열람권 1개 구입")
        
        Amplitude.instance().logEvent("click_shop_buy", withEventProperties: ["buy_type": "ticket1"])
    }
    
    @objc private func paymentNameKeyTwoButtonTapped() {
        showLoadingIndicator()
        
        MyProducts.iapService.buyProduct(products[2])
        print("이름 열람권 2개 구입")
        
        Amplitude.instance().logEvent("click_shop_buy", withEventProperties: ["buy_type": "ticket2"])
    }
    
    @objc private func paymentNameKeyFiveButtonTapped() {
        showLoadingIndicator()
        
        MyProducts.iapService.buyProduct(products[3])
        print("이름 열람권 5개 구입")
        
        Amplitude.instance().logEvent("click_shop_buy", withEventProperties: ["buy_type": "ticket5"])
    }
    
    @objc private func votingPointButtonTapped() {
        tabBarController?.tabBar.items?[2].imageInsets = UIEdgeInsets(top: -23, left: 0, bottom: 0, right: 0)
        tabBarController?.selectedIndex = 2
        tabBarController?.tabBar.isHidden = false
        popView()
    }
    
    @objc private func adPointButtonTapped() {
        if isRewardPossible {
            loadRewardedAd { isEndLoading in
                if isEndLoading {
                    self.hideLoadingIndicator()
                    self.show()
                }
            }
        } else {
            self.view.showToast(message: StringLiterals.MyYello.Payment.adPointErrorToast, at: 100.adjustedHeight)
        }
    }
    
    @objc private func hideLoadingIndicator() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
        dimView.removeFromSuperview()
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
    }
    
    @objc private func checkButtonTapped() {
        self.eventPointView.removeFromSuperview()
    }
}

extension PaymentPlusViewController: GADFullScreenContentDelegate {
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        self.getReward()
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        debugPrint("광고 로드 실패")
        loadingIndicator.stopAnimating()
    }
}
