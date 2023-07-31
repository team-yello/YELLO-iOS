//
//  SchoolFriendView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class SchoolFriendView: UIView {
    
    // MARK: - Variables
    // MARK: Property
    var fetchingMore = false
    var isFinishPaging = false
    var schoolPage: Int = -1
    var schoolFriendCount: Int = 0 {
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
        
        refreshControl.do {
            schoolFriendTableView.refreshControl = $0
            $0.tintColor = .grayscales400
            $0.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        }
        
        schoolFriendTableView.do {
            $0.register(FriendEmptyTableViewCell.self, forCellReuseIdentifier: FriendEmptyTableViewCell.identifier)
            $0.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.identifier)
            $0.backgroundColor = .black
            $0.separatorColor = .grayscales800
            $0.separatorStyle = .singleLine
            $0.showsVerticalScrollIndicator = false
        }
        configureSchoolFriendDataSource()
    }
    
    private func setLayout() {

        self.addSubviews(inviteBannerView,
                        schoolFriendTableView)

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
            if self.schoolFriendCount == 0 {
                guard let emptyCell = tableView.dequeueReusableCell(withIdentifier: FriendEmptyTableViewCell.identifier, for: indexPath) as? FriendEmptyTableViewCell else { return UITableViewCell() }
                emptyCell.selectionStyle = .none
                if tableView.isLast(for: indexPath) {
                    DispatchQueue.main.async {
                        emptyCell.addAboveTheBottomBorderWithColor(color: .black)
                    }
                }
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
                    recommendingSchoolFriendTableViewDummy[indexPath.row].isButtonSelected = true
                }
                cell.addButton.removeTarget(nil, action: nil, for: .allEvents)
                
                cell.addButton.setImage(cell.isTapped ? ImageLiterals.Recommending.icAddFriendButtonTapped : ImageLiterals.Recommending.icAddFriendButton, for: .normal)
                cell.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
                if recommendingSchoolFriendTableViewDummy.isEmpty {
                    return cell
                }
                cell.configureFriendCell(recommendingSchoolFriendTableViewDummy[indexPath.row])
                return cell
            }
        }
        updateView()
    }
    
    func applySnapshot(animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, FriendModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(recommendingSchoolFriendTableViewDummy, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    

    // MARK: Objc Function
    @objc func addButtonTapped(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: schoolFriendTableView)
        guard let indexPath = schoolFriendTableView.indexPathForRow(at: point) else { return }
        
        // 삭제 서버통신
        recommendingAddFriend(friendId: recommendingSchoolFriendTableViewDummy[indexPath.row].friends.id)
        
        // 추가할 아이템의 식별자 가져오기
        let itemToAdd = self.recommendingSchoolFriendTableViewDummy[indexPath.row]
        
        // 스냅샷에서 해당 아이템 삭제
        self.dataSource.defaultRowAnimation = .right
        var snapshot = self.dataSource.snapshot()
        snapshot.deleteItems([itemToAdd])
        self.dataSource.apply(snapshot, animatingDifferences: true)
        self.recommendingSchoolFriendTableViewDummy.remove(at: indexPath.row)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.schoolFriendCount = self.recommendingSchoolFriendTableViewDummy.count
        }
        self.dataSource.defaultRowAnimation = .middle
    }
    
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
        } else {
            self.inviteBannerView.isHidden = false
        }
        self.schoolFriendTableView.reloadData()
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
                    
                    self.recommendingSchoolFriendTableViewDummy.append(contentsOf: friendModels)
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
        if self.schoolFriendCount == 0 {
            return 1
        } else {
            return recommendingSchoolFriendTableViewDummy.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.schoolFriendCount == 0 {
            guard let emptyCell = tableView.dequeueReusableCell(withIdentifier: FriendEmptyTableViewCell.identifier, for: indexPath) as? FriendEmptyTableViewCell else { return UITableViewCell() }
            emptyCell.selectionStyle = .none
            if tableView.isLast(for: indexPath) {
                DispatchQueue.main.async {
                    emptyCell.addAboveTheBottomBorderWithColor(color: .black)
                }
            }
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
                recommendingSchoolFriendTableViewDummy[indexPath.row].isButtonSelected = true
            }
            cell.addButton.removeTarget(nil, action: nil, for: .allEvents)
            
            cell.addButton.setImage(cell.isTapped ? ImageLiterals.Recommending.icAddFriendButtonTapped : ImageLiterals.Recommending.icAddFriendButton, for: .normal)
            cell.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            if recommendingSchoolFriendTableViewDummy.isEmpty {
                return cell
            }
            cell.configureFriendCell(recommendingSchoolFriendTableViewDummy[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // cell의 높이 + inset 8 더한 값
        if self.schoolFriendCount == 0 {
            return 406.adjustedHeight
        } else {
            return 77
        }
    }
}
