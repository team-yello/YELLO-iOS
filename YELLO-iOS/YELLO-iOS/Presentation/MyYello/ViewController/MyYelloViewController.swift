//
//  MyYelloViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

import SnapKit
import Then
import Amplitude

final class MyYelloViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    let myYelloView = MyYelloView()
    let paymentPlusViewController = PaymentPlusViewController()

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
        self.paymentPlusViewController.getProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unreadCount()
        myYelloView.myYelloListView.scrollCount = 0
        Amplitude.instance().logEvent("view_all_messages")
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.items?[2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.myYelloView.myYelloListView.myYelloTableView.reloadData()
        self.myYelloCount()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
            Amplitude.instance().logEvent("click_go_shop", withEventProperties: ["shop_button":"cta_main"])
            navigationController?.pushViewController(paymentPlusViewController, animated: true)
        }
    }
}

// MARK: HandleUnlockButton
extension MyYelloViewController: HandleShopButton {
    func shopButtonTapped() {
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
                    self.myYelloView.myYelloCount = data.totalCount
                    if data.ticketCount == 0 {
                        self.myYelloView.haveTicket = false
                    } else {
                        self.myYelloView.haveTicket = true
                        self.myYelloView.unlockButton.keyCountLabel.text = String(data.ticketCount)
                    }
                    
                    Amplitude.instance().setUserProperties(["user_message_open": data.openCount,
                                                            "user_message_open_keyword": data.openKeywordCount,
                                                            "user_message_open_firstletter": data.openNameCount,
                                                            "user_message_open_fullname": data.openFullNameCount,
                                                            "user_message_received": data.totalCount])
                    
                    print(self.myYelloCount)
                    print("내 옐로 count 통신 성공")
                    self.myYelloView.resetLayout()
                    self.countFetchingMore = false
                default:
                    print("network fail")
                    return
                }
        }
    }
    
    func unreadCount() {
        NetworkService.shared.votingService.getUnreadCount { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                UIApplication.shared.applicationIconBadgeNumber = data.totalCount
                // 탭바 뱃지에 쪽지 개수 반영
                if data.totalCount > 99 {
                    self.tabBarController?.tabBar.items?[3].badgeValue = "99+"
                } else if data.totalCount == 0 {
                    self.tabBarController?.tabBar.items?[3].badgeValue = nil
                } else {
                    self.tabBarController?.tabBar.items?[3].badgeValue = String(data.totalCount)
                }
            default:
                print("network fail")
                return
            }
        }
    }
    
    // MARK: Objc Function
    @objc func refreshTable(refresh: UIRefreshControl) {
        // 실시간으로 쪽지 개수 받아오기 위해 추가
        unreadCount()
        myYelloView.myYelloListView.pageCount = -1
        myYelloView.myYelloListView.isFinishPaging = false
        myYelloView.myYelloListView.fetchingMore = false
        myYelloView.myYelloListView.myYelloTableView.reloadData()
        MyYelloListView.myYelloModelDummy = []
        myYelloView.myYelloListView.myYello()
        refresh.endRefreshing()
    }
}
