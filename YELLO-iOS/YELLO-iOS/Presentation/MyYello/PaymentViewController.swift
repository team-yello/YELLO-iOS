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
    let descriptionLabel = UILabel()
    let nextButton = UIButton()
        
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
        
        descriptionLabel.do {
            $0.setTextWithLineHeight(text: "구독권 결제는\n500만원입니다.", lineHeight: 22)
            $0.font = .uiBodyLarge
            $0.textColor = .white
        }
        
        nextButton.do {
            $0.setTitle("결제하기", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .uiBodySmall
            $0.backgroundColor = .yelloMain500
            $0.layer.cornerRadius = 8
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
                         descriptionLabel,
                         nextButton)
        
        paymentNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(paymentNavigationBarView.snp.bottom).offset(215.5.adjustedHeight)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(100.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48.adjusted)
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
