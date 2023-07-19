//
//  KakaoFriendView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class KakaoFriendView: UIView {
    
    // MARK: - Variables
    // MARK: Property
    var fetchingMore = false
    var isFinishPaging = false
    private var initialKakaoDataCount = 10
    var kakaoPage: Int = -1
    var kakaoFriendCount: Int = 0 {
        didSet {
            updateView()
        }
    }
    
    var recommendingKakaoFriendTableViewDummy: [FriendModel] = []

    // MARK: Component
    private let inviteBannerView = InviteBannerView()
    lazy var kakaoFriendTableView = UITableView()
    let refreshControl = UIRefreshControl()
    
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
        
        refreshControl.do {
            kakaoFriendTableView.refreshControl = $0
            $0.tintColor = .grayscales400
            $0.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        }
        
        kakaoFriendTableView.do {
            $0.register(FriendEmptyTableViewCell.self, forCellReuseIdentifier: FriendEmptyTableViewCell.identifier)
            $0.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.identifier)
            $0.backgroundColor = .black
            $0.separatorColor = .grayscales800
            $0.separatorStyle = .singleLine
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    private func setLayout() {
        
        self.addSubviews(
            inviteBannerView,
            kakaoFriendTableView)
        
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
    }
    
    private func setDelegate() {
        kakaoFriendTableView.dataSource = self
        kakaoFriendTableView.delegate = self
    }
    
    // MARK: Objc Function
    @objc func addButtonTapped(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: kakaoFriendTableView)
        guard let indexPath = kakaoFriendTableView.indexPathForRow(at: point) else { return }
        
        recommendingKakaoFriendTableViewDummy[indexPath.row].isButtonSelected = true
        print(recommendingKakaoFriendTableViewDummy[indexPath.row])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.recommendingKakaoFriendTableViewDummy.remove(at: indexPath.row)
            self.kakaoFriendTableView.deleteRows(at: [indexPath], with: .right)
            self.kakaoFriendCount = self.recommendingKakaoFriendTableViewDummy.count
            self.updateView()
        }
        
        recommendingAddFriend(friendId: recommendingKakaoFriendTableViewDummy[indexPath.row].friends.id)
        kakaoFriendTableView.reloadRows(at: [indexPath], with: .none)
        initialKakaoDataCount -= 1
    }
      
    @objc func refreshTable(refresh: UIRefreshControl) {
        self.kakaoPage = -1
        self.isFinishPaging = false
        self.fetchingMore = false
        self.recommendingKakaoFriendTableViewDummy = []
        self.recommendingKakaoFriend()
        refresh.endRefreshing()
        print(self.recommendingKakaoFriendTableViewDummy)
    }
    
    // MARK: Custom Function
    func updateView() {
        if self.kakaoFriendCount == 0 {
            self.inviteBannerView.isHidden = true
        } else {
            self.inviteBannerView.isHidden = false
        }
        self.kakaoFriendTableView.reloadData()
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
        
        var kakaoFriendsUUID: [String] = []
        for i in User.shared.friends {
            kakaoFriendsUUID.append(String(i))
        }
    
        let queryDTO = RecommendingRequestQueryDTO(page: kakaoPage)
        let requestDTO = RecommendingFriendRequestDTO(friendKakaoId: kakaoFriendsUUID)
        
        fetchingMore = true
        
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
                    self.kakaoFriendCount = data.totalCount

                    let friendModels = data.friends.map { recommendingFriend in
                        return FriendModel(
                            friends: Friends(id: recommendingFriend.id, name: recommendingFriend.name, group: recommendingFriend.group, profileImage: recommendingFriend.profileImage),
                            isButtonSelected: false
                        )
                    }
                    
                    self.recommendingKakaoFriendTableViewDummy.append(contentsOf: friendModels)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.kakaoFriendTableView.reloadData()
                    }
                    self.updateView()
                    self.fetchingMore = false
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
}

// MARK: UITableViewDelegate
extension KakaoFriendView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = self.kakaoFriendTableView
        let offsetY = tableView.contentOffset.y
        let contentHeight = tableView.contentSize.height
        let visibleHeight = tableView.bounds.height
        if offsetY > contentHeight - visibleHeight {
                self.recommendingKakaoFriend()
        }
    }
}

// MARK: UITableViewDataSource
extension KakaoFriendView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.kakaoFriendCount == 0 {
            return 1
        } else {
            return recommendingKakaoFriendTableViewDummy.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.kakaoFriendCount == 0 {
            guard let emptyCell = tableView.dequeueReusableCell(withIdentifier: FriendEmptyTableViewCell.identifier, for: indexPath) as? FriendEmptyTableViewCell else { return UITableViewCell() }
            emptyCell.selectionStyle = .none
            return emptyCell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as? FriendTableViewCell else {
                return UITableViewCell()
            }
            
            if tableView.isLast(for: indexPath) {
                DispatchQueue.main.async {
                    cell.addAboveTheBottomBorderWithColor(color: .black)
                }
            }
            
            cell.selectionStyle = .none
            
            if cell.isTapped == true {
                recommendingKakaoFriendTableViewDummy[indexPath.row].isButtonSelected = true
            }
            cell.addButton.removeTarget(nil, action: nil, for: .allEvents)
            
            cell.addButton.setImage(cell.isTapped ? ImageLiterals.Recommending.icAddFriendButtonTapped : ImageLiterals.Recommending.icAddFriendButton, for: .normal)
            cell.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            cell.configureFriendCell(recommendingKakaoFriendTableViewDummy[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // cell의 높이 + inset 8 더한 값
        if self.kakaoFriendCount == 0 {
            return 500
        } else {
            return 77
        }
    }
}
