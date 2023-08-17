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
        setDelegate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Amplitude.instance().logEvent("view_timeline")
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setDelegate() {
        aroundView.aroundTableView.delegate = self
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
}

extension AroundViewController: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("🏁스크롤 이벤트 감지")
        Amplitude.instance().logEvent("scroll_timeline")
    }
}
