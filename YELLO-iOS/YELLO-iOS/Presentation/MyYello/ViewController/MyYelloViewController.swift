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
    let myYelloView = MyYelloView()
    var countFetchingMore: Bool = false {
        didSet {
            if countFetchingMore {
                self.myYelloView.myYellowNavigationBarView.myYelloRefresh()
            } else {
                self.myYelloView.myYellowNavigationBarView.myYelloStopRefresh()
            }
        }
    }
    
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
        self.navigationController?.navigationBar.isHidden = true
        self.myYelloView.myYelloListView.myYelloTableView.reloadData()
    }
    
    // MARK: Layout Helpers
    override func setStyle() {
        view.backgroundColor = .black
    }
    
    override func setLayout() {
        view.addSubviews(myYelloView)
        
        let tabbarHeight = 60 + safeAreaBottomInset()
        
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        myYelloView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().inset(tabbarHeight)
        }
    }
    
    // MARK: Custom Function
    private func setDelegate() {
        myYelloView.myYelloListView.handleMyYelloCellDelegate = self
        myYelloView.handleUnlockButton = self
        myYelloView.myYellowNavigationBarView.handleShopButton = self
    }
    
    private func setAddTarget() {
        myYelloView.myYelloListView.refreshControl.addTarget(self, action: #selector(refreshCount), for: .valueChanged)
        myYelloView.myYelloListView.refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)

    }
    
    @objc func refreshCount() {
        self.myYelloCount()
    }
}

// MARK: - extension
// MARK: HandleUnlockButton
extension MyYelloViewController: HandleUnlockButton {
    func unlockButtonTapped() {
        if myYelloView.haveTicket {
            view.showToast(message: StringLiterals.MyYello.List.toastMessage)
        } else {
            let paymentPlusViewController = PaymentPlusViewController()
            navigationController?.pushViewController(paymentPlusViewController, animated: true)
        }
    }
}

// MARK: HandleUnlockButton
extension MyYelloViewController: HandleShopButton {
    func shopButtonTapped() {
        let paymentPlusViewController = PaymentPlusViewController()
        navigationController?.pushViewController(paymentPlusViewController, animated: true)
    }
}

// MARK: HandleMyYelloCellDelegate
extension MyYelloViewController: HandleMyYelloCellDelegate {
    func pushMyYelloDetailViewController(index: Int) {
            let myYelloDetailViewController = MyYelloDetailViewController()
            self.navigationController?.pushViewController(myYelloDetailViewController, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.myYelloView.myYelloListView.indexNumber = index
            myYelloDetailViewController.myYelloDetailView.voteIdNumber = MyYelloListView.myYelloModelDummy[index].id
            myYelloDetailViewController.myYelloDetail(voteId: MyYelloListView.myYelloModelDummy[index].id)
            myYelloDetailViewController.myYelloDetailView.indexNumber = index
        }
    }
}

extension MyYelloViewController {
    func myYelloCount() {
        
        if countFetchingMore {
            return
        }
        
        countFetchingMore = true
        
        let queryDTO = MyYelloRequestQueryDTO(page: 0)

        NetworkService.shared.myYelloService.myYello(queryDTO: queryDTO) { [weak self] response in
            guard let self = self else { return }
                switch response {
                case .success(let data):
                    guard let data = data.data else { return }

                    myYelloView.myYelloCount = data.totalCount
                    print(self.myYelloCount)
                    print("내 옐로 count 통신 성공")
                    self.myYelloView.resetLayout()
                    countFetchingMore = false
                default:
                    print("network fail")
                    return
                }
        }
    }
    
    // MARK: Objc Function
    @objc func refreshTable(refresh: UIRefreshControl) {
        myYelloView.myYelloListView.pageCount = -1
        myYelloView.myYelloListView.isFinishPaging = false
        myYelloView.myYelloListView.fetchingMore = false
        myYelloView.myYelloListView.myYelloTableView.reloadData()
        MyYelloListView.myYelloModelDummy = []
        myYelloView.myYelloListView.myYello()
        refresh.endRefreshing()
    }
}
