//
//  KakaoFriendViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

final class KakaoFriendViewController: UIViewController {
    
    // MARK: - Variables
    // MARK: Component
    private let kakaoFriendView = KakaoFriendView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

// MARK: - extension
extension KakaoFriendViewController {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        view.backgroundColor = .black
    }
    
    private func setLayout() {
        view.addSubview(kakaoFriendView)
        kakaoFriendView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
