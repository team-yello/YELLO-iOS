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
    var recommendingSchoolFriendTableViewModel: [FriendModel] = []
    private var initialSchoolDataCount = 10
    var schoolPage: Int = 0

    var recommendingSchoolFriendTableViewDummy: [FriendModel] = []
    
    // MARK: Component
    private let inviteBannerView = InviteBannerView()
    private let emptyFriendView = EmptyFriendView()
    lazy var schoolFriendTableView = UITableView()

    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setDelegate()
        recommendingSchoolFriend(page: schoolPage)
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
        
        schoolFriendTableView.do {
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
        if recommendingSchoolFriendTableViewDummy.count < 10 {
            initialSchoolDataCount = recommendingSchoolFriendTableViewDummy.count
        } else {
            initialSchoolDataCount = 10
        }
        recommendingSchoolFriendTableViewModel = Array(recommendingSchoolFriendTableViewDummy[0..<initialSchoolDataCount])

        self.addSubviews(inviteBannerView,
                        schoolFriendTableView,
                        emptyFriendView)

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
        
        emptyFriendView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        schoolFriendTableView.dataSource = self
        schoolFriendTableView.delegate = self
    }

    // MARK: Objc Function
    @objc func addButtonTapped(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: schoolFriendTableView)
        guard let indexPath = schoolFriendTableView.indexPathForRow(at: point) else { return }
        
        recommendingSchoolFriendTableViewModel[indexPath.row].isButtonSelected = true
        print(recommendingSchoolFriendTableViewModel[indexPath.row])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.recommendingSchoolFriendTableViewModel.remove(at: indexPath.row)
            self.recommendingSchoolFriendTableViewDummy.remove(at: indexPath.row)
            self.schoolFriendTableView.deleteRows(at: [indexPath], with: .right)
            self.updateView()
        }
        
        recommendingAddFriend(friendId: recommendingSchoolFriendTableViewModel[indexPath.row].recommendingFriendListData.id)
        schoolFriendTableView.reloadRows(at: [indexPath], with: .none)
        initialSchoolDataCount -= 1
    }
    
    // MARK: Custom Function
    func updateView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if self.recommendingSchoolFriendTableViewModel.isEmpty {
                self.inviteBannerView.isHidden = true
                self.schoolFriendTableView.isHidden = true
                self.emptyFriendView.isHidden = false
                
            } else {
                self.inviteBannerView.isHidden = false
                self.schoolFriendTableView.isHidden = false
                self.emptyFriendView.isHidden = true
            }
        }
    }
    
    // MARK: - Network
    func recommendingSchoolFriend(page: Int) {
        let queryDTO = RecommendingRequestQueryDTO(page: page)
        NetworkService.shared.recommendingService.recommendingSchoolFriend(queryDTO: queryDTO) { response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                
                let friendModels = data.map { recommendingFriend in
                    return FriendModel(
                        recommendingFriendListData: recommendingFriend,
                        isButtonSelected: false
                    )
                }
                
                self.recommendingSchoolFriendTableViewDummy.append(contentsOf: friendModels)
                self.schoolFriendTableView.reloadData()
                self.updateView()
                print(self.recommendingSchoolFriendTableViewModel)
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

// MARK: UITableViewDelegate
extension SchoolFriendView: UITableViewDelegate { }

// MARK: UITableViewDataSource
extension SchoolFriendView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendingSchoolFriendTableViewModel.count
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
            recommendingSchoolFriendTableViewModel[indexPath.row].isButtonSelected = true
        }
        cell.addButton.removeTarget(nil, action: nil, for: .allEvents)
        
        cell.addButton.setImage(cell.isTapped ? ImageLiterals.Recommending.icAddFriendButtonTapped : ImageLiterals.Recommending.icAddFriendButton, for: .normal)
        cell.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        cell.configureFriendCell(recommendingSchoolFriendTableViewModel[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetch()
                schoolPage += 1
                recommendingSchoolFriend(page: schoolPage)
            }
        }
    }
    
    func beginBatchFetch() {
        fetchingMore = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [self] in
            if recommendingSchoolFriendTableViewDummy.count - initialSchoolDataCount < 10 {
                if recommendingSchoolFriendTableViewDummy.count - initialSchoolDataCount == 0 {
                    print("친구 데이터가 더 없어요")
                } else {
                    let newItems = (initialSchoolDataCount...recommendingSchoolFriendTableViewDummy.count - 1).map { index in
                        recommendingSchoolFriendTableViewDummy[index]
                    }
                    self.recommendingSchoolFriendTableViewModel.append(contentsOf: newItems)
                }
            } else {
                let newItems = (initialSchoolDataCount...initialSchoolDataCount + 9).map { index in
                    recommendingSchoolFriendTableViewDummy[index]
                }
                self.recommendingSchoolFriendTableViewModel.append(contentsOf: newItems)
            }
            
            self.fetchingMore = false
            self.schoolFriendTableView.reloadData()
            initialSchoolDataCount = recommendingSchoolFriendTableViewModel.count
        }
    }
}
