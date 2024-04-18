//
//  TabBarViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import SafariServices
import UIKit

import Amplitude
import SnapKit
import Then

// MARK: - TabBar

final class YELLOTabBarController: UITabBarController {
    
    private var tabs: [UIViewController] = []
    
    var startStatus: Int = 1 {
        didSet {
            self.setTabBarItems()
            self.setTabBarAppearance()
            self.myYelloViewController.unreadCount()
        }
    }
    private var messageIndex: Int = 0
    private var redirectUrl: String = ""
    let recommendingViewController = RecommendingViewController()
    let aroundViewController = AroundViewController()
    let myYelloViewController = MyYelloViewController()
    let profileViewController = ProfileViewController()
    let votingStartViewController = VotingStartViewController()
    let subscriptionExtensionView = SubscriptionExtensionView()
    let paymentPlusViewController = PaymentPlusViewController()
    let userNotificationView = NotificationView()
    var notificationReadCount = 0
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        network()
        getUserNotification()

        NotificationCenter.default.addObserver(self, selector: #selector(showMessage(_:)), name: NSNotification.Name("showMessage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showPage(_:)), name: NSNotification.Name("showPage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToShop(_:)), name: NSNotification.Name("goToShop"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.delegate = self
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        lunchEvent()
    }
    
    // MARK: - TabBar Height
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight: CGFloat = 60.0
        tabBar.frame.size.height = tabBarHeight + safeAreaHeight
        tabBar.frame.origin.y = view.frame.height - tabBarHeight - safeAreaHeight
    }
    
    // MARK: - TabBar Item
    
    func setTabBarItems() {
        var rootViewController: UIViewController
        /// 친구 수에 따라 rootViewController가 달라짐
        if startStatus == 1 {
            rootViewController = VotingStartViewController()
        } else if startStatus == 2 {
            rootViewController = VotingTimerViewController()
        } else {
            rootViewController = VotingLockedViewController()
        }
        
        tabs = [
            UINavigationController(rootViewController: recommendingViewController),
            UINavigationController(rootViewController: aroundViewController),
            UINavigationController(rootViewController: rootViewController),
            UINavigationController(rootViewController: myYelloViewController),
            UINavigationController(rootViewController: profileViewController)
        ]
        
        TabBarItem.allCases.forEach {
            tabs[$0.rawValue].tabBarItem = $0.asTabBarItem()
            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
        }
        
        setViewControllers(tabs, animated: true)
    }
    
    // MARK: - TabBar Style
    
    func setTabBarAppearance() {
        
        /// 탭 바 아이템의 글씨를 조금 띄우기 위해 titlePositionAdjustment를 설정
        let offset = UIOffset(horizontal: 0, vertical: -7) /// 수직 방향으로 -7만큼
        tabBar.items?.forEach { item in
            item.titlePositionAdjustment = offset
        }
        
        tabBar.items?[2].imageInsets = UIEdgeInsets(top: -23, left: 0, bottom: 0, right: 0)
        view.backgroundColor = .clear
        
        tabBar.tintColor = .yelloMain500
        tabBar.barTintColor = .grayscales600
        tabBar.roundCorners(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        // 탭바만 폰트 기기대응X
        let myFont = UIFont(name: "Pretendard-Bold", size: 10.0)!
        let fontAttributes = [NSAttributedString.Key.font: myFont]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: UIColor(hex: "668099"), alpha: 0.15, x: 0, y: -2, blur: 5)
    }
}

// MARK: - TabBar Custom Font

