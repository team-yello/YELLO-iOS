//
//  FriendSearchView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/02.
//

import UIKit

import Lottie
import SnapKit
import Then

final class FriendSearchView: BaseView {
    
    let friendSearchNavigationBarView = SettingNavigationBarView()
    let friendSearchTextfield = YelloTextField(state: .search)
    let friendSearchResultTableView = UITableView()
    let friendSearchController = UISearchController(searchResultsController: nil)
    
    let loadingStackView = UIStackView()
    let loadingLabel = UILabel()
    let loadingAnimationView = LottieAnimationView(name: "spinner_loading")
    
    let noResultView = UIView()
    let noResultImageView = UIImageView()
    let noResultLabel = UILabel()
    
    override func setStyle() {
        
        loadingStackView.do {
            $0.axis = .vertical
            $0.spacing = 4.adjustedHeight
            $0.addArrangedSubviews(loadingAnimationView, loadingLabel)
            $0.isHidden = true
        }
        
        loadingLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Recommending.Search.loading, lineHeight: 20.adjustedHeight)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales300
        }
        
        friendSearchNavigationBarView.do {
            $0.titleLabel.setTextWithLineHeight(text: StringLiterals.Recommending.Search.title, lineHeight: 24.adjustedHeight)
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
            $0.rowHeight = 90.adjustedHeight
            $0.separatorStyle = .singleLine
            $0.separatorColor = .grayscales800
            $0.register(FriendSearchTableViewCell.self, forCellReuseIdentifier: FriendSearchTableViewCell.identifier)
            $0.backgroundColor = .black
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
        }
        
        noResultImageView.do {
            $0.image = ImageLiterals.Recommending.imgSearchNoResult
            $0.contentMode = .scaleAspectFit
        }
        
        noResultLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Recommending.Search.searching, lineHeight: 20.adjustedHeight)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales300
        }
        
        noResultView.do {
            $0.isHidden = true
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
                         friendSearchResultTableView,
                         loadingStackView,
                         noResultView)
        
        noResultView.addSubviews(noResultLabel, noResultImageView)
        
        friendSearchNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        friendSearchTextfield.snp.makeConstraints {
            $0.top.equalTo(friendSearchNavigationBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(52.adjustedHeight)
        }
        
        friendSearchResultTableView.snp.makeConstraints {
            $0.top.equalTo(friendSearchTextfield.snp.bottom).offset(4.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.bottom.equalToSuperview()
        }
        
        noResultImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(43.adjusted)
        }
        
        noResultLabel.snp.makeConstraints {
            $0.top.equalTo(noResultImageView.snp.bottom).offset(12.adjustedHeight)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        noResultView.snp.makeConstraints {
            $0.top.equalTo(friendSearchResultTableView).offset(90.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(148.adjustedWidth)
            $0.height.equalTo(75.adjustedHeight)
        }
        
        loadingStackView.snp.makeConstraints {
            $0.top.equalTo(friendSearchResultTableView).offset(90.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(127.adjustedWidth)
            $0.height.equalTo(64.adjustedHeight)
        }
        
        loadingAnimationView.snp.makeConstraints {
            $0.width.height.equalTo(40.adjusted)
        }
    }
}
