//
//  TabBarViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

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
    let recommendingViewController = RecommendingViewController()
    let aroundViewController = AroundViewController()
    let myYelloViewController = MyYelloViewController()
    let profileViewController = ProfileViewController()
    let votingStartViewController = VotingStartViewController()
    let subscriptionExtensionView = SubscriptionExtensionView()
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        network()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showMessage(_:)), name: NSNotification.Name("showMessage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showPage(_:)), name: NSNotification.Name("showPage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToShop(_:)), name: NSNotification.Name("goToShop"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        toResubscribeView()

        self.delegate = self
        self.navigationController?.navigationBar.isHidden = true
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
                self.selectedIndex = index
                if selectedIndex == 2 {
                    tabBar.items?[2].imageInsets = UIEdgeInsets(top: -23, left: 0, bottom: 0, right: 0)
                } else if selectedIndex == 3 {
                    tabBar.items?[2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                    
                    let myYelloDetailViewController = MyYelloDetailViewController()
                    NetworkService.shared.myYelloService.myYelloDetail(voteId: messageIndex) { response in
                        switch response {
                        case .success(let data):
                            guard let data = data.data else { return }
                            
                            myYelloDetailViewController.myYelloDetailView.voteIdNumber = self.messageIndex
                            myYelloDetailViewController.colorIndex = data.colorIndex
                            myYelloDetailViewController.myYelloDetailView.currentPoint = data.currentPoint
                            myYelloDetailViewController.myYelloDetailView.detailSenderView.isHidden = false
                            myYelloDetailViewController.myYelloDetailView.detailKeywordView.isHidden = false
                            myYelloDetailViewController.myYelloDetailView.genderLabel.isHidden = false
                            myYelloDetailViewController.myYelloDetailView.instagramButton.isHidden = false
                            myYelloDetailViewController.myYelloDetailView.keywordButton.isHidden = false
                            myYelloDetailViewController.myYelloDetailView.senderButton.isHidden = false
                            myYelloDetailViewController.setBackgroundView()
                            
                            if data.senderGender == "MALE" {
                                myYelloDetailViewController.myYelloDetailView.genderLabel.text = StringLiterals.MyYello.Detail.male
                            } else {
                                myYelloDetailViewController.myYelloDetailView.genderLabel.text = StringLiterals.MyYello.Detail.female
                            }
                            
                            if data.vote.nameHead == nil {
                                myYelloDetailViewController.myYelloDetailView.detailKeywordView.nameKeywordLabel.text = "너" + (data.vote.nameFoot ?? "")
                            } else {
                                myYelloDetailViewController.myYelloDetailView.detailKeywordView.nameKeywordLabel.text = (data.vote.nameHead ?? "") + " 너" + (data.vote.nameFoot ?? "")
                            }
                            
                            myYelloDetailViewController.myYelloDetailView.detailKeywordView.keywordHeadLabel.text = (data.vote.keywordHead ?? "")
                            myYelloDetailViewController.myYelloDetailView.detailKeywordView.keywordLabel.text = data.vote.keyword
                            myYelloDetailViewController.myYelloDetailView.detailKeywordView.keywordFootLabel.text = (data.vote.keywordFoot ?? "")
                            
                            myYelloDetailViewController.myYelloDetailView.isKeywordUsed = data.isAnswerRevealed

                            if data.nameHint == 0 {
                                myYelloDetailViewController.myYelloDetailView.isSenderUsed = true
                                if let initial = myYelloDetailViewController.getFirstInitial(data.senderName as NSString, index: 0) {
                                    myYelloDetailViewController.myYelloDetailView.detailSenderView.senderLabel.text = initial
                                }
                            } else if data.nameHint == 1 {
                                myYelloDetailViewController.myYelloDetailView.isSenderUsed = true
                                if let initial = myYelloDetailViewController.getSecondInitial(data.senderName as NSString, index: 1) {
                                    myYelloDetailViewController.myYelloDetailView.detailSenderView.senderLabel.text = initial
                                }
                            } else if data.nameHint == -3 {
                                myYelloDetailViewController.myYelloDetailView.isSenderUsed = true
                                myYelloDetailViewController.myYelloDetailView.detailSenderView.senderLabel.text = data.senderName
                                myYelloDetailViewController.myYelloDetailView.isKeywordUsed = true
                                myYelloDetailViewController.myYelloDetailView.senderButton.setButtonState(state: .noTicket)
                                myYelloDetailViewController.myYelloDetailView.keywordButton.isHidden = true
                                myYelloDetailViewController.myYelloDetailView.haveTicket = false
                                myYelloDetailViewController.myYelloDetailView.senderButton.snp.makeConstraints {
                                    $0.top.equalTo(myYelloDetailViewController.myYelloDetailView.instagramButton.snp.bottom).offset(77.adjustedHeight)
                                }
                            }
                            if data.isSubscribe {
                                myYelloDetailViewController.myYelloDetailView.isPlus = true
                            }
                            myYelloDetailViewController.myYelloDetailView.ticketCount = data.ticketCount
                            self.navigationController?.pushViewController(myYelloDetailViewController, animated: true)
                        default:
                            print("network fail")
                            return
                        }
                    }
                    
                } else if selectedIndex == 4 {
                    tabBar.items?[2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                }
            }
        }
    }
    
    @objc
    func goToShop(_ notification: Notification) {
        self.selectedIndex = 3
        let paymentPlusViewController = PaymentPlusViewController()
        self.navigationController?.pushViewController(paymentPlusViewController, animated: true)
    }
}

extension YELLOTabBarController {
    func toResubscribeView() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }

        // subscriptionView 서버통신
        subscriptionExtensionView.frame = viewController.view.bounds
        subscriptionExtensionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                
        viewController.view.addSubview(subscriptionExtensionView)
    }
}
