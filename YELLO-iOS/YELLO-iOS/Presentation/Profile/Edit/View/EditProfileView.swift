//
//  EditProfileView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 1/25/24.
//

import UIKit

import SnapKit
import Then

class EditProfileView: UIView {
    
    // MARK: - Variables
    // MARK: Component
    let navigationBarView = NavigationBarView()
    let editHeaderView = EditProfileHeaderView()
    let profileTableView = UITableView(frame: .zero, style: .grouped)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setStlye()
        setLayout()
    }
    
    private func setStlye() {
        self.backgroundColor = .black
        
        profileTableView.do {
            $0.backgroundColor = .clear
            $0.register(EditProfileTableViewCell.self, forCellReuseIdentifier: EditProfileTableViewCell.reusableId)
            $0.register(EditProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: EditProfileHeaderView.reusableId)
            $0.rowHeight = 75.adjustedHeight
        }
    }
    
    private func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        self.addSubviews(navigationBarView, profileTableView)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        profileTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
        }
    }
}