extension YELLOTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if let selectedViewController = tabBarController.selectedViewController {
            let myFont = UIFont(name: "Pretendard-Bold", size: 10.0)!
            let selectedFontAttributes = [NSAttributedString.Key.font: myFont]
            selectedViewController.tabBarItem.setTitleTextAttributes(selectedFontAttributes, for: .normal)
        }
        
        for (index, controller) in tabBarController.viewControllers!.enumerated() {
            if let tabBarItem = controller.tabBarItem {
                if index != tabBarController.selectedIndex {
                    let myFont = UIFont(name: "Pretendard-Medium", size: 10.0)!
                    let defaultFontAttributes = [NSAttributedString.Key.font: myFont]
                    tabBarItem.setTitleTextAttributes(defaultFontAttributes, for: .normal)
                }
            }
        }
        
        let selectedIndex = tabBarController.selectedIndex
        switch selectedIndex {
        case 0:
            tabBar.items?[2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            recommendingViewController.kakaoFriendViewController.kakaoFriendView.kakaoFriendTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            recommendingViewController.schoolFriendViewController.schoolFriendView.schoolFriendTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case 1:
            tabBar.items?[2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            aroundViewController.aroundView.aroundTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case 3:
            tabBar.items?[2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            myYelloViewController.myYelloView.myYelloListView.myYelloTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case 4:
            tabBar.items?[2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            profileViewController.profileView.myFriendTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        default:
            tabBar.items?[2].imageInsets = UIEdgeInsets(top: -23, left: 0, bottom: 0, right: 0)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let selectedViewController = tabBarController.selectedViewController else {
            return true
        }
        
        if selectedViewController == viewController && tabBarController.selectedIndex == 2 {
            // 현재 선택된 뷰 컨트롤러와 선택될 뷰 컨트롤러가 다르고, 3번째 탭이 선택된 경우
            return false
        }
        
        return true
    }
}

// MARK: - 서버통신

extension YELLOTabBarController {
    func getVotingAvailable() {

        self.setTabBarItems()
        self.setTabBarAppearance()
        self.selectedIndex = 2
        self.myYelloViewController.unreadCount()
        
        NetworkService.shared.votingService.getVotingAvailable {
            result in
            switch result {
            case .success(let data):
                let status = data.status
                guard let data = data.data else { return }
                if status == 200 {
                    if !data.isPossible {
                        self.startStatus = 2
                    }
                } else {
                    self.startStatus = 3
                }
            default:
                print("network failure")
                return
            }
        }
    }
    
    func network() {
        getVotingAvailable()
        /// 추천친구 서버통신
        recommendingViewController.kakaoFriendViewController.kakaoFriendView.kakaoFriends { [weak self] in
            self?.recommendingViewController.kakaoFriendViewController.kakaoFriendView.recommendingKakaoFriend()
        }
        recommendingViewController.schoolFriendViewController.schoolFriendView.recommendingSchoolFriend()
        
        /// 둘러보기 서버통신
        aroundViewController.aroundView.around()
        
        /// 내 쪽지 서버통신
        myYelloViewController.myYelloView.myYelloListView.myYello()
        myYelloViewController.myYelloCount()
        
        /// 내 프로필 서버통신
        profileViewController.profileView.profileFriend()
        profileViewController.profileView.myProfileHeaderView.profileUser()
        
        /// 상점 상품 얻기
        paymentPlusViewController.getProducts()
    }
    
    func getUserNotification() {
        NetworkService.shared.notificationService.userNotification(typeName: "NOTICE") { result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                if data.isAvailable && self.notificationReadCount == 0 {
                    // 다시 보지 않기 버튼을 안눌렀거나 하루가 지났거나 이전 공지와 현재 공지의 title이 다른 경우에만 표시
                    if !UserDefaults.standard.bool(forKey: "isTapped") ||
                        self.hasDayPassed(from: UserDefaults.standard.object(forKey: "tapDate") as? Date ?? Date()) ||
                        UserDefaults.standard.string(forKey: "notificationTitle") != data.title {
                        self.userNotificationView.frame = self.view.bounds
                        self.userNotificationView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                        self.userNotificationView.notificationImageView.kfSetImage(url: data.imageUrl)
                        self.redirectUrl = data.redirectUrl
                        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped))
                        self.userNotificationView.notificationImageView.addGestureRecognizer(tapGesture)
                        self.view.addSubview(self.userNotificationView)
                    }
                }
                
                let notificationTitle = data.title
                UserDefaults.standard.set(notificationTitle, forKey: "notificationTitle")
                
            default:
                print("network failure")
                return
            }
        }
        
        // 유저 대상 공지 확인 후 재구독 유도
        purchaseSubscribeNeed()
    }
    
    // 하루 지났는지 확인하는 함수
    func hasDayPassed(from date: Date) -> Bool {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let startOfToday = calendar.startOfDay(for: currentDate)
        let startOfTappedDate = calendar.startOfDay(for: date)
        
        return calendar.dateComponents([.day], from: startOfTappedDate, to: startOfToday).day ?? 0 > 0
    }

    /// 구독 연장 여부 서버통신
    func purchaseSubscribeNeed() {
        NetworkService.shared.purchaseService.purchaseSubscibeNeed { result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                
                let currentDate = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                if data.subscribe == "canceled" {
                    if let expiredDate = dateFormatter.date(from: data.expiredDate) {
                        let calendar = Calendar.current
                        if let daysDifference = calendar.dateComponents([.day], from: currentDate, to: expiredDate).day {
                            if daysDifference <= 1 {
                                // 하루 이하로 남았으면
                                self.toResubscribeView()
                            }
                        }
                    }
                }
            default:
                print("network failure")
                return
            }
        }
    }
    
    func lunchEvent() {
        NetworkService.shared.eventService.lunchEventCheck { result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                let tags = data.map { $0.tag }
                let containsLunchEvent = tags.contains("LUNCH_EVENT")
                let index = tags.firstIndex(of: "LUNCH_EVENT") ?? 0
                
                if containsLunchEvent && data[index].eventReward != nil {
                    let viewController = LunchEventViewController()
                    UIView.transition(with: self.navigationController?.view ?? UIView(), duration: 0.3, options: .transitionCrossDissolve, animations: {
                        self.navigationController?.pushViewController(viewController, animated: false)
                    })
                }
            default:
                print("network failure")
                return
            }
        }
    }
    
    // MARK: -  Notification
    
    @objc
    func showMessage(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let message = userInfo["message"] as? Int {
                messageIndex = message
            }
        }
    }
    
    @objc
    func showPage(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let index = userInfo["index"] as? Int {
                if index != 5 {
                    self.selectedIndex = index
                }
                if selectedIndex == 2 {
                    tabBar.items?[2].imageInsets = UIEdgeInsets(top: -23, left: 0, bottom: 0, right: 0)
                } else if selectedIndex == 3 {
                    tabBar.items?[2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                    
                    let myYelloDetailViewController = MyYelloDetailViewController()
                    myYelloDetailViewController.myYelloDetail(voteId: Int(messageIndex))
                    self.navigationController?.pushViewController(myYelloDetailViewController, animated: true)
                    
                } else if selectedIndex == 4 {
                    tabBar.items?[2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                } else if selectedIndex == 1 {
                    tabBar.items?[2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                    NotificationCenter.default.post(name: Notification.Name("changeMode"), object: nil, userInfo: nil)
                } else if index == 5 {
                    self.selectedIndex = 3
                    tabBar.items?[2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                }
            }
        }
    }
    
    @objc
    func goToShop(_ notification: Notification) {
        self.selectedIndex = 3
        self.navigationController?.pushViewController(paymentPlusViewController, animated: true)
    }
    
    @objc
    func imageViewTapped() {
        let notiView: SFSafariViewController
        if let url = URL(string: self.redirectUrl) {
            notiView = SFSafariViewController(url: url)
            self.present(notiView, animated: true, completion: nil)
        } else {
            print("유효하지 않은 URL 입니다")
        }
        Amplitude.instance().logEvent("click_notice_popup")
    }
}

extension YELLOTabBarController {
    // 구독 연장 여부 뷰로 가기
    func toResubscribeView() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }

        subscriptionExtensionView.frame = viewController.view.bounds
        subscriptionExtensionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                
        viewController.view.addSubview(subscriptionExtensionView)
    }
}
