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

final class KakaoFriendView: UIView {
    
    // MARK: - Variables
    // MARK: Property
    var fetchingMore = false
    var isFinishPaging = false
    var kakaoPage: Int = -1
    var kakaoFriendCount: Int = -1
    
    var dataSource: UITableViewDiffableDataSource<Int, FriendModel>!
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
        setUI()
        setDelegate()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - extension
extension KakaoFriendView {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
        updateView()
    }
    
    private func setStyle() {
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
            $0.backgroundColor = .clear
            $0.separatorColor = .grayscales800
            $0.separatorStyle = .singleLine
            $0.showsVerticalScrollIndicator = false
        }
        configureKakaoFriendDataSource()
    }
    
    private func setLayout() {
        
        self.addSubviews(
            inviteBannerView,
            kakaoFriendTableView)
        
        kakaoFriendTableView.addSubviews(emptyView)
        
        inviteBannerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(76)
        }
        
        kakaoFriendTableView.snp.makeConstraints {
            $0.top.equalTo(inviteBannerView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        kakaoFriendTableView.dataSource = dataSource
        kakaoFriendTableView.delegate = self
    }
    
    private func configureKakaoFriendDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, FriendModel>(tableView: kakaoFriendTableView) { [weak self] (tableView, indexPath, kakaoFriend) -> UITableViewCell? in
            guard let self = self else {
                return UITableViewCell()
            }
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as? FriendTableViewCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            
            print(recommendingKakaoFriendTableViewDummy)

            if recommendingKakaoFriendTableViewDummy.isEmpty {
                return cell
            }
            
            cell.isTapped = recommendingKakaoFriendTableViewDummy[indexPath.row].isButtonSelected
            cell.updateAddButtonImage()
            
            cell.handleAddFriendButton = self
            cell.configureFriendCell(recommendingKakaoFriendTableViewDummy[indexPath.row])
            return cell
        }
    }
    
    func applySnapshot(animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, FriendModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(recommendingKakaoFriendTableViewDummy, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    // MARK: Objc Function
    @objc func refreshTable(refresh: UIRefreshControl) {
        self.kakaoPage = -1
        self.isFinishPaging = false
        self.fetchingMore = false
        self.recommendingKakaoFriendTableViewDummy = []
        self.kakaoFriends { [weak self] in
             /// 새로운 친구 목록이 받아와진 후에 recommendingKakaoFriend 함수 호출
             self?.recommendingKakaoFriend()
             if self?.fetchingMore == true {
                 print("기다리삼")
                 self?.applySnapshot(animated: true)
             }
             refresh.endRefreshing()
         }
    }
    
    // MARK: Custom Function
    func updateView() {
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
        
        NetworkService.shared.recommendingService.recommendingKakaoFriend(queryDTO: queryDTO, requestDTO: requestDTO) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    guard let data = data.data else { return }
                    
                    let totalPage = (data.totalCount) / 10
                    if self.kakaoPage >= totalPage {
                        self.isFinishPaging = true
                    }
                    
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.fetchingMore = false
                    }
                    
                    self.kakaoFriendCount = data.totalCount
                    self.applySnapshot(animated: true)
                    print(self.recommendingKakaoFriendTableViewDummy)
                    print(data.totalCount)
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
        
        // 추가할 아이템의 식별자 가져오기
        let itemToAdd = self.recommendingKakaoFriendTableViewDummy[indexPath.row]
        
        recommendingKakaoFriendTableViewDummy[indexPath.row].isButtonSelected = true
        sender.setImage(ImageLiterals.Recommending.icAddFriendButtonTapped, for: .disabled)
        sender.isEnabled = false
        
        // 스냅샷에서 해당 아이템 삭제
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.dataSource.defaultRowAnimation = .right
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([itemToAdd])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            self.recommendingKakaoFriendTableViewDummy.remove(at: indexPath.row)
            self.kakaoFriendCount = self.recommendingKakaoFriendTableViewDummy.count
            self.dataSource.defaultRowAnimation = .middle
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
        return recommendingKakaoFriendTableViewDummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
}
