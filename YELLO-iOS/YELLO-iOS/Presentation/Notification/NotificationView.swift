//
//  NotificationView.swift
//  YELLO-iOS
//
//  Created by 변희주 on 1/28/24.
//

import UIKit

import SnapKit
import Then

final class NotificationView: BaseView {
        
    let notificationImageView = UIImageView()
    let doNotSeeAgainButton = UIButton()
    private let doNotSeeAgainLabel = UILabel()
    private let closeButton = UIButton()
    
    var isTapped: Bool = false

    override func setStyle() {
        self.backgroundColor = .black.withAlphaComponent(0.8)

        notificationImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.isUserInteractionEnabled = true
        }

        doNotSeeAgainButton.do {
            $0.setImage(UIImage(imageLiteralResourceName: "btnNotCheckBox"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFill
            $0.addTarget(self, action: #selector(doNotSeeButtonTapped), for: .touchUpInside)
        }
        
        doNotSeeAgainLabel.do {
            $0.text = StringLiterals.Notification.doNotSeeAgainLabel
            $0.textColor = .white
            $0.font = .uiBody02
        }
        
        closeButton.do {
            $0.setTitle(StringLiterals.Notification.close, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .uiButton02
            $0.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        self.addSubviews(notificationImageView,
                         doNotSeeAgainButton,
                         doNotSeeAgainLabel,
                         closeButton)
        
        notificationImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(statusBarHeight + 126.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(252.adjusted)
            $0.height.equalTo(336.adjusted)
        }
        
        doNotSeeAgainButton.snp.makeConstraints {
            $0.top.equalTo(notificationImageView.snp.bottom).offset(8.adjusted)
            $0.leading.equalTo(notificationImageView)
            $0.size.equalTo(24.adjusted)
        }
        
        doNotSeeAgainLabel.snp.makeConstraints {
            $0.leading.equalTo(doNotSeeAgainButton.snp.trailing).offset(8.adjusted)
            $0.centerY.equalTo(doNotSeeAgainButton)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(notificationImageView.snp.bottom).offset(8.adjusted)
            $0.trailing.equalTo(notificationImageView).offset(-13.adjusted)
            $0.width.equalTo(21.adjusted)
            $0.height.equalTo(24.adjusted)
        }
    }
}

extension NotificationView {
    @objc
    private func doNotSeeButtonTapped() {
        isTapped.toggle()
        doNotSeeAgainButton.setImage(UIImage(imageLiteralResourceName: isTapped ? "btnCheckBox" : "btnNotCheckBox"), for: .normal)
        UserDefaults.standard.set(isTapped, forKey: "isTapped")
    }
    
    @objc
    private func closeButtonTapped() {
        self.isHidden = true
        self.removeFromSuperview()
    }
}
