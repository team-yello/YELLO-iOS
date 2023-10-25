//
//  AroundViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/05.
//

import UIKit

import Amplitude
import SnapKit
import Then

// MARK: - Around
final class AroundViewController: BaseViewController {

    // MARK: - Variables
    // MARK: Component
    let aroundView = AroundView()

    // MARK: - Function
    // MARK: LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Amplitude.instance().logEvent("view_timeline")
        aroundView.scrollCount = 0 
        self.tabBarController?.tabBar.isHidden = false
    }

    // MARK: Layout Helpers
    override func setLayout() {
        view.addSubviews(aroundView)
        
        let tabbarHeight = 60 + safeAreaBottomInset()
        
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        aroundView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().inset(tabbarHeight)
        }
    }
}
