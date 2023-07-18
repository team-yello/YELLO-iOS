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
    var friendCount: Int = 0 {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.myFriendTableView.reloadData()
                self.beginBatchFetch()
                self.myProfileHeaderView.myProfileView.profileUser(userId: 148)
            }
        }
    }
 
    var fetchingMore = false
    var myProfileFriendModelModel: [ProfileFriendResponseDetail] = []
    
    var initialProfileFriendDataCount = 10
    var profileFriendPage: Int = 0
    
    var myProfileFriendModelDummy: [ProfileFriendResponseDetail] = [] {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.myFriendTableView.reloadData()
            }
        }
    }    
    
    // MARK: Component
    let navigationBarView = NavigationBarView()
    let myProfileHeaderView = MyProfileHeaderView()
    lazy var myFriendTableView = UITableView(frame: .zero, style: .grouped)

    lazy var topButton = UIButton()
    private var isButtonHidden: Bool = false
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setDelegate()
        profileFriend(page: profileFriendPage)
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
    }
    
    private func setLayout() {
        if myProfileFriendModelDummy.count < 10 {
            initialProfileFriendDataCount = myProfileFriendModelDummy.count
        } else {
            initialProfileFriendDataCount = 10
        }
        
        myProfileFriendModelModel = Array(myProfileFriendModelDummy[0..<initialProfileFriendDataCount])
        let statusBarHeight = UIApplication.shared.connectedScenes
                    .compactMap { $0 as? UIWindowScene }
                    .first?
                    .statusBarManager?
                    .statusBarFrame.height ?? 20
        
        self.addSubviews(navigationBarView,
                        myFriendTableView,
                         topButton)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
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
        myFriendTableView.dataSource = self
        myFriendTableView.delegate = self
    }
    
    // MARK: Custom Function
    private func updateButtonVisibility() {
        topButton.isHidden = isButtonHidden
    }
    
    // MARK: Objc Function
    @objc func topButtonTapped() {
        myFriendTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    private func presentModal(index: Int) {
        handleFriendCellDelegate?.presentModal(index: index)
    }
    
    // MARK: - Network
    func profileFriend(page: Int) {
        let queryDTO = ProfileFriendRequestQueryDTO(page: page)
        NetworkService.shared.profileService.profileFriend(queryDTO: queryDTO) { response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                
                let friendModels = data.friends.map { profileFriend in
                    
                    return ProfileFriendResponseDetail(userId: profileFriend.userId, name: profileFriend.name, profileImageUrl: profileFriend.profileImageUrl, group: profileFriend.group, yelloId: profileFriend.yelloId, yelloCount: profileFriend.yelloCount, friendCount: profileFriend.friendCount, point: profileFriend.point)
                }
                
                self.myProfileFriendModelDummy.append(contentsOf: friendModels)
                self.friendCount = data.totalCount
                self.myFriendTableView.reloadData()
                dump(data)
                print("통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
}

// MARK: UITableViewDelegate
extension ProfileView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isButtonHidden = scrollView.contentOffset.y <= 0
        updateButtonVisibility()
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetch()
                profileFriendPage += 1
                profileFriend(page: profileFriendPage)
            }
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
                view?.friendCountView.friendCountLabel.text = String(self.friendCount) + "명"
                view?.myProfileView.friendView.countLabel.text = String(self.friendCount)
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
        return myProfileFriendModelModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyFriendTableViewCell.identifier, for: indexPath) as? MyFriendTableViewCell else {
            
            profileFriend(page: profileFriendPage)
            return UITableViewCell()
        }
        
        if tableView.isLast(for: indexPath) {
            DispatchQueue.main.async {
                cell.addAboveTheBottomBorderWithColor(color: .black)
            }
        }
        cell.selectionStyle = .none
        cell.configureMyProfileFriendCell(myProfileFriendModelDummy[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Click Cell Number:" + String(indexPath.row))
        self.presentModal(index: indexPath.row)
    }
    
    func beginBatchFetch() {
        fetchingMore = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [self] in
            if myProfileFriendModelDummy.count - initialProfileFriendDataCount < 10 {
                if myProfileFriendModelDummy.count - initialProfileFriendDataCount == 0 {
                    print("친구 데이터가 더 없어요")
                } else {
                    let newItems = (initialProfileFriendDataCount...myProfileFriendModelDummy.count - 1).map { index in
                        myProfileFriendModelDummy[index]
                    }
                    self.myProfileFriendModelModel.append(contentsOf: newItems)
                }
            } else {
                let newItems = (initialProfileFriendDataCount...initialProfileFriendDataCount + 9).map { index in
                    myProfileFriendModelDummy[index]
                }
                self.myProfileFriendModelModel.append(contentsOf: newItems)
            }
            
            self.fetchingMore = false
            self.myFriendTableView.reloadData()
            initialProfileFriendDataCount = myProfileFriendModelModel.count
        }
    }
}
