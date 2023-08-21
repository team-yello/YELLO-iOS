//
//  PaymentPlusViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/10.
//

import UIKit

import Amplitude
import SnapKit
import Then

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
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setAddTarget()
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
    func pushPaymentReadyViewController() {
        let paymentReadyViewController = PaymentReadyViewController()
        self.navigationController?.pushViewController(paymentReadyViewController, animated: true)
    }
    
    // MARK: - Network
    func payCheck(index: Int) {
        let requestDTO = PayRequestBodyDTO(index: index)
        NetworkService.shared.myYelloService.payCheck(requestDTO: requestDTO) { response in
            switch response {
            case .success:
                print("통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
    
    @objc private func paymentYelloPlusButtonTapped() {
        payCheck(index: 0)
        pushPaymentReadyViewController()
        print("옐로플러스 구독 결제")
        Amplitude.instance().logEvent("click_shop_buy", withEventProperties: ["buy_type": "subscribe"])
//        showPaymentConfirmView(state: .yelloPlus)
    }
    
    @objc private func paymentNameKeyOneButtonTapped() {
        payCheck(index: 1)
        pushPaymentReadyViewController()
        print("이름 열람권 1개 구입")
        Amplitude.instance().logEvent("click_shop_buy", withEventProperties: ["buy_type": "ticket1"])
//        showPaymentConfirmView(state: .nameKeyOne)
    }
    
    @objc private func paymentNameKeyTwoButtonTapped() {
        payCheck(index: 2)
        pushPaymentReadyViewController()
        print("이름 열람권 3개 구입")
        Amplitude.instance().logEvent("click_shop_buy", withEventProperties: ["buy_type": "ticket2"])
//        showPaymentConfirmView(state: .nameKeyTwo)
    }
    
    @objc private func paymentNameKeyFiveButtonTapped() {
        payCheck(index: 3)
        pushPaymentReadyViewController()
        print("이름 열람권 5개 구입")
        Amplitude.instance().logEvent("click_shop_buy", withEventProperties: ["buy_type": "ticket5"])
//        showPaymentConfirmView(state: .nameKeyFive)
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
}
