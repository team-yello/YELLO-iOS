//
//  SchoolFriendView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/10.
//

import UIKit

import SnapKit
import SkeletonView
import Then

final class SchoolFriendView: UIView {
    
    // MARK: - Variables
    // MARK: Property
    var fetchingMore = false
    var isFinishPaging = false
    var schoolPage: Int = -1
    var schoolFriendCount: Int = -1 {
        didSet {
            updateView()
        }
    }
    
    var dataSource: UITableViewDiffableDataSource<Int, FriendModel>!
    var recommendingSchoolFriendTableViewDummy: [FriendModel] = []
    
    // MARK: Component
    private let inviteBannerView = InviteBannerView()
    lazy var schoolFriendTableView = UITableView()
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
extension SchoolFriendView {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
        updateView()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
        self.isSkeletonable = true
        
        inviteBannerView.do {
            $0.isHidden = true
        }
        
        refreshControl.do {
            schoolFriendTableView.refreshControl = $0
            $0.tintColor = .grayscales400
            $0.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        }
        
        schoolFriendTableView.do {
            $0.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.identifier)
            $0.backgroundColor = .clear
            $0.separatorColor = .grayscales800
            $0.separatorStyle = .singleLine
            $0.showsVerticalScrollIndicator = false
        }
        configureSchoolFriendDataSource()
    }
    
    private func setLayout() {
        
        self.addSubviews(inviteBannerView,
                         schoolFriendTableView)
        
        schoolFriendTableView.addSubviews(emptyView)
        
        inviteBannerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(76)
        }
        
        schoolFriendTableView.snp.makeConstraints {
            $0.top.equalTo(inviteBannerView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        schoolFriendTableView.dataSource = dataSource
        schoolFriendTableView.delegate = self
    }
    
    private func configureSchoolFriendDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, FriendModel>(tableView: schoolFriendTableView) { [weak self] (tableView, indexPath, kakaoFriend) -> UITableViewCell? in
            guard let self = self else {
                return UITableViewCell()
            }
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as? FriendTableViewCell else {
                return UITableViewCell()
            }
            self.dataSource.defaultRowAnimation = .none
            let skeletonAnimation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
            cell.showAnimatedGradientSkeleton(usingGradient: .init(colors: [.grayscales700, .grayscales800]), animation: skeletonAnimation, transition: .none)
            cell.selectionStyle = .none

            cell.isTapped = self.recommendingSchoolFriendTableViewDummy[indexPath.row].isButtonSelected
            cell.updateAddButtonImage()
            
            cell.handleAddFriendButton = self
            if self.recommendingSchoolFriendTableViewDummy.isEmpty {
                return cell
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                cell.hideSkeleton() // 스켈레톤 효과 숨기기
                self.dataSource.defaultRowAnimation = .none
                cell.configureFriendCell(self.recommendingSchoolFriendTableViewDummy[indexPath.row])
            }
            
            return cell
        }
    }
    
    func applySnapshot(animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, FriendModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(recommendingSchoolFriendTableViewDummy, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    // MARK: Objc Function
    @objc func refreshTable(refresh: UIRefreshControl) {
        self.schoolPage = -1
        self.isFinishPaging = false
        self.fetchingMore = false
        self.recommendingSchoolFriendTableViewDummy = []
        self.recommendingSchoolFriend()
        if self.fetchingMore == true {
            print("기다리삼")
            self.applySnapshot(animated: true)
        }
        refresh.endRefreshing()
    }
    
    // MARK: Custom Function
    /// 친구가 없을 때 초대 뷰를 띄우는 로직
    func updateView() {
        if self.schoolFriendCount == 0 {
            self.inviteBannerView.isHidden = true
            self.emptyView.isHidden = false
        } else {
            self.inviteBannerView.isHidden = false
            self.emptyView.isHidden = true
        }
    }
    
    // MARK: - Network
    func recommendingSchoolFriend() {
        if fetchingMore { // 이미 데이터를 가져오는 중이면 리턴
            return
        }
        
        if isFinishPaging {
            return
        }
        
        self.schoolPage += 1
        let queryDTO = RecommendingRequestQueryDTO(page: schoolPage)
        
        fetchingMore = true
        
        NetworkService.shared.recommendingService.recommendingSchoolFriend(queryDTO: queryDTO) { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    guard let data = data.data else { return }
                    
                    let totalPage = (data.totalCount) / 10
                    if self.schoolPage >= totalPage {
                        self.isFinishPaging = true
                    }
                    
                    self.schoolFriendCount = data.totalCount
                    
                    let friendModels = data.friends.map { recommendingFriend in
                        return FriendModel(
                            friends: Friends(id: recommendingFriend.id, name: recommendingFriend.name, group: recommendingFriend.group, profileImage: recommendingFriend.profileImage),
                            isButtonSelected: false
                        )
                    }
                    
                    // 중복되는 모델 필터 처리
                    let uniqueFriendModels = friendModels.filter { model in
                        !self.recommendingSchoolFriendTableViewDummy.contains { $0.friends.id == model.friends.id }
                    }
                    
                    self.recommendingSchoolFriendTableViewDummy.append(contentsOf: uniqueFriendModels)
                    self.applySnapshot(animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.fetchingMore = false
                    }
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
                
                self.schoolFriendTableView.reloadData()
                self.updateView()
                print("통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
}

extension SchoolFriendView: HandleAddFriendButton {

// MARK: Objc Function
    @objc func addButtonTapped(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: schoolFriendTableView)
        guard let indexPath = schoolFriendTableView.indexPathForRow(at: point) else { return }
        
        // 삭제 서버통신
        recommendingAddFriend(friendId: recommendingSchoolFriendTableViewDummy[indexPath.row].friends.id)
        
        // 추가할 아이템의 식별자 가져오기
        let itemToAdd = self.recommendingSchoolFriendTableViewDummy[indexPath.row]
        
        recommendingSchoolFriendTableViewDummy[indexPath.row].isButtonSelected = true
        sender.setImage(ImageLiterals.Recommending.icAddFriendButtonTapped, for: .disabled)
        sender.isEnabled = false
        
        // 스냅샷에서 해당 아이템 삭제
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.dataSource.defaultRowAnimation = .right
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([itemToAdd])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            self.recommendingSchoolFriendTableViewDummy.remove(at: indexPath.row)
            self.schoolFriendCount = self.recommendingSchoolFriendTableViewDummy.count
            self.dataSource.defaultRowAnimation = .middle
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sender.isEnabled = true
            sender.setImage(ImageLiterals.Recommending.icAddFriendButton, for: .normal)
        }
    }
}

// MARK: UITableViewDelegate
extension SchoolFriendView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = self.schoolFriendTableView
        let offsetY = tableView.contentOffset.y
        let contentHeight = tableView.contentSize.height
        let visibleHeight = tableView.bounds.height
        if offsetY > contentHeight - visibleHeight {
            self.recommendingSchoolFriend()
        }
    }
}

// MARK: UITableViewDataSource
extension SchoolFriendView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendingSchoolFriendTableViewDummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
}

extension SchoolFriendView: SkeletonTableViewDataSource {
  // skeletonView
  func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
    return FriendTableViewCell.identifier
  }
  
  func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
    skeletonView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath)
  }
  
  func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
}
