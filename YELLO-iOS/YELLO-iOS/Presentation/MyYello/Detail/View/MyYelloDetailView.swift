//
//  MyYelloDetailView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyYelloDetailView: BaseView {
    
    let myYelloDetailNavigationBarView = MyYelloDetailNavigationBarView()
    let detailSenderView = DetailSenderView()
    let genderLabel = UILabel()
    let detailKeywordView = DetailKeywordView()
    var pointLackView: PointLackView?
    var usePointView: UsePointView?
    var getHintView: GetHintView?
    
    lazy var instagramButton = UIButton()
    lazy var keywordButton = UIButton()
    lazy var senderButton = UIButton()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .clear
        
        genderLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Detail.female, lineHeight: 16)
            $0.font = .uiLabelLarge
            $0.textColor = .white
        }
        
        instagramButton.do {
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 8
            $0.titleLabel?.font = .uiBody03
            $0.setTitleColor(.white, for: .normal)
            $0.setImage(ImageLiterals.MyYello.imgInstagram, for: .normal)
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 4)
            $0.setTitle(StringLiterals.MyYello.Detail.instagram, for: .normal)
            $0.addTarget(self, action: #selector(instagramButtonTapped), for: .touchUpInside)
        }
        
        keywordButton.do {
            $0.backgroundColor = UIColor(hex: "FFFFFF", alpha: 0.35)
            $0.layer.cornerRadius = 8
            $0.titleLabel?.font = .uiBodyMedium
            $0.setTitleColor(.black, for: .normal)
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 4)
            $0.setTitle(StringLiterals.MyYello.Detail.keywordButton, for: .normal)
            $0.addTarget(self, action: #selector(keywordButtonTapped), for: .touchUpInside)
        }
        
        senderButton.do {
            $0.backgroundColor = .yelloMain500
            $0.layer.cornerRadius = 8
            $0.titleLabel?.font = .uiSubtitle03
            $0.setTitleColor(.black, for: .normal)
            $0.setImage(ImageLiterals.MyYello.icLock, for: .normal)
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 4)
            $0.setTitle(StringLiterals.MyYello.Detail.senderButton, for: .normal)
            $0.addTarget(self, action: #selector(senderButtonTapped), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        self.addSubviews(myYelloDetailNavigationBarView,
                         detailSenderView,
                         genderLabel,
                         detailKeywordView,
                         instagramButton,
                         keywordButton,
                         senderButton)
        
        myYelloDetailNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        detailSenderView.snp.makeConstraints {
            $0.top.equalTo(myYelloDetailNavigationBarView.snp.bottom).offset(35.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(detailSenderView.snp.bottom).offset(8.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        detailKeywordView.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(42.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(154.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        instagramButton.snp.makeConstraints {
            $0.bottom.equalTo(keywordButton.snp.top).inset(-24.adjustedHeight)
            $0.height.equalTo(20)
            $0.width.equalTo(129)
            $0.centerX.equalToSuperview()
        }
        
        keywordButton.snp.makeConstraints {
            $0.bottom.equalTo(senderButton.snp.top).inset(-10.adjustedHeight)
            $0.height.equalTo(54)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        senderButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(38.adjustedHeight)
            $0.height.equalTo(54)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

extension MyYelloDetailView {
    
    // MARK: Objc Function
    @objc private func instagramButtonTapped() {
        
    }
    
    @objc private func keywordButtonTapped() {
//        showLackAlert()
//        showUsePointAlert()
//        showGetHintAlert()
//        showUseSenderPointAlert()
        showGetSenderHintAlert()
    }
    
    @objc private func senderButtonTapped() {
        
    }

    func showLackAlert() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        if let pointLackView {
            pointLackView.removeFromSuperview()
        }
        
        pointLackView = PointLackView()
        pointLackView?.frame = viewController.view.bounds
        pointLackView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.view.addSubview(pointLackView!)
    }
    
    func showUsePointAlert() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        if let usePointView {
            usePointView.removeFromSuperview()
        }
        
        usePointView = UsePointView()
        usePointView?.frame = viewController.view.bounds
        usePointView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.view.addSubview(usePointView!)
    }
    
    func showGetHintAlert() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        if let getHintView {
            getHintView.removeFromSuperview()
        }
        
        getHintView = GetHintView()
        getHintView?.frame = viewController.view.bounds
        getHintView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.view.addSubview(getHintView!)
    }
    
    func showUseSenderPointAlert() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        if let usePointView {
            usePointView.removeFromSuperview()
        }
        
        usePointView = UsePointView()
        usePointView?.frame = viewController.view.bounds
        usePointView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.view.addSubview(usePointView!)
        usePointView?.titleLabel.text = "100" + StringLiterals.MyYello.Alert.senderPoint
        usePointView?.keywordButton.setTitle(StringLiterals.MyYello.Alert.senderButton, for: .normal)
    }
    
    func showGetSenderHintAlert() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        if let getHintView {
            getHintView.removeFromSuperview()
        }
        
        getHintView = GetHintView()
        getHintView?.frame = viewController.view.bounds
        getHintView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.view.addSubview(getHintView!)
        
        getHintView?.titleLabel.text = StringLiterals.MyYello.Alert.senderTitle
        getHintView?.hintLabel.text = "ㄱ"
        
        getHintView?.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo((getHintView?.titleLabel.snp.bottom)!).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        getHintView?.pointView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(18.adjusted)
            $0.top.equalTo((getHintView?.hintLabel.snp.bottom)!).offset(30.adjusted)
            $0.height.equalTo(52)
        }
    }
}
