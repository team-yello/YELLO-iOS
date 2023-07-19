//
//  MyYelloListView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

// MARK: - Protocol
protocol HandleMyYelloCellDelegate: AnyObject {
    func pushMyYelloDetailViewController(index: Int)
}

final class MyYelloListView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    weak var handleMyYelloCellDelegate: HandleMyYelloCellDelegate?
    var fetchingMore = false
    var myYelloPage: Int = 0
    var indexNumber: Int = -1
    var isFinishPaging = false
    var pageCount = -1

    static var myYelloModelDummy: [Yello] = []

    // MARK: Component
    lazy var myYelloTableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black
        
        refreshControl.do {
            myYelloTableView.refreshControl = $0
            $0.tintColor = .grayscales400
            $0.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        }

        myYelloTableView.do {
            $0.register(MyYelloEmptyTableViewCell.self, forCellReuseIdentifier: MyYelloEmptyTableViewCell.identifier)
            $0.register(MyYelloDefaultTableViewCell.self, forCellReuseIdentifier: MyYelloDefaultTableViewCell.identifier)
            $0.register(MyYelloKeywordTableViewCell.self, forCellReuseIdentifier: MyYelloKeywordTableViewCell.identifier)
            $0.register(MyYelloNameTableViewCell.self, forCellReuseIdentifier: MyYelloNameTableViewCell.identifier)
            $0.dataSource = self
            $0.delegate = self
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .black
        }
    }
    
    override func setLayout() {
        
        self.addSubviews(myYelloTableView)
        
        myYelloTableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
        }
    }
    
    // MARK: Objc Function
    @objc func refreshTable(refresh: UIRefreshControl) {
        self.pageCount = -1
        self.isFinishPaging = false
        self.fetchingMore = false
        MyYelloListView.myYelloModelDummy = []
        self.myYello()
        refresh.endRefreshing()
        print(MyYelloListView.myYelloModelDummy)
    }
    
    // MARK: Custom Function
    private func pushMyYelloDetailViewController(index: Int) {
        handleMyYelloCellDelegate?.pushMyYelloDetailViewController(index: index)
    }
    
    // MARK: - Network
    func myYello() {
        if fetchingMore { // 이미 데이터를 가져오는 중이면 리턴
            return
        }
        
        if isFinishPaging {
            return
        }
        
        self.pageCount += 1
        let queryDTO = MyYelloRequestQueryDTO(page: pageCount)
        
        fetchingMore = true
        
        NetworkService.shared.myYelloService.myYello(queryDTO: queryDTO) { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    guard let data = data.data else { return }
                    
                    let totalPage = (data.totalCount) / 10
                    if self.pageCount >= totalPage {
                        self.isFinishPaging = true
                    }
                    
                    MyYelloView.myYelloCount = data.totalCount
                    
                    let myYelloModels = data.votes.map { myYello in
                        
                        return Yello(id: myYello.id, senderGender: myYello.senderGender, senderName: myYello.senderName, nameHint: myYello.nameHint, vote: Vote(nameHead: myYello.vote.nameHead, nameFoot: myYello.vote.nameFoot, keywordHead: myYello.vote.keywordHead, keyword: myYello.vote.keyword, keywordFoot: myYello.vote.keywordFoot), isHintUsed: myYello.isHintUsed, isRead: myYello.isRead, createdAt: myYello.createdAt)
                    }
                    
                    MyYelloListView.myYelloModelDummy.append(contentsOf: myYelloModels)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.myYelloTableView.reloadData()
                    }
                    self.fetchingMore = false
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

// MARK: - extension
// MARK: UITableViewDelegate
extension MyYelloListView: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = self.myYelloTableView
        let offsetY = tableView.contentOffset.y
        let contentHeight = tableView.contentSize.height
        let visibleHeight = tableView.bounds.height
        if offsetY > contentHeight - visibleHeight {
                self.myYello()
        }
    }
}

// MARK: UITableViewDataSource
extension MyYelloListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if MyYelloView.myYelloCount == 0 {
            return 1
        } else {
            return MyYelloListView.myYelloModelDummy.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if MyYelloView.myYelloCount == 0 {
            guard let emptyCell = myYelloTableView.dequeueReusableCell(withIdentifier: MyYelloEmptyTableViewCell.identifier, for: indexPath) as? MyYelloEmptyTableViewCell else { return UITableViewCell() }
            emptyCell.selectionStyle = .none
            return emptyCell
        } else {
            if MyYelloListView.myYelloModelDummy[indexPath.row].isHintUsed == false {
                guard let defaultCell = myYelloTableView.dequeueReusableCell(withIdentifier: MyYelloDefaultTableViewCell.identifier, for: indexPath) as? MyYelloDefaultTableViewCell else { return UITableViewCell() }
                
                defaultCell.configureDefaultCell(MyYelloListView.myYelloModelDummy[indexPath.row])
                defaultCell.selectionStyle = .none
                return defaultCell
            } else {
                if MyYelloListView.myYelloModelDummy[indexPath.row].nameHint == -1 {
                    guard let keywordCell = myYelloTableView.dequeueReusableCell(withIdentifier: MyYelloKeywordTableViewCell.identifier, for: indexPath) as? MyYelloKeywordTableViewCell else { return UITableViewCell() }
                    
                    keywordCell.configureKeywordCell(MyYelloListView.myYelloModelDummy[indexPath.row])
                    keywordCell.selectionStyle = .none
                    return keywordCell
                } else {
                    guard let nameCell = myYelloTableView.dequeueReusableCell(withIdentifier: MyYelloNameTableViewCell.identifier, for: indexPath) as? MyYelloNameTableViewCell else { return UITableViewCell() }
                    
                    nameCell.configureNameCell(MyYelloListView.myYelloModelDummy[indexPath.row])
                    nameCell.selectionStyle = .none
                    return nameCell
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // cell의 높이 + inset 8 더한 값
        if MyYelloView.myYelloCount == 0 {
            return 500
        } else {
            if MyYelloListView.myYelloModelDummy[indexPath.row].isHintUsed == false {
                return 74
            } else {
                if MyYelloListView.myYelloModelDummy[indexPath.row].nameHint == -1 {
                    return 74
                } else {
                    return 98
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if MyYelloView.myYelloCount == 0 {
            return 0
        } else {
            return 102
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if MyYelloView.myYelloCount == 0 {
            return 
        }
        self.pushMyYelloDetailViewController(index: indexPath.row)
    }
}
