//
//  PaymentReadyViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/13.
//

import UIKit

import SnapKit
import Then

final class PaymentReadyViewController: UIViewController {
    
    let paymentNavigationBarView = MyYelloDetailNavigationBarView()
    let descriptionLabel = UILabel()
    let backButton = UIButton()
        
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

extension PaymentReadyViewController {
    
    private func setDelegate() {
        paymentNavigationBarView.handleBackButtonDelegate = self
    }
    
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
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Payment.description, lineHeight: 22)
            $0.font = .uiBodyMedium
            $0.textColor = .white
        }
        
        backButton.do {
            $0.setTitle(StringLiterals.MyYello.Payment.back, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .uiBodySmall
            $0.backgroundColor = .grayscales800
            $0.layer.cornerRadius = 8
            $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
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
                         backButton)
        
        paymentNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(paymentNavigationBarView.snp.bottom).offset(215.5.adjustedHeight)
        }
        
        backButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(100.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48.adjusted)
        }
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: HandleMyYelloCellDelegate
extension PaymentReadyViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
}
