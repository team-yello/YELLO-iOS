//
//  WithdrawalAlertView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then
import KakaoSDKUser

final class WithdrawalAlertView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    let contentsView = UIView()
    
    private let titleLabel = UILabel()
    let noButton = UIButton()
    let yesButton = UIButton()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black.withAlphaComponent(0.5)
        
        contentsView.makeCornerRound(radius: 12.adjustedHeight)
        contentsView.backgroundColor = .grayscales900
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.WithdrawalAlert.title, lineHeight: 22.adjustedHeight)
            $0.font = .uiSubtitle02
            $0.textColor = .white
        }
        
        noButton.do {
            $0.setTitle(StringLiterals.Profile.WithdrawalAlert.no, for: .normal)
            $0.setTitleColor(.grayscales600, for: .normal)
            $0.titleLabel?.font = .uiButton
            $0.addTarget(self, action: #selector(noButtonClicked), for: .touchUpInside)
        }
        
        yesButton.do {
            $0.setTitle(StringLiterals.Profile.WithdrawalAlert.yes, for: .normal)
            $0.setTitleColor(.semanticStatusRed500, for: .normal)
            $0.titleLabel?.font = .uiButton
            $0.addTarget(self, action: #selector(yesButtonClicked), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        self.addSubview(contentsView)
        
        contentsView.addSubviews(titleLabel,
                                 noButton,
                                 yesButton)
        
        contentsView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(280.adjustedWidth)
            $0.height.equalTo(140.adjustedHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        noButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(26.adjustedHeight)
            $0.leading.equalToSuperview().inset(34.adjustedWidth)
            $0.width.equalTo(34.adjustedWidth)
            $0.height.equalTo(28.adjustedHeight)
        }
        
        yesButton.snp.makeConstraints {
            $0.bottom.equalTo(noButton)
            $0.trailing.equalToSuperview().inset(34.adjustedWidth)
            $0.width.equalTo(74.adjustedWidth)
            $0.height.equalTo(28.adjustedHeight)
        }
    }
}

// MARK: - extension
extension WithdrawalAlertView {
    
    // MARK: Objc Function
    @objc func noButtonClicked() {
        self.isHidden = true
        self.removeFromSuperview()
    }
    
    @objc func yesButtonClicked() {
        NetworkService.shared.profileService.userDelete { result in
            switch result {
            case .success(let data):
                if data.status == 200 {
                    UserApi.shared.unlink {(error) in
                        if let error = error {
                            print(error)
                        } else {
                            print("unlink() success.")
                        }
                    }
                    
                    KeychainHandler.shared.removeAll()
                    UserDefaults.standard.removeObject(forKey: "accessToken")
                    UserDefaults.standard.removeObject(forKey: "refreshToken")
                    UserDefaults.standard.removeObject(forKey: "isLoggined")
                    let splashViewController = KakaoLoginViewController()
                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                    sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: splashViewController)
                }
            default:
                print("NetWorkFaliure")
                return
            }
        }
        
    }
}
