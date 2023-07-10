//
//  MyProfileHeaderView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class MyProfileHeaderView: UITableViewHeaderFooterView {
    
    private let myProfileView = MyProfileView()
    private let friendCountView = FriendCountView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyProfileHeaderView {
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
        backgroundView?.backgroundColor = .clear
    }
    
    private func setLayout() {
        self.addSubviews(myProfileView,
                        friendCountView)
        
        myProfileView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12.adjusted)
            $0.leading.trailing.equalToSuperview()
        }
        
        friendCountView.snp.makeConstraints {
            $0.top.equalTo(myProfileView.snp.bottom).offset(32.adjusted)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8.adjusted)
        }
    }
}
