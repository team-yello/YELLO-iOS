//
//  AroundView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/06.
//

import UIKit

import Amplitude
import SnapKit
import Then

// MARK: - Around
final class AroundView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    var fetchingMore = false
    var isFinishPaging = false
    var isRefreshing = false
    var aroundPage = -1
    var aroundCount = -1 {
        didSet {
            updateView()
        }
    }
    var scrollCount = 0
    
    var aroundModelDummy: [FriendVote] = []
    
    // MARK: Component
    private let aroundNavigationBarView = UIView()
    private let aroundLabel = UILabel()
    lazy var aroundTableView = UITableView()
    let refreshControl = UIRefreshControl()
    private let aroundEmptyView = EmptyFriendView()
    
    // MARK: Layout Helpers
    override func setUI() {
        setStyle()
        setLayout()
        updateView()
    }
    
    override func setStyle() {
        self.backgroundColor = .clear
        
        aroundEmptyView.do {
            $0.isHidden = true
        }
        
        aroundNavigationBarView.do {
            $0.backgroundColor = .black
        }
        
        aroundLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Around.around, lineHeight: 28.adjustedHeight)
            $0.font = .uiHeadline03
            $0.textColor = .white
        }
        
        aroundTableView.do {
            $0.register(AroundTableViewCell.self, forCellReuseIdentifier: AroundTableViewCell.identifier)
            $0.register(AroundSkeletonTableViewCell.self, forCellReuseIdentifier: AroundSkeletonTableViewCell.identifier)
            $0.dataSource = self
            $0.delegate = self
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .black
        }
        
        refreshControl.do {
            aroundTableView.refreshControl = $0
            $0.tintColor = .grayscales400
            $0.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        }
    }
    
    override func setLayout() {
        self.addSubviews(
            aroundNavigationBarView,
            aroundTableView)
        
        aroundTableView.addSubviews(aroundEmptyView)
        
        aroundNavigationBarView.addSubview(aroundLabel)
    
        aroundNavigationBarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        aroundLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
            $0.centerY.equalToSuperview()
        }
        
        aroundTableView.snp.makeConstraints {
            $0.top.equalTo(aroundNavigationBarView.snp.bottom).offset(12.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.bottom.equalToSuperview()
        }
        
        aroundEmptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    /// 친구가 없을 때 초대 뷰를 띄우는 로직
    func updateView() {
        aroundEmptyView.viewControllerName = "around"
        if self.aroundCount == 0 {
            self.aroundEmptyView.isHidden = false
        } else {
            self.aroundEmptyView.isHidden = true
        }
    }
    
    // MARK: Objc Function
    @objc func refreshTable(refresh: UIRefreshControl) {
        self.isRefreshing = true
        self.aroundPage = -1
        self.aroundCount = -1
        self.isFinishPaging = false
        self.fetchingMore = false
        self.aroundTableView.reloadData()
        self.aroundModelDummy = []
        self.around()
        refresh.endRefreshing()
        self.isRefreshing = false
        self.updateView()
    }
    
    // MARK: - Network
    func around() {
        if fetchingMore { // 이미 데이터를 가져오는 중이면 리턴
            return
        }
        
        if isFinishPaging {
            return
        }
        
        self.aroundPage += 1
        let queryDTO = AroundRequestQueryDTO(page: aroundPage)
        
        self.fetchingMore = true
        
        if isRefreshing {
            self.aroundTableView.reloadData()
        }
        
        NetworkService.shared.aroundService.around(queryDTO: queryDTO) { [weak self] response in
            guard let self = self else { return }
            
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                
                self.aroundCount = data.totalCount
                
                let friendVote = data.friendVotes.map { around in
                    return FriendVote(id: around.id, receiverName: around.receiverName, senderGender: around.senderGender, vote: around.vote, isHintUsed: around.isHintUsed, createdAt: around.createdAt)
                }
                
                // 중복되는 모델 필터 처리
                let uniqueFriendModels = friendVote.filter { model in
                    !self.aroundModelDummy.contains { $0.id == model.id }
                }
                
                self.aroundModelDummy.append(contentsOf: uniqueFriendModels)
                self.fetchingMore = false
                
                self.aroundTableView.reloadData()
                
                let totalPage = (data.totalCount) / 10
                if self.aroundPage >= totalPage {
                    self.isFinishPaging = true
                }
                
                self.updateView()
                print("타임라인 통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
}

// MARK: - extension
// MARK: UITableViewDelegate
extension AroundView: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = self.aroundTableView
        let offsetY = tableView.contentOffset.y
        let contentHeight = tableView.contentSize.height
        let visibleHeight = tableView.bounds.height
        if offsetY > contentHeight - visibleHeight {
            self.around()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollCount < 1 {
            print("🏁스크롤 이벤트 감지")
            Amplitude.instance().logEvent("scroll_timeline")
        }
        scrollCount += 1
    }
}

// MARK: UITableViewDataSource
extension AroundView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if fetchingMore {
            let cell = tableView.dequeueReusableCell(withIdentifier: AroundSkeletonTableViewCell.identifier, for: indexPath) as! AroundSkeletonTableViewCell
            cell.selectionStyle = .none
            cell.showShimmer()
            return cell
        } else {
            guard let aroundCell = tableView.dequeueReusableCell(withIdentifier: AroundTableViewCell.identifier, for: indexPath) as? AroundTableViewCell else { return UITableViewCell() }
            aroundCell.configureAroundCell(aroundModelDummy[indexPath.row])
            aroundCell.selectionStyle = .none
            return aroundCell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fetchingMore {
            return 10 // Skeleton 셀 개수
        } else {
            return aroundModelDummy.count // 실제 데이터 셀 개수
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116.adjustedHeight
    }
}
