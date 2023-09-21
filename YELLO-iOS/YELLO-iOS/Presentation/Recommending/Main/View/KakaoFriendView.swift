//
//  KakaoFriendView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/10.
//

import UIKit

import SnapKit
import Then
import KakaoSDKTalk

final class KakaoFriendView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    var fetchingMore = false
    var isRefreshing = false
    var isFinishPaging = false
    var kakaoPage: Int = -1
    var kakaoFriendCount: Int = -1 {
        didSet {
            updateView()
        }
    }
    
    var recommendingKakaoFriendTableViewDummy: [FriendModel] = []
    
    // MARK: Component
    private let inviteBannerView = InviteBannerView()
    lazy var kakaoFriendTableView = UITableView()
    let refreshControl = UIRefreshControl()
    let emptyView = EmptyFriendView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDelegate()
    }

    // MARK: Layout Helpers
    override func setUI() {
        super.setUI()
        updateView()
    }
    
    override func setStyle() {
        self.backgroundColor = .black
        
        inviteBannerView.do {
            $0.isHidden = true
        }
        
        refreshControl.do {
            kakaoFriendTableView.refreshControl = $0
            $0.tintColor = .grayscales400
            $0.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        }
        
        kakaoFriendTableView.do {
            $0.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.identifier)
            $0.register(FriendSkeletonTableViewCell.self, forCellReuseIdentifier: FriendSkeletonTableViewCell.identifier)
            $0.backgroundColor = .black
            $0.separatorColor = .grayscales800
            $0.separatorStyle = .singleLine
            $0.showsVerticalScrollIndicator = false
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 77.adjustedHeight
        }
    }
    
    override func setLayout() {
        
        self.addSubviews(
            inviteBannerView,
            kakaoFriendTableView)
        
        kakaoFriendTableView.addSubviews(emptyView)
        
        inviteBannerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(76.adjustedHeight)
        }
        
        kakaoFriendTableView.snp.makeConstraints {
            $0.top.equalTo(inviteBannerView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

// MARK: - extension
extension KakaoFriendView {
    
    private func setDelegate() {
        kakaoFriendTableView.dataSource = self
        kakaoFriendTableView.delegate = self
    }
    
    // MARK: Objc Function
    @objc func refreshTable(refresh: UIRefreshControl) {
        self.isRefreshing = true
        if kakaoFriendCount == 0 {
            self.inviteBannerView.isHidden = false
            self.emptyView.isHidden = true
        }
        self.kakaoPage = -1
        self.isFinishPaging = false
        self.fetchingMore = false
        self.recommendingKakaoFriendTableViewDummy = []
        self.kakaoFriends { [weak self] in
            /// 새로운 친구 목록이 받아와진 후에 recommendingKakaoFriend 함수 호출
            self?.recommendingKakaoFriend()
            refresh.endRefreshing()
            self?.isRefreshing = false
        }
    }
    
    // MARK: Custom Function
    func updateView() {
        emptyView.viewControllerName = "kakaoFriend"
        inviteBannerView.rootViewName = "kakao"
        if self.kakaoFriendCount == 0 {
            self.inviteBannerView.isHidden = true
            self.emptyView.isHidden = false
        } else {
            self.inviteBannerView.isHidden = false
            self.emptyView.isHidden = true
        }
    }
    
    // MARK: - Network
    func recommendingKakaoFriend() {
        if fetchingMore { // 이미 데이터를 가져오는 중이면 리턴
            return
        }
        
        if isFinishPaging {
            return
        }
        
        self.kakaoPage += 1
        
        let queryDTO = RecommendingRequestQueryDTO(page: self.kakaoPage)
        let requestDTO = RecommendingFriendRequestDTO(friendKakaoId: User.shared.kakaoFriends)
        
        self.fetchingMore = true
        
        if isRefreshing {
            self.kakaoFriendTableView.reloadData()
        }
        
        NetworkService.shared.recommendingService.recommendingKakaoFriend(queryDTO: queryDTO, requestDTO: requestDTO) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    guard let data = data.data else { return }
                    
                    self.kakaoFriendCount = data.totalCount

                    let friendModels = data.friends.map { recommendingFriend in
                        return FriendModel(
                            friends: Friends(id: recommendingFriend.id, name: recommendingFriend.name, group: recommendingFriend.group, profileImage: recommendingFriend.profileImage),
                            isButtonSelected: false
                        )
                    }
                    
                    // 중복되는 모델 필터 처리
                    let uniqueFriendModels = friendModels.filter { model in
                        !self.recommendingKakaoFriendTableViewDummy.contains { $0.friends.id == model.friends.id }
                    }
                    
                    self.recommendingKakaoFriendTableViewDummy.append(contentsOf: uniqueFriendModels)
                    self.fetchingMore = false
                    
                    let totalPage = (data.totalCount) / 100
                    if self.kakaoPage >= totalPage {
                        self.isFinishPaging = true
                    }
                    
                    self.kakaoFriendTableView.reloadData()
                    self.updateView()
                    print("통신 성공")
                default:
                    print("network fail")
                    return
                }
            }
        }
    }
    
    func recommendingAddFriend(friendId: Int) {
        NetworkService.shared.recommendingService.recommendingAddFriend(friendId: friendId) { response in
            print(friendId)
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                
                self.kakaoFriendTableView.reloadData()
                self.updateView()
                print("통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
    
    func kakaoFriends(completion: @escaping () -> Void) {
        TalkApi.shared.friends(limit: 100) { [weak self] (friends, error) in
            if let error = error {
                print(error)
            } else {
                var allFriends: [String] = []
                friends?.elements?.forEach({
                    guard let id = $0.id else { return }
                    allFriends.append(String(id))
                })
                User.shared.kakaoFriends = allFriends
            }
            // 친구 목록 받아오는 작업이 완료된 후, completion 블록을 호출하여 다음 작업 수행
            completion()
        }
    }
}

extension KakaoFriendView: HandleAddFriendButton {
    
    func addButtonTapped(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: kakaoFriendTableView)
        guard let indexPath = kakaoFriendTableView.indexPathForRow(at: point) else { return }
        
        // 삭제 서버통신
        recommendingAddFriend(friendId: recommendingKakaoFriendTableViewDummy[indexPath.row].friends.id)
        
        recommendingKakaoFriendTableViewDummy[indexPath.row].isButtonSelected = true
        sender.setImage(ImageLiterals.Recommending.icAddFriendButtonTapped, for: .disabled)
        sender.isEnabled = false
        
        // 스냅샷에서 해당 아이템 삭제
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.recommendingKakaoFriendTableViewDummy.remove(at: indexPath.row)
            self.kakaoFriendCount = self.recommendingKakaoFriendTableViewDummy.count
            self.kakaoFriendTableView.deleteRows(at: [indexPath], with: .right)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.kakaoFriendTableView.reloadData()
            }
            self.updateView()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sender.isEnabled = true
            sender.setImage(ImageLiterals.Recommending.icAddFriendButton, for: .normal)
        }
    }
}

