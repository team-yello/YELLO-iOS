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
    
    var recommendingKakaoFriendTableViewDummy: [FriendModel] = []

    // MARK: Component
    private let inviteBannerView = InviteBannerView()
    private let emptyFriendView = EmptyFriendView()
    lazy var kakaoFriendTableView = UITableView()
    
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
        
        kakaoFriendTableView.do {
            $0.rowHeight = 77
            $0.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.identifier)
            $0.backgroundColor = .black
            $0.separatorColor = .grayscales800
            $0.separatorStyle = .singleLine
            $0.showsVerticalScrollIndicator = false
        }
        
        emptyFriendView.do {
            $0.isHidden = true
        }
    }
    
    private func setLayout() {
        
        self.addSubviews(
            inviteBannerView,
            kakaoFriendTableView,
            emptyFriendView)
        
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
        
        emptyFriendView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
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
            self.updateView()
        }
        
        recommendingAddFriend(friendId: recommendingKakaoFriendTableViewDummy[indexPath.row].friends.id)
        kakaoFriendTableView.reloadRows(at: [indexPath], with: .none)
        initialKakaoDataCount -= 1
    }
    
    // MARK: Custom Function
    func updateView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if self.recommendingKakaoFriendTableViewDummy.isEmpty {
                self.inviteBannerView.isHidden = true
                self.kakaoFriendTableView.isHidden = true
                self.emptyFriendView.isHidden = false
                
            } else {
                self.inviteBannerView.isHidden = false
                self.kakaoFriendTableView.isHidden = false
                self.emptyFriendView.isHidden = true
            }
        }
    }
    
    // MARK: - Network
    func recommendingKakaoFriend() {
        if fetchingMore { // 이미 데이터를 가져오는 중이면 리턴
            return
        }
        self.kakaoPage += 1
    
        let queryDTO = RecommendingRequestQueryDTO(page: kakaoPage)
        let requestDTO = RecommendingFriendRequestDTO(friendKakaoId: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"])
        
        if isFinishPaging {
            return
        }
        
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
                    
                    
                    let friendModels = data.friends.map { recommendingFriend in
                        return FriendModel(
                            friends: Friends(id: recommendingFriend.id, name: recommendingFriend.name, group: recommendingFriend.group, profileImage: recommendingFriend.profileImage),
                            isButtonSelected: false
                        )
                    }
                    
                    self.recommendingKakaoFriendTableViewDummy.append(contentsOf: friendModels)
                    self.kakaoFriendTableView.reloadData()
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
        return recommendingKakaoFriendTableViewDummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
