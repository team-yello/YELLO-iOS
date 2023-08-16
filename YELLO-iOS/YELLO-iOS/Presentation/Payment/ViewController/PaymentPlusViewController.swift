//
//  PaymentPlusViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/10.
//

import UIKit

import SnapKit
import Then
import StoreKit

final class PaymentPlusViewController: BaseViewController {
    
    enum PaymentStatus {
        case yelloPlus
        case nameKeyOne
        case nameKeyTwo
        case nameKeyFive
    }
    
    // MARK: - Variables
    // MARK: Component
    let paymentPlusView = PaymentPlusView()
    var paymentConfirmView = PaymentConfirmView()
    
    private var products = [SKProduct]()
    private let productOrder: [String] = [
        MyProducts.yelloPlusProductID,
        MyProducts.nameKeyOneProductID,
        MyProducts.nameKeyTwoProductID,
        MyProducts.nameKeyFiveProductID
    ]
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setAddTarget()
        
        MyProducts.iapService.getProducts { [self] success, products in
            print("load products \(products ?? [])")
            if success, let products = products {
                DispatchQueue.main.async {
                    // 배열을 사용하여 제품을 원하는 순서대로 정렬합니다.
                    self.products = self.sortProducts(products)
                    print(self.products)
                }
            }
        }

        NotificationCenter.default.addObserver(
          self,
          selector: #selector(handlePurchaseNoti(_:)),
          name: .iapServicePurchaseNotification,
          object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        paymentPlusView.paymentView.bannerTimer()
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
    @objc private func paymentYelloPlusButtonTapped() {
        MyProducts.iapService.buyProduct(products[0])
        print("옐로플러스 구독 결제")
    }
    
    @objc private func paymentNameKeyOneButtonTapped() {
        MyProducts.iapService.buyProduct(products[1])
        print("이름 열람권 1개 구입")
    }
    
    @objc private func paymentNameKeyTwoButtonTapped() {
        MyProducts.iapService.buyProduct(products[2])
        print("이름 열람권 2개 구입")
    }
    
    @objc private func paymentNameKeyFiveButtonTapped() {
        MyProducts.iapService.buyProduct(products[3])
        print("이름 열람권 5개 구입")
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
        
        switch productID {
        case MyProducts.yelloPlusProductID:
            showPaymentConfirmView(state: .nameKeyOne)
        case MyProducts.nameKeyOneProductID:
            showPaymentConfirmView(state: .yelloPlus)
        case MyProducts.nameKeyTwoProductID:
            showPaymentConfirmView(state: .nameKeyTwo)
        case MyProducts.nameKeyFiveProductID:
            showPaymentConfirmView(state: .nameKeyFive)
        default:
            return
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
}
