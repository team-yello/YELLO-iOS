//
//  ProfileView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import Amplitude
import SnapKit
import Then

// MARK: - Protocol
protocol HandleFriendCellDelegate: AnyObject {
    func presentModal(index: Int)
}

protocol HandleEditButton: AnyObject {
    func editButtonTapped()
}

final class ProfileView: UIView {
    
    // MARK: - Variables
    // MARK: Property
    weak var handleFriendCellDelegate: HandleFriendCellDelegate?
    weak var handleShopButton: HandleShopButton?
    weak var handleEditButton: HandleEditButton?
    var indexNumber: Int = -1
    var friendCount: Int = 0 {
        didSet {
            emptyLabel.isHidden = friendCount == 0 ? false : true
        }
    }
    
    var fetchingMore = false
    var isFinishPaging = false
    var isYelloPlus = false {
        didSet {
            self.myFriendTableView.reloadData()
        }
    }
    var redirectionURL: String = ""
    var notiBannerImageURL = ""
    var isAvailable = false {
        didSet {
            self.myFriendTableView.reloadData()
        }
    }
    var pageCount = -1
    var myYelloCount = 0
    var profileFriendPage: Int = 0
    var ticketCount = 0
    
    var myProfileFriendModelDummy: [ProfileFriendResponseDetail] = []
    
