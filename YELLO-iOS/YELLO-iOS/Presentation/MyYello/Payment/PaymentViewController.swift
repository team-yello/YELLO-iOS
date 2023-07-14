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
            $0.titleLabel.text = nil
            $0.pointImageView.image = nil
            $0.pointLabel.text = nil
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Payment.paymentTitle, lineHeight: 24)
            $0.font = .uiHeadline03
            $0.textColor = .white
            $0.textAlignment = .left
        }
        
        nextButton.do {
            $0.setImage(ImageLiterals.Payment.btnSubscribe, for: .normal)
            $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
            $0.imageView?.contentMode = .scaleAspectFit
        }
        
        senderLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Payment.paymentSender, lineHeight: 22)
            $0.font = .uiSubtitle02
            $0.textColor = .white
        }
        
        firstSubscribeButton.do {
            $0.setImage(ImageLiterals.Payment.btnFirstSubscribe, for: .normal)
            $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
            $0.imageView?.contentMode = .scaleAspectFit
        }
        
        secondSubscribeButton.do {
            $0.setImage(ImageLiterals.Payment.btnSecondSubscribe, for: .normal)
            $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
            $0.imageView?.contentMode = .scaleAspectFit
        }
        
        thirdSubscribeButton.do {
            $0.setImage(ImageLiterals.Payment.btnThirdSubscribe, for: .normal)
            $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
            $0.imageView?.contentMode = .scaleAspectFit
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
            $0.top.equalTo(paymentNavigationBarView.snp.bottom)
            $0.leading.equalToSuperview().inset(16.adjustedHeight)
        }
        
        paymentView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16.adjustedHeight)
            $0.leading.trailing.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(paymentView.snp.bottom).offset(10.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        senderLabel.snp.makeConstraints {
            $0.top.equalTo(nextButton.snp.bottom).offset(44.adjustedHeight)
            $0.leading.equalTo(firstSubscribeButton)
        }
        
        firstSubscribeButton.snp.makeConstraints {
            $0.top.equalTo(senderLabel.snp.bottom).offset(12.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        secondSubscribeButton.snp.makeConstraints {
            $0.top.equalTo(firstSubscribeButton.snp.bottom).offset(4.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        thirdSubscribeButton.snp.makeConstraints {
            $0.top.equalTo(secondSubscribeButton.snp.bottom).offset(4.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
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
