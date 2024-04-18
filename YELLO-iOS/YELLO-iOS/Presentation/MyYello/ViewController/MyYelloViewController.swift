//
//  MyYelloViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

import Amplitude
import GoogleMobileAds
import Lottie
import SnapKit
import Then

final class MyYelloViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Constants
    let interstitialId = Config.myYelloAd
    
    // MARK: Property
    private var interstitial: GADInterstitialAd?
    var myYelloViewCount = UserDefaults.standard.integer(forKey: "myYelloCount")
    var indexNumber: Int = 0
    
    // MARK: Component
    let loadingView = YelloLoadingView()
    let myYelloView = MyYelloView()
    let paymentPlusViewController = PaymentPlusViewController()
    
    var noticeURL: String?
    
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
        self.myYelloNotice()
    }
    
    // MARK: Layout Helpers
    override func setStyle() {
        view.backgroundColor = .black
    }
    
    override func setLayout() {
        view.addSubviews(myYelloView, loadingView)
        
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
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
        myYelloView.myYellowNavigationBarView.noticeButton.addTarget(self, action: #selector(myYelloNoticeButtonTapped), for: .touchUpInside)
        
    }
    
    private func setGoogleAds() {
        Amplitude.instance().logEvent("click_adsense", withEventProperties: ["adsense_view": "message"])
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: interstitialId,
                               request: request) { ad, error in
            if let error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                self.loadingView.stopIndicator()
                return
            }
            self.interstitial = ad
            ad?.fullScreenContentDelegate = self
            DispatchQueue.main.async {
                ad?.present(fromRootViewController: self)
                self.loadingView.stopIndicator()
                self.view.isUserInteractionEnabled = true
            }
        }
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
        self.indexNumber = index
        let myYelloDetailViewController = MyYelloDetailViewController()

        self.myYelloView.myYelloListView.indexNumber = self.indexNumber
        myYelloDetailViewController.myYelloDetailView.voteIdNumber = MyYelloListView.myYelloModelDummy[self.indexNumber].id
        myYelloDetailViewController.myYelloDetail(voteId: MyYelloListView.myYelloModelDummy[self.indexNumber].id)
        myYelloDetailViewController.myYelloDetailView.indexNumber = self.indexNumber
        
        myYelloViewCount += 1
        UserDefaults.standard.set(myYelloViewCount, forKey: "myYelloCount")
        print("My Yello Count = \(myYelloViewCount)")
        
        if UserManager.shared.isYelloPlus {
            self.navigationController?.pushViewController(myYelloDetailViewController, animated: true)
        } else {
            if myYelloViewCount == 3 || myYelloViewCount % 5 == 3 {
                self.loadingView.showIndicator()
                self.setGoogleAds()
            } else {
                self.navigationController?.pushViewController(myYelloDetailViewController, animated: true)
            }
            
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
                    UserManager.shared.userTicketCount = data.ticketCount
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
        myYelloNotice()
        refresh.endRefreshing()
    }
    
    func myYelloNotice() {
        NetworkService.shared.notificationService.userNotification(typeName: "BANNER") { result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                self.myYelloView.myYellowNavigationBarView.noticeButtonLabel.text = data.title
                self.myYelloView.myYellowNavigationBarView.clickMeButtonLabel.isHidden = data.redirectUrl.isEmpty
                self.myYelloView.myYellowNavigationBarView.noticeButton.isEnabled = !data.redirectUrl.isEmpty
                self.noticeURL = data.redirectUrl
            default:
                print("서버 통신 오류")
            }
        }
    }
    
    @objc func myYelloNoticeButtonTapped() {
        let url = URL(string: noticeURL ?? "") ?? URL(fileURLWithPath: "")
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        Amplitude.instance().logEvent("click_message_banner")
    }
}

// MARK: - GADInterstitialDelegate
extension MyYelloViewController: GADFullScreenContentDelegate {
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        Amplitude.instance().logEvent("complete_adsense", withEventProperties: ["adsense_view": "message"])

        let myYelloDetailViewController = MyYelloDetailViewController()

        self.myYelloView.myYelloListView.indexNumber = self.indexNumber
        myYelloDetailViewController.myYelloDetailView.voteIdNumber = MyYelloListView.myYelloModelDummy[self.indexNumber].id
        myYelloDetailViewController.myYelloDetail(voteId: MyYelloListView.myYelloModelDummy[self.indexNumber].id)
        myYelloDetailViewController.myYelloDetailView.indexNumber = self.indexNumber
        
        self.navigationController?.pushViewController(myYelloDetailViewController, animated: true)
    }
}
