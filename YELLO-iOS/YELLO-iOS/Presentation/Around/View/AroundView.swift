//
//  AroundView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/06.
//

import UIKit

import SnapKit
import Then

// MARK: - Around
final class AroundView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    var fetchingMore = true {
        didSet {
            aroundTableView.reloadData()
        }
    }
    var aroundPage: Int = 0
    var indexNumber: Int = -1
    var isFinishPaging = false
    var pageCount = -1
    
    var aroundModelDummy: [Yello] = []
    
    // MARK: Component
    private let aroundNavigationBarView = UIView()
    private let aroundLabel = UILabel()
    lazy var aroundTableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    // MARK: Layout Helpers
    override func setUI() {
        setStyle()
        setLayout()
    }
    
    override func setStyle() {
        self.backgroundColor = .clear
        
        aroundNavigationBarView.do {
            $0.backgroundColor = .black
        }
        
        aroundLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Around.around, lineHeight: 28)
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
//        configureAroundDataSource()
    }
    
//    private func configureAroundDataSource() {
//        dataSource = UITableViewDiffableDataSource<Int, Yello>(tableView: aroundTableView) { [weak self] (tableView, indexPath, around) -> UITableViewCell? in
//            guard let aroundCell = tableView.dequeueReusableCell(withIdentifier: AroundTableViewCell.identifier, for: indexPath) as? AroundTableViewCell else { return UITableViewCell() }
//            aroundCell.selectionStyle = .none
//            return aroundCell
//        }
//    }
    
    override func setLayout() {
        self.addSubviews(
            aroundNavigationBarView,
            aroundTableView)
        
        aroundNavigationBarView.addSubview(aroundLabel)
    
        aroundNavigationBarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        aroundLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        aroundTableView.snp.makeConstraints {
            $0.top.equalTo(aroundNavigationBarView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        
        refreshControl.do {
            aroundTableView.refreshControl = $0
            $0.tintColor = .grayscales400
            $0.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        }
    }
    
    // MARK: Objc Function
    @objc func refreshTable(refresh: UIRefreshControl) {
        self.pageCount = -1
        self.isFinishPaging = false
        self.fetchingMore = false
        aroundModelDummy = []
        self.around()
        refresh.endRefreshing()
    }
    
    // MARK: - Network
    func around() {
        self.fetchingMore = true
        // 네트워크 함수 구현
        print("네트워크 함수 구현")
        self.fetchingMore = false
        self.aroundTableView.reloadData()
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
            aroundCell.selectionStyle = .none
            return aroundCell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return aroundModelDummy.count
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116.adjustedHeight
    }
}
