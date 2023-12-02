//
//  SchoolFriendViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/07.
//

import UIKit

import Amplitude
import SnapKit
import Then

final class SchoolFriendViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    let schoolFriendView = SchoolFriendView()
    
    // MARK: - Function
    // MARK: LifeCycle    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Amplitude.instance().logEvent("view_recommend_kakao")
        schoolFriendView.updateView()
    }
    
    override func setLayout() {
        let tabbarHeight = 60 + safeAreaBottomInset()
        
        view.addSubview(schoolFriendView)
        schoolFriendView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabbarHeight)
        }
    }
}