// MARK: UITableViewDelegate
extension KakaoFriendView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = self.kakaoFriendTableView
        let offsetY = tableView.contentOffset.y
        let contentHeight = tableView.contentSize.height
        let visibleHeight = tableView.bounds.height
        if offsetY > contentHeight - visibleHeight {
            self.kakaoFriends { [weak self] in
                 // 새로운 친구 목록이 받아와진 후에 recommendingKakaoFriend 함수 호출
                 self?.recommendingKakaoFriend()
             }
        }
    }
}

// MARK: UITableViewDataSource
extension KakaoFriendView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fetchingMore {
            return 10 // Skeleton 셀 개수
        } else {
            return recommendingKakaoFriendTableViewDummy.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if fetchingMore {
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendSkeletonTableViewCell.identifier, for: indexPath) as! FriendSkeletonTableViewCell
            cell.selectionStyle = .none
            cell.showShimmer()
            return cell
        } else {
            if indexPath.row < recommendingKakaoFriendTableViewDummy.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as! FriendTableViewCell
                
                cell.selectionStyle = .none
                
                cell.isTapped = self.recommendingKakaoFriendTableViewDummy[indexPath.row].isButtonSelected
                cell.updateAddButtonImage()
                
                cell.handleAddFriendButton = self
                cell.configureFriendCell(self.recommendingKakaoFriendTableViewDummy[indexPath.row])
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}