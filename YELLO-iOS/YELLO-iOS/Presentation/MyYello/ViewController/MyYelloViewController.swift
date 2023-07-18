//
//  MyYelloViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

import SnapKit
import Then

final class MyYelloViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    private let myYelloView = MyYelloView()
    var isFinishPaging = false
    var isLoadingData = false
    
    var pageCount = -1
    
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setAddTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.myYello()
        self.myYelloView.resetLayout()
    }
    
    // MARK: Layout Helpers
    override func setStyle() {
        view.backgroundColor = .black
    }
    
    override func setLayout() {
        view.addSubviews(myYelloView)
        
        let tabbarHeight = 60 + safeAreaBottomInset()
        
        myYelloView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(tabbarHeight)
        }
    }
    
    // MARK: Custom Function
    private func setDelegate() {
        myYelloView.myYelloListView.handleMyYelloCellDelegate = self
    }
    
    private func setAddTarget() {
        myYelloView.unlockButton.addTarget(self, action: #selector(unlockButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Network
    func myYello() {
        self.pageCount += 1
        let queryDTO = MyYelloRequestQueryDTO(page: pageCount)
        
        if isFinishPaging {
            return
        }
        
        isLoadingData = false
        
        NetworkService.shared.myYelloService.myYello(queryDTO: queryDTO) { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoadingData = false
                
                switch response {
                case .success(let data):
                    guard let data = data.data else { return }
                    
                    let totalPage = (data.totalCount) / 10
                    if self.pageCount >= totalPage {
                        self.isFinishPaging = true
                    }
                    
                    let myYelloModels = data.votes.map { myYello in
                        
                        return Yello(id: myYello.id, senderGender: myYello.senderGender, senderName: myYello.senderName, nameHint: myYello.nameHint, vote: Vote(nameHead: myYello.vote.nameHead, nameFoot: myYello.vote.nameFoot, keywordHead: myYello.vote.keywordHead, keyword: myYello.vote.keyword, keywordFoot: myYello.vote.keywordFoot), isHintUsed: myYello.isHintUsed, isRead: myYello.isRead, createdAt: myYello.createdAt)
                    }
                    
                    if self.pageCount == 0 {
                        self.myYelloView.myYelloCount = data.totalCount
                    }
                    
                    //                    self.myYelloView.myYelloCount = data.totalCount
                    self.myYelloView.myYelloListView.myYelloModelDummy.append(contentsOf: myYelloModels)
                    self.myYelloView.myYelloListView.myYelloTableView.reloadData()
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
extension MyYelloViewController {
    @objc private func unlockButtonTapped() {
        let paymentViewController = PaymentViewController()
        navigationController?.pushViewController(paymentViewController, animated: true)
    }
}

// MARK: HandleMyYelloCellDelegate
extension MyYelloViewController: HandleMyYelloCellDelegate {
    func pushMyYelloDetailViewController(index: Int) {
        let myYelloDetailViewController = MyYelloDetailViewController()
        navigationController?.pushViewController(myYelloDetailViewController, animated: true)
        myYelloView.myYelloListView.indexNumber = index
        myYelloDetailViewController.myYelloDetailView.voteIdNumber = myYelloView.myYelloListView.myYelloModelDummy[index].id
        myYelloDetailViewController.myYelloDetail(voteId: myYelloView.myYelloListView.myYelloModelDummy[index].id)
    }
}

extension MyYelloViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if let lastIndexPath = indexPaths.last,
           lastIndexPath.row >= myYelloView.myYelloListView.myYelloModelDummy.count - 1 {
            myYello()
        }
    }
}


extension MyYelloViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = self.myYelloView.myYelloListView.myYelloTableView
        let offsetY = tableView.contentOffset.y
        let contentHeight = tableView.contentSize.height
        let visibleHeight = tableView.bounds.height
        if offsetY > contentHeight - visibleHeight {
            myYello()
        }
    }
}
