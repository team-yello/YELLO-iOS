//
//  VotingSharingViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

//import KakaoSDKCommon
//import KakaoSDKTemplate
//import KakaoSDKShare

// MARK: - InvitingViewController

final class InvitingViewController: BaseViewController {
    
    private let originView = InvitingView()
    
    // MARK: - Style
    
    override func setStyle() {
        view.backgroundColor = .black
        
        originView.closeButton.do {
            $0.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        }
        
        originView.kakaoButton.do {
            $0.addTarget(self, action: #selector(kakaoButtonClicked), for: .touchUpInside)
        }
        
        originView.copyButton.do {
            $0.addTarget(self, action: #selector(copyButtonClicked), for: .touchUpInside)
        }
    }
    
    // MARK: - Layout
    
    override func setLayout() {
        
        view.addSubview(originView)
        originView.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(374)
            $0.center.equalToSuperview()
        }
        
    }
    
    // MARK: - closeButton 클릭했을 때
    
    @objc
    func closeButtonClicked() {
        self.dismiss(animated: true)
    }
    
    // MARK: - kakaoButton 클릭했을 때
    
    @objc
    func kakaoButtonClicked() {
        /// 카카오톡 연결 시 추후 구현
    }
    
    // MARK: - copyButton 클릭했을 때
    
    @objc
    func copyButtonClicked() {
        /// 우선 지금은 추천인 코드 복사로 구현해 놓음
        guard let filteredStr = originView.recommenderID.text else { return }
        let recommenderID = String(filteredStr.dropFirst())
        UIPasteboard.general.string = recommenderID
        print(UIPasteboard.general.string ?? "")
    }
}
