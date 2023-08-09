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
    var fetchingMore = false {
        didSet {
            schoolFriendTableView.reloadData()
        }
    }
    var isFinishPaging = false
    var schoolPage: Int = -1
    var schoolFriendCount: Int = -1 {
        didSet {
            updateView()
        }
    }
    
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
        self.backgroundColor = .clear
        
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
            $0.register(FriendSkeletonTableViewCell.self, forCellReuseIdentifier: FriendSkeletonTableViewCell.identifier)
            $0.backgroundColor = .clear
            $0.separatorColor = .grayscales800
            $0.separatorStyle = .singleLine
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    private func setLayout() {
        
        self.addSubviews(inviteBannerView,
                         schoolFriendTableView)
        
        schoolFriendTableView.addSubviews(emptyView)
        
        inviteBannerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(76.adjustedHeight)
        }
        
        schoolFriendTableView.snp.makeConstraints {
            $0.top.equalTo(inviteBannerView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        schoolFriendTableView.dataSource = self
        schoolFriendTableView.delegate = self
    }
    
    // MARK: Objc Function
    @objc func refreshTable(refresh: UIRefreshControl) {
        if schoolFriendCount == 0 {
            self.inviteBannerView.isHidden = false
            self.emptyView.isHidden = true
        }
        self.schoolPage = -1
        self.isFinishPaging = false
        self.fetchingMore = false
        self.recommendingSchoolFriendTableViewDummy = []
        self.recommendingSchoolFriend()
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
            
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                
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
                self.fetchingMore = false
                
                self.schoolFriendTableView.reloadData()
                
                let totalPage = (data.totalCount) / 10
                if self.schoolPage >= totalPage {
                    self.isFinishPaging = true
                }
                self.updateView()
                print("통신 성공")
            default:
                print("network fail")
                return
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
        
        recommendingSchoolFriendTableViewDummy[indexPath.row].isButtonSelected = true
        sender.setImage(ImageLiterals.Recommending.icAddFriendButtonTapped, for: .disabled)
        sender.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.recommendingSchoolFriendTableViewDummy.remove(at: indexPath.row)
            self.schoolFriendCount = self.recommendingSchoolFriendTableViewDummy.count
            self.schoolFriendTableView.deleteRows(at: [indexPath], with: .right)
            self.schoolFriendTableView.reloadData()
            self.updateView()
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
        if fetchingMore {
            return 10 // Skeleton 셀 개수
        } else {
            return recommendingSchoolFriendTableViewDummy.count // 실제 데이터 셀 개수
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if fetchingMore {
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendSkeletonTableViewCell.identifier, for: indexPath) as! FriendSkeletonTableViewCell
            cell.selectionStyle = .none
            cell.showShimmer()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as! FriendTableViewCell
            
            cell.selectionStyle = .none
            
            cell.isTapped = self.recommendingSchoolFriendTableViewDummy[indexPath.row].isButtonSelected
            cell.updateAddButtonImage()
            
            cell.handleAddFriendButton = self
            cell.configureFriendCell(self.recommendingSchoolFriendTableViewDummy[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77.adjustedHeight
    }
}
