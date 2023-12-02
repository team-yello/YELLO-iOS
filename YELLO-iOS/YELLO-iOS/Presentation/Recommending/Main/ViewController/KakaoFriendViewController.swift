//
//  KakaoFriendViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/07.
//

import UIKit

import SnapKit
import Then
import Amplitude

final class KakaoFriendViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    let kakaoFriendView = KakaoFriendView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        Amplitude.instance().logEvent("view_recommend_kakao")
        super.viewDidLoad()
    }
    
    override func setLayout() {
        let tabbarHeight = 60 + safeAreaBottomInset()
        
        view.addSubview(kakaoFriendView)
        kakaoFriendView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabbarHeight)
        }
    }
}