    // MARK: Component
    let navigationBarView = NavigationBarView()
    let myProfileHeaderView = MyProfileHeaderView()
    lazy var myFriendTableView = UITableView(frame: .zero, style: .grouped)
    let refreshControl = UIRefreshControl()
    let headerBorder = CALayer()
    private let emptyLabel = UILabel()
    
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
            $0.register(MyFriendTableViewCell.self, forCellReuseIdentifier: MyFriendTableViewCell.identifier)
            $0.register(MyFriendSkeletonTableViewCell.self, forCellReuseIdentifier: MyFriendSkeletonTableViewCell.identifier)
            $0.register(MyProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "MyProfileHeaderView")
            $0.backgroundColor = .clear
            $0.separatorColor = .grayscales800
            $0.separatorStyle = .singleLine
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 77.adjustedHeight
            $0.sectionHeaderHeight = UITableView.automaticDimension
            $0.estimatedSectionHeaderHeight = 304.adjustedHeight
        }
        
        topButton.do {
            $0.backgroundColor = .white
            $0.makeCornerRound(radius: 24)
            $0.setImage(ImageLiterals.Profile.icArrowUp, for: .normal)
            $0.addTarget(self, action: #selector(topButtonTapped), for: .touchUpInside)
            $0.isHidden = true
            $0.layer.applyShadow(color: .black, alpha: 0.6, x: 0, y: 0, blur: 8)
        }
        
        headerBorder.do {
            $0.backgroundColor = UIColor.black.cgColor
        }
        
        emptyLabel.do {
            $0.text = StringLiterals.Profile.Friend.empty
            $0.textColor = .grayscales600
            $0.font = .uiLabelLarge
        }
    }
    
    private func setLayout() {
        self.addSubviews(navigationBarView,
                         myFriendTableView,
                         topButton)
        myFriendTableView.addSubviews(emptyLabel)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        myFriendTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.bottom.equalToSuperview()
        }
        
        topButton.snp.makeConstraints {
            $0.width.height.equalTo(48.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.bottom.equalTo(myFriendTableView.snp.bottom).inset(16.adjustedHeight)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(389.adjustedHeight)
        }
    }
    
    private func setDelegate() {
        myFriendTableView.dataSource = self
        myFriendTableView.delegate = self
    }
    
    // MARK: Custom Function
    private func updateButtonVisibility() {
        topButton.isHidden = isButtonHidden
    }
    
    // MARK: Objc Function
    @objc func refreshTable(refresh: UIRefreshControl) {
        self.pageCount = -1
        self.isFinishPaging = false
        self.fetchingMore = false
        self.myFriendTableView.reloadData()
        self.myProfileFriendModelDummy = []
        self.profileFriend()
        refresh.endRefreshing()
    }
    
    @objc func topButtonTapped() {
        myFriendTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @objc func shopButtonTapped() {
        handleShopButton?.shopButtonTapped()
    }
    
    @objc func editButtonTapped() {
        handleEditButton?.editButtonTapped()
    }
    
    private func presentModal(index: Int) {
        handleFriendCellDelegate?.presentModal(index: index)
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
            
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                
                self.friendCount = data.totalCount
                let friendModels = data.friends.map { profileFriend in
                    
                    return ProfileFriendResponseDetail(userId: profileFriend.userId, name: profileFriend.name, profileImageUrl: profileFriend.profileImageUrl, group: profileFriend.group, yelloId: profileFriend.yelloId, yelloCount: profileFriend.yelloCount, friendCount: profileFriend.friendCount)
                }
                
                // 중복되는 모델 필터 처리
                let uniqueFriendModels = friendModels.filter { model in
                    !self.myProfileFriendModelDummy.contains { $0.userId == model.userId }
                }
                
                self.myProfileFriendModelDummy.append(contentsOf: uniqueFriendModels)
                self.fetchingMore = false
                self.myFriendTableView.reloadData()
                let totalPage = (data.totalCount) / 10
                if self.pageCount >= totalPage {
                    self.isFinishPaging = true
                }
                
                print("통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
    
    func purchaseInfo() {
        NetworkService.shared.profileService.purchaseInfo { response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                
                self.isYelloPlus = data.isSubscribe
                UserManager.shared.isYelloPlus = data.isSubscribe
                self.ticketCount = data.ticketCount
                
                print("구독 통신 성공")
            default:
                print("network fail")
                UserManager.shared.isYelloPlus = false
                self.isYelloPlus = false
                return
            }
        }
    }
    
    // MARK: Custom Function
    func loadProfileNoti() {
        NetworkService.shared.notificationService.userNotification(typeName: "PROFILE-BANNER") { result in
            switch result {
            case .success(let data):
                if let data = data.data {
                   self.isAvailable = data.isAvailable
                    if data.isAvailable {
                        self.notiBannerImageURL = data.imageUrl
                        self.redirectionURL = data.redirectUrl
                    }
                }
            default:
                print("프로필 공지사항 Network Error")
            }
        }
    }
    
    // MARK: Objc Function
    @objc func tapNotification() {
        Amplitude.instance().logEvent("click_profile_banner")
        let url = URL(string: redirectionURL)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        Amplitude.instance().logEvent("scroll_profile_friends")
    }
}

// MARK: UITableViewDataSource
// MARK: UITableViewDataSource
extension ProfileView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyProfileHeaderView.cellIdentifier) as? MyProfileHeaderView
            if fetchingMore {
                view?.friendCountView.skeletonLabel.isHidden = false
                view?.friendCountView.skeletonLabel.animateShimmer()
                view?.friendCountView.countStackView.isHidden = true
                emptyLabel.isHidden = true
            } else {
                view?.friendCountView.skeletonLabel.stopShimmering()
                view?.friendCountView.skeletonLabel.isHidden = true
                view?.friendCountView.countStackView.isHidden = false
                emptyLabel.isHidden = friendCount == 0 ? false : true
            }
            
            DispatchQueue.main.async { [self] in
                view?.profileUser()
                view?.myProfileView.mainProfileView.nameSkeletonLabel.isHidden = true
                view?.myProfileView.mainProfileView.schoolSkeletonLabel.isHidden = true
                view?.myProfileView.shopButton.addTarget(self, action: #selector(shopButtonTapped), for: .touchUpInside)
                view?.myProfileView.mainProfileView.editProfileButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
                view?.myProfileView.isAvailable = self.isAvailable
                view?.myProfileView.notificationImageView.kfSetImage(url: notiBannerImageURL)
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapNotification))
                view?.myProfileView.notificationImageView.addGestureRecognizer(tapGesture)
                view?.myProfileView.notificationImageView.isUserInteractionEnabled = true
                view?.myProfileView.mainProfileView.isYelloPlus = self.isYelloPlus
                view?.myProfileView.mainProfileView.updateProfileView()
                headerBorder.removeFromSuperlayer()
                headerBorder.frame = CGRect(x: 0, y: view?.frame.size.height ?? CGFloat(), width: UIScreen.main.bounds.width, height: 1)
                view?.layer.addSublayer(headerBorder)
            }
            return view
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return isAvailable ? 347.adjusted : 307.adjusted
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fetchingMore {
            return 10 // Skeleton 셀 개수
        } else {
            return myProfileFriendModelDummy.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if fetchingMore {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyFriendSkeletonTableViewCell.identifier, for: indexPath) as! MyFriendSkeletonTableViewCell
            cell.selectionStyle = .none
            cell.showShimmer()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyFriendTableViewCell.identifier, for: indexPath) as? MyFriendTableViewCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.configureMyProfileFriendCell(self.myProfileFriendModelDummy[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if fetchingMore {
            return
        } else {
            print("Click Cell Number:" + String(indexPath.row))
            Amplitude.instance().logEvent("click_profile_friend")
            self.presentModal(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
