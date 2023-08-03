//
//  FriendSearchView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/02.
//

import UIKit

import SnapKit
import Then

final class FriendSearchView: BaseView {
    
    let friendSearchNavigationBarView = SettingNavigationBarView()
    let friendSearchTextfield = YelloTextField(state: .search)
    let friendSearchResultTableView = UITableView()
    let friendSearchController = UISearchController(searchResultsController: nil)
    
    override func setStyle() {
        friendSearchNavigationBarView.do {
            $0.titleLabel.setTextWithLineHeight(text: StringLiterals.Recommending.Search.title, lineHeight: 24)
        }
        
        friendSearchTextfield.do {
            $0.makeBorder(width: 0, color: .grayscales600)
            $0.backgroundColor = .grayscales800
            $0.font = .uiBodySmall
            $0.textColor = .white
            $0.placeholder = StringLiterals.Recommending.Search.placeholder
            $0.setPlaceholderColor(.grayscales300)
            $0.searchImageView.image = ImageLiterals.Recommending.icSearchWhite
            $0.tintColor = .white
        }
        
        friendSearchResultTableView.do {
            $0.rowHeight = 90
            $0.separatorStyle = .singleLine
//            $0.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
            $0.backgroundColor = .black
            
        }
    }
    
    override func setLayout() {
        
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        self.addSubviews(friendSearchNavigationBarView,
                         friendSearchTextfield,
                         friendSearchResultTableView)
        
        friendSearchNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        friendSearchTextfield.snp.makeConstraints {
            $0.top.equalTo(friendSearchNavigationBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
        
        friendSearchResultTableView.snp.makeConstraints {
            $0.top.equalTo(friendSearchTextfield.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
}
