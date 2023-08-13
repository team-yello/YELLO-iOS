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
    let animationView = LottieAnimationView(name: "spinner_loading")
    let noResultStackView = UIStackView()
    let noResultImageView = UIImageView()
    let noResultLabel = UILabel()
    
    override func setStyle() {
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
            $0.delegate = self
            $0.dataSource = self
            $0.showsVerticalScrollIndicator = false
        }
        
        noResultStackView.do {
            $0.axis = .vertical
            $0.spacing = 12.adjustedHeight
            $0.addArrangedSubviews(noResultImageView, noResultLabel)
        }
        
        noResultImageView.do {
            $0.image = ImageLiterals.Recommending.imgSearchNoResult
        }
        
        noResultLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Recommending.Search.searching, lineHeight: 20.adjustedHeight)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales700
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
    }
}

extension FriendSearchView: UITableViewDelegate { }
extension FriendSearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendSearchTableViewCell.identifier, for: indexPath) as? FriendSearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.handleSearchAddFriendButton = self
        cell.selectionStyle = .none
//        cell.configureFriendCell([indexPath.row])
        return cell
    }
}

extension FriendSearchView: HandleSearchAddFriendButton {
    func addButtonTapped() {
        print("친구 추가 서버 통신 함수 추가")
    }
}
