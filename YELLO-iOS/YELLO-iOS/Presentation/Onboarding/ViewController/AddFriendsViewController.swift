//
//  AddFriendsViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/07.
//

import UIKit

import SnapKit
import Then

class AddFriendsViewController: OnboardingBaseViewController {
    // MARK: - Variables
    var pageCount = 0
    var friendsKakaoID = [
        "121", "122", "123", "124", "125", "126", "127", "128", "129", "130"
    ]
    var groupId = 12
    // MARK: Component
    let baseView = AddFriendsView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        addFriends()
        super.viewDidLoad()
        super.nextViewController = RecommendIdViewController()
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
    
    func addFriends() {
        let queryDTO = JoinedFriendsRequestQueryDTO(page: pageCount)
        let requestDTO = JoinedFriendsRequestDTO(friendKakaoID: friendsKakaoID, groupID: groupId)
        
        NetworkService.shared.onboardingService.postJoinedFriends(queryDTO: queryDTO, requestDTO: requestDTO) { result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                self.baseView.joinedFriendsList = data.friendList
            default:
                return
            }
        }
    }
}

/// 프리패칭
/// 스크롤이 맨 밑에 있으면 함수
/// indexpath
/// 한번에 몇개 갖고 있을지랑, pagef를
