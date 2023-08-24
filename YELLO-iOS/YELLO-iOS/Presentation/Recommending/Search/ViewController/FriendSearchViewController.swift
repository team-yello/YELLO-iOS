//
//  FriendSearchViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/02.
//

import UIKit

import Amplitude
import SnapKit
import Then

final class FriendSearchViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Property
    var fetchingMore = false
    var isFinishPaging = false
    var isScroll = false

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
        if !self.isScroll {
            self.friendSearchView.noResultView.isHidden = true
            self.friendSearchView.friendSearchResultTableView.isHidden = true
            friendSearchView.loadingStackView.isHidden = false
            friendSearchView.loadingAnimationView.play()
            friendSearchView.loadingAnimationView.loopMode = .loop
        }
        
        NetworkService.shared.searchService.friendSearch(queryDTO: queryDTO) { result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                self.allFriend.append(contentsOf: data.friendList)
                self.fetchingMore = false
                
                if !self.isScroll {
                    self.friendSearchView.loadingAnimationView.stop()
                    self.friendSearchView.friendSearchResultTableView.isHidden = false
                    self.friendSearchView.loadingStackView.isHidden = true
                }
                
                self.totalItemCount = data.totalCount
                if data.totalCount == 0 {
                    self.friendSearchView.noResultView.isHidden = false
                } else {
                    self.friendSearchView.noResultView.isHidden = true
                }
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
        self.isScroll = true
        let tableView = self.friendSearchView.friendSearchResultTableView
        let offsetY = tableView.contentOffset.y
        let contentHeight = tableView.contentSize.height
        let visibleHeight = tableView.bounds.height
        self.friendSearchView.friendSearchTextfield.endEditing(true)
        if offsetY > contentHeight - visibleHeight {
            guard let text = friendSearchView.friendSearchTextfield.text else { return }
            searchFriend(text)
        }
        self.isScroll = false
    }
    
    func addFriend(friendId: Int) {
        NetworkService.shared.recommendingService.recommendingAddFriend(friendId: friendId) { response in
            print(friendId)
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                Amplitude.instance().logEvent("click_search_addfriend")
                print("통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
}

extension FriendSearchViewController: UITextFieldDelegate {
    
    // MARK: Objc Function
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        isFinishPaging = false
        pageCount = -1
        allFriend.removeAll()
        searchFriend(text)
        
        // 아무것도 검색하지 않았을 때 아무것도 뜨지 않게 처리
        if text.isEmpty {
            allFriend.removeAll()
            self.friendSearchView.noResultView.isHidden = true
            self.friendSearchView.loadingStackView.isHidden = true
        }
    }
}

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
        
        if indexPath.row < allFriend.count {
            cell.handleSearchAddFriendButton = self
            cell.selectionStyle = .none
            cell.configureFriendCell(allFriend[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension FriendSearchViewController: HandleSearchAddFriendButton {
    func addButtonTapped(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: friendSearchView.friendSearchResultTableView)
        guard let indexPath = friendSearchView.friendSearchResultTableView.indexPathForRow(at: point) else { return }
        
        // 삭제 서버통신
        addFriend(friendId: allFriend[indexPath.row].id)
    }
}
