//
//  AddFriendsViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/07.
//

import UIKit

import SnapKit
import Then

struct FriendAdd {
    var friendInfo: OnboardingFriendList
    var isAdded: Bool
}

class AddFriendsViewController: OnboardingBaseViewController {
    // MARK: - Variables
    var isFinishPaging = false
    var isLoadingData = false
    
    var pageCount = -1
    var friendsKakaoID: [String] = []
    var groupId = User.shared.groupId
    
    var data: JoinedFriendsResponseDTO?
    var addFriends: [FriendAdd] = []
    var totalItemCount = 0
    
    // MARK: Component
    let baseView = AddFriendsView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        getJoinedFriends()
        super.viewDidLoad()
        super.nextViewController = RecommendIdViewController()
        baseView.friendsTableView.delegate = self
        baseView.friendsTableView.prefetchDataSource = self
        
    }
    
    // MARK: Layout Helpers
    override func setStyle() {
        super.nextButton.setButtonEnable(state: true)
    }
    
    override func setLayout() {
        view.addSubview(baseView)
        
        baseView.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        view.bringSubviewToFront(super.nextButton)
    }
    
    func getJoinedFriends() {
        pageCount += 1
        let queryDTO = JoinedFriendsRequestQueryDTO(page: pageCount)
        let requestDTO = JoinedFriendsRequestDTO(friendKakaoID: friendsKakaoID, groupID: groupId)
        
        if isFinishPaging {
            return
        }
        
        isLoadingData = true
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            NetworkService.shared.onboardingService.postJoinedFriends(queryDTO: queryDTO, requestDTO: requestDTO) { [weak self] result in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.isLoadingData = false
                    
                    switch result {
                    case .success(let data):
                        guard let data = data.data else { return }
                        self.data = data
                        
                        let totalPage = (data.totalCount) / 10
                        if self.pageCount >= totalPage {
                            self.isFinishPaging = true
                        }
                        
                        data.friendList.forEach {
                            self.baseView.joinedFriendsList.append(FriendAdd(friendInfo: $0, isAdded: false))
                        }
                        if self.pageCount == 0 { self.baseView.count = data.totalCount }
                        
                        self.baseView.friendsTableView.reloadData()
                    default:
                        print("Failed to load joined friends")
                    }
                }
            }
        }
    }

}

extension AddFriendsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if let lastIndexPath = indexPaths.last,
           lastIndexPath.row >= baseView.joinedFriendsList.count - 1 {
            getJoinedFriends()
        }
    }
}

extension AddFriendsViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = self.baseView.friendsTableView
        let offsetY = tableView.contentOffset.y
        let contentHeight = tableView.contentSize.height
        let visibleHeight = tableView.bounds.height
        if offsetY > contentHeight - visibleHeight {
            getJoinedFriends()
        }
    }
}
