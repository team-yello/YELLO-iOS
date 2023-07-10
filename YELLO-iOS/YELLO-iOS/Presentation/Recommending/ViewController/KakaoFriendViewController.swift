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
    
    private let kakaoFriendView = KakaoFriendView()
    private let emptyFriendView = EmptyFriendView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

extension KakaoFriendViewController {
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        view.backgroundColor = .black
    }
    
    private func setLayout() {
        if kakaoFriendView.kakaoFriendTableViewModel.isEmpty {
            view.addSubview(emptyFriendView)
            emptyFriendView.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
            }
        } else {
            view.addSubview(kakaoFriendView)
            kakaoFriendView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
}
