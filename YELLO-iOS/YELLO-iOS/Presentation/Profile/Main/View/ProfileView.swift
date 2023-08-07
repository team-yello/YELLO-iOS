//
//  ProfileView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

// MARK: - Protocol
protocol HandleFriendCellDelegate: AnyObject {
    func presentModal(index: Int)
}

final class ProfileView: UIView {

    // MARK: - Variables
    // MARK: Property
    weak var handleFriendCellDelegate: HandleFriendCellDelegate?
    var indexNumber: Int = -1
    var friendCount: Int = 0
    
    var initialProfileFriendDataCount = 10
    var fetchingMore = false
    var isFinishPaging = false
    var pageCount = -1
    var myYelloCount = 0
    var profileFriendPage: Int = 0
    
    var dataSource: UITableViewDiffableDataSource<Int, ProfileFriendResponseDetail>!
    
    var myProfileFriendModelDummy: [ProfileFriendResponseDetail] = [] 
    
    // MARK: Component
    let navigationBarView = NavigationBarView()
    let myProfileHeaderView = MyProfileHeaderView()
    lazy var myFriendTableView = UITableView(frame: .zero, style: .grouped)
    let refreshControl = UIRefreshControl()

    lazy var topButton = UIButton()
    private var isButtonHidden: Bool = false
    
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
extension ProfileView {
    
    private func configureMyProfileDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, ProfileFriendResponseDetail>(tableView: myFriendTableView) { [weak self] (tableView, indexPath, profileFriend) -> UITableViewCell? in
                guard let self = self else {
                    return UITableViewCell()
                }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyFriendTableViewCell.identifier, for: indexPath) as? MyFriendTableViewCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            if self.myProfileFriendModelDummy.isEmpty {
                return cell
            }
            cell.configureMyProfileFriendCell(self.myProfileFriendModelDummy[indexPath.row])
            return cell
        }
    }
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {        
        self.backgroundColor = .black
        
        refreshControl.do {
            myFriendTableView.refreshControl = $0
            $0.tintColor = .grayscales400
            $0.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        }
        
        myFriendTableView.do {
            $0.rowHeight = 77
            $0.register(MyFriendTableViewCell.self, forCellReuseIdentifier: MyFriendTableViewCell.identifier)
            $0.register(MyProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "MyProfileHeaderView")
            $0.backgroundColor = .black
            $0.separatorColor = .grayscales800
            $0.separatorStyle = .singleLine
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
        }
        
        topButton.do {
            $0.backgroundColor = .white
            $0.makeCornerRound(radius: 24)
            $0.setImage(ImageLiterals.Profile.icArrowUp, for: .normal)
            $0.addTarget(self, action: #selector(topButtonTapped), for: .touchUpInside)
            $0.isHidden = true
            $0.layer.applyShadow(color: .black, alpha: 0.6, x: 0, y: 0, blur: 8)
        }
        configureMyProfileDataSource()
    }
    
    private func setLayout() {
        self.addSubviews(navigationBarView,
                        myFriendTableView,
                         topButton)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        myFriendTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
            $0.bottom.equalToSuperview()
        }
        
        topButton.snp.makeConstraints {
            $0.width.height.equalTo(48.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.bottom.equalTo(myFriendTableView.snp.bottom).inset(16.adjustedHeight)
        }
    }
    
    private func setDelegate() {
        myFriendTableView.dataSource = dataSource
        myFriendTableView.delegate = self
    }
    
    // MARK: Custom Function
    private func updateButtonVisibility() {
        topButton.isHidden = isButtonHidden
    }
    
    func applySnapshot(animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ProfileFriendResponseDetail>()
        snapshot.appendSections([0])
        snapshot.appendItems(myProfileFriendModelDummy, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    // MARK: Objc Function
    @objc func refreshTable(refresh: UIRefreshControl) {
        self.pageCount = -1
        self.isFinishPaging = false
        self.fetchingMore = false
        self.myProfileFriendModelDummy = []
        self.profileFriend()
        if self.fetchingMore == true {
            print("기다리삼")
            self.applySnapshot(animated: true)
        }
        refresh.endRefreshing()
        print(self.myProfileFriendModelDummy)
    }
    
    @objc func topButtonTapped() {
        myFriendTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    private func presentModal(index: Int) {
        handleFriendCellDelegate?.presentModal(index: index)
    }
    
    func deleteFriend(at index: Int) {
        // 특정 위치의 행 삭제
        myProfileFriendModelDummy.remove(at: index)
        
        // 스냅샷에 삭제된 행 적용
        applySnapshot()
    }
    
    // MARK: - Network
    func profileFriend() {
        if fetchingMore { // 이미 데이터를 가져오는 중이면 리턴
            return
        }
        
        if isFinishPaging {
            return
        }
        
        self.pageCount += 1
        let queryDTO = ProfileFriendRequestQueryDTO(page: pageCount)

        fetchingMore = true
        
        NetworkService.shared.profileService.profileFriend(queryDTO: queryDTO) { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    guard let data = data.data else { return }
                    
                    let totalPage = (data.totalCount) / 10
                    if self.pageCount >= totalPage {
                        self.isFinishPaging = true
                    }
                    
                    let friendModels = data.friends.map { profileFriend in
                        
                        return ProfileFriendResponseDetail(userId: profileFriend.userId, name: profileFriend.name, profileImageUrl: profileFriend.profileImageUrl, group: profileFriend.group, yelloId: profileFriend.yelloId, yelloCount: profileFriend.yelloCount, friendCount: profileFriend.friendCount)
                    }
                    
                    if self.pageCount == 0 {
                        self.friendCount = data.totalCount
                    }
                    
                    // 중복되는 모델 필터 처리
                    let uniqueFriendModels = friendModels.filter { model in
                        !self.myProfileFriendModelDummy.contains { $0.userId == model.userId }
                    }
                    
                    self.myProfileFriendModelDummy.append(contentsOf: uniqueFriendModels)
                    self.applySnapshot(animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.myFriendTableView.reloadData()
                        self.fetchingMore = false
                    }
                    dump(data)
                    print("통신 성공")
                default:
                    print("network fail")
                    return
                }
            }
        }
    }
}

// MARK: UITableViewDelegate
extension ProfileView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isButtonHidden = scrollView.contentOffset.y <= 0
        updateButtonVisibility()
        
        let tableView = self.myFriendTableView
        let offsetY = tableView.contentOffset.y
        let contentHeight = tableView.contentSize.height
        let visibleHeight = tableView.bounds.height
        if offsetY > contentHeight - visibleHeight {
            self.profileFriend()
        }
    }
}

// MARK: UITableViewDataSource
extension ProfileView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyProfileHeaderView.cellIdentifier) as? MyProfileHeaderView
            DispatchQueue.main.async {
                view?.addBottomBorderWithColor(color: .black)
                view?.myProfileView.profileUser()
                view?.friendCountView.friendCountLabel.text = String(self.friendCount) + "명"
                view?.friendCountView.friendCountLabel.asColor(targetString: "명", color: .grayscales500)
            }
            return view
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 304.adjusted : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myProfileFriendModelDummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Click Cell Number:" + String(indexPath.row))
        self.presentModal(index: indexPath.row)
    }
}
