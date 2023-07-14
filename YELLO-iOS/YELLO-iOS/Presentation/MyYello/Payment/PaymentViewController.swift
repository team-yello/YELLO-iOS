//
//  PaymentViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/13.
//

import UIKit

import SnapKit
import Then

final class PaymentViewController: UIViewController {
    
    // MARK: - Variables
    // MARK: Component
    let paymentNavigationBarView = MyYelloDetailNavigationBarView()
    let titleLabel = UILabel()
    let paymentView = PaymentView()
    let nextButton = UIButton()
    let senderLabel = UILabel()
    let firstSubscribeButton = UIButton()
    let secondSubscribeButton = UIButton()
    let thirdSubscribeButton = UIButton()
        
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
}

// MARK: - extension
extension PaymentViewController {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        
        view.backgroundColor = .black
        
        paymentNavigationBarView.do {
            $0.titleLabel.text = StringLiterals.MyYello.Payment.title
            $0.pointImageView.image = ImageLiterals.MyYello.icPoint
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Payment.paymentTitle, lineHeight: 24)
            $0.font = .uiSubtitle01
            $0.textColor = .white
        }
        
        nextButton.do {
            $0.setImage(ImageLiterals.Payment.btnSubscribe, for: .normal)
            $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        }
        
        senderLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Payment.paymentSender, lineHeight: 22)
            $0.font = .uiSubtitle02
            $0.textColor = .white
        }
        
        firstSubscribeButton.do {
            $0.setImage(ImageLiterals.Payment.btnFirstSubscribe, for: .normal)
            $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        }
        
        secondSubscribeButton.do {
            $0.setImage(ImageLiterals.Payment.btnSecondSubscribe, for: .normal)
            $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        }
        
        thirdSubscribeButton.do {
            $0.setImage(ImageLiterals.Payment.btnThirdSubscribe, for: .normal)
            $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        view.addSubviews(paymentNavigationBarView,
                         titleLabel,
                         paymentView,
                         nextButton,
                         senderLabel,
                         firstSubscribeButton,
                         secondSubscribeButton,
                         thirdSubscribeButton)
        
        paymentNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(paymentNavigationBarView)
            $0.leading.equalToSuperview().inset(16.adjustedHeight)
        }
        
        paymentView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(16.adjustedHeight)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(202)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(paymentView.snp.bottom).offset(10.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        senderLabel.snp.makeConstraints {
            $0.top.equalTo(nextButton.snp.bottom).offset(44.adjustedHeight)
            $0.leading.equalToSuperview().inset(16)
        }
        
        firstSubscribeButton.snp.makeConstraints {
            $0.top.equalTo(senderLabel.snp.bottom).offset(12.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        secondSubscribeButton.snp.makeConstraints {
            $0.top.equalTo(firstSubscribeButton.snp.bottom).offset(4.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        thirdSubscribeButton.snp.makeConstraints {
            $0.top.equalTo(secondSubscribeButton.snp.bottom).offset(4.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        paymentNavigationBarView.handleBackButtonDelegate = self
    }
    
    // MARK: Objc Function
    @objc func nextButtonTapped() {
        let paymentReadyViewController = PaymentReadyViewController()
        self.navigationController?.pushViewController(paymentReadyViewController, animated: true)
    }
}

// MARK: HandleMyYelloCellDelegate
extension PaymentViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}
