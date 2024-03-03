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
final class AroundViewController: UIViewController {

    // MARK: - Variables
    // MARK: Component
    let aroundView = AroundView()

    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Amplitude.instance().logEvent("view_timeline")
        aroundView.scrollCount = 0 
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(changeMode(_:)), name: NSNotification.Name("changeMode"), object: nil)
        self.tabBarController?.tabBar.items?[2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("changeMode"), object: nil)
    }
    
}

// MARK: - extension
extension AroundViewController {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        view.backgroundColor = .black
    }
    
    private func setLayout() {
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
    
    @objc
    private func changeMode(_ notification: Notification) {
        self.aroundView.isUserSenderVote = true
    }
}
