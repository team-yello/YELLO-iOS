//
//  FriendSearchViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/02.
//

import UIKit

import SnapKit
import Then

final class FriendSearchViewController: BaseViewController {
    
    private let friendSearchView = FriendSearchView()
    var allFriend: [Friend] = []
    var pageCount = 0
    var totalItemCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setAddTarget()
        self.tabBarController?.tabBar.isHidden = true
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        friendSearchView.friendSearchTextfield.becomeFirstResponder()
    }
    
    override func setLayout() {
        view.addSubviews(friendSearchView)
        
        friendSearchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        friendSearchView.friendSearchNavigationBarView.handleBackButtonDelegate = self
        friendSearchView.friendSearchTextfield.delegate = self
        friendSearchView.friendSearchResultTableView.delegate = self
        friendSearchView.friendSearchResultTableView.dataSource = self
    }
    
    private func setAddTarget() {
        friendSearchView.friendSearchTextfield.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func searchFriend(_ word: String) {
        let queryDTO: FriendSearchRequestQueryDTO = FriendSearchRequestQueryDTO(keyword: word, page: pageCount)
        NetworkService.shared.searchService.friendSearch(queryDTO: queryDTO) { result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                self.allFriend.append(contentsOf: data.friendList)
                self.totalItemCount = data.totalCount
                self.friendSearchView.friendSearchResultTableView.reloadData()
            default:
                print(ErrorPointer.self)
                return
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = self.friendSearchView.friendSearchResultTableView
        let offsetY = tableView.contentOffset.y
        let contentHeight = tableView.contentSize.height
        let visibleHeight = tableView.bounds.height
        self.friendSearchView.friendSearchTextfield.endEditing(true)
        if offsetY > contentHeight - visibleHeight, allFriend.count < totalItemCount {
            pageCount += 1
            guard let text = friendSearchView.friendSearchTextfield.text else { return }
            searchFriend(text)
        }
    }
    
    // MARK: Objc Function
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        pageCount = 0
        allFriend.removeAll()
        searchFriend(text)
    }
}

extension FriendSearchViewController: UITextFieldDelegate { }

// MARK: HandleBackButtonDelegate
extension FriendSearchViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension FriendSearchViewController: UITableViewDelegate { }
extension FriendSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFriend.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendSearchTableViewCell.identifier, for: indexPath) as? FriendSearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.handleSearchAddFriendButton = self
        cell.selectionStyle = .none
        cell.configureFriendCell(allFriend[indexPath.row])
        return cell
    }
}

extension FriendSearchViewController: HandleSearchAddFriendButton {
    func addButtonTapped() {
        print("친구 추가 서버 통신 함수 추가")
    }
}
