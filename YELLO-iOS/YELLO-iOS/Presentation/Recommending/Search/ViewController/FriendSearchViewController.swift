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
    
    // MARK: - Variables
    // MARK: Property
    var fetchingMore = false
    var isFinishPaging = false

    private let friendSearchView = FriendSearchView()
    var allFriend: [Friend] = []
    var pageCount = -1
    var totalItemCount = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setAddTarget()
        self.tabBarController?.tabBar.isHidden = true
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
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
        if fetchingMore { // 이미 데이터를 가져오는 중이면 리턴
            return
        }
        
        if isFinishPaging {
            return
        }
        
        self.pageCount += 1
        let queryDTO: FriendSearchRequestQueryDTO = FriendSearchRequestQueryDTO(keyword: word, page: pageCount)
        
        self.fetchingMore = true

        NetworkService.shared.searchService.friendSearch(queryDTO: queryDTO) { result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                self.allFriend.append(contentsOf: data.friendList)
                self.totalItemCount = data.totalCount
                self.fetchingMore = false
                self.friendSearchView.friendSearchResultTableView.reloadData()
                
                let totalPage = (data.totalCount) / 10
                if self.pageCount >= totalPage {
                    self.isFinishPaging = true
                }
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
        if offsetY > contentHeight - visibleHeight {
            guard let text = friendSearchView.friendSearchTextfield.text else { return }
            searchFriend(text)
        }
    }
    
    // MARK: Objc Function
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        pageCount = -1
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
