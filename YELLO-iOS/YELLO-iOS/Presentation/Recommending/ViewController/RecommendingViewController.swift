//
//  RecommendingViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/05.
//

import UIKit

import Amplitude
import SnapKit
import Then

final class RecommendingViewController: UIViewController {
    
    // MARK: - Variables
    // MARK: Component
    private let recommendingNavigationBarView = RecommendingNavigationBarView()
    private let segmentedControl = RecommendingSegmentedControl(items: [StringLiterals.Recommending.Title.kakaoFriend, StringLiterals.Recommending.Title.schoolFriend])
    private lazy var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    let kakaoFriendViewController = KakaoFriendViewController()
    let schoolFriendViewController = SchoolFriendViewController()
    let recommendProfileViewController = RecommendProfileViewController()
    var currentFriendViewController: UIViewController {
        return dataViewControllers[currentPage]
    }
    
    // MARK: Property
    var dataViewControllers: [UIViewController] {
        [self.kakaoFriendViewController, self.schoolFriendViewController]
    }
    
    /// 이동 방향을 결정해주는 변수, 방향 애니메이션을 위함
    var currentPage: Int = 0 {
      didSet {
        let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
        self.pageViewController.setViewControllers(
          [dataViewControllers[self.currentPage]],
          direction: direction,
          animated: true,
          completion: nil
        )
      }
    }
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setDelegate()
        setAddTarget()
        setSegmentedControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Amplitude.instance().logEvent("click_recommend_navigation")
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - extension
extension RecommendingViewController {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        view.backgroundColor = .black
        pageViewController.do {
            $0.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
        }
    }
    
    private func setLayout() {
        self.navigationController?.navigationBar.isHidden = true
        
        view.addSubviews(
            recommendingNavigationBarView,
            segmentedControl,
            pageViewController.view
        )
        
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        recommendingNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints {
            $0.height.equalTo(44.adjustedHeight)
            $0.width.equalToSuperview()
            $0.top.equalTo(recommendingNavigationBarView.snp.bottom)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    private func setDelegate() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
        schoolFriendViewController.schoolFriendView.handleFriendCellDelegate = self
        kakaoFriendViewController.kakaoFriendView.handleFriendCellDelegate = self
        recommendProfileViewController.recommendFriendProfileView.handleAddFriendButtonDelegate = self
    }
    
    private func setAddTarget() {
        recommendingNavigationBarView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private func setSegmentedControl() {
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.grayscales700, .font: UIFont.uiBodyLarge], for: .normal)
        self.segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.yelloMain500,
             .font: UIFont.uiSubtitle02], for: .selected)
        self.segmentedControl.addTarget(self, action: #selector(changeValue(control:)), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = 0
        self.changeValue(control: self.segmentedControl)
    }
    
    // MARK: Objc Function
    @objc private func changeValue(control: UISegmentedControl) {
        self.currentPage = control.selectedSegmentIndex
    }
    
    @objc private func searchButtonTapped() {
        let searchViewController = FriendSearchViewController()
        Amplitude.instance().logEvent("click_search_button")
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    // MARK: Network Helpers
    private func friendsDetailProfile(id: Int) {
        NetworkService.shared.recommendingService.recommendingDetailFriend(friendId: id) {  response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                self.recommendProfileViewController.recommendFriendProfileView.configureMyProfileFriendDetailCell(data)
                print("통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
}

// MARK: UIPageViewControllerDelegate
extension RecommendingViewController: UIPageViewControllerDelegate { }

// MARK: UIPageViewControllerDataSource
extension RecommendingViewController: UIPageViewControllerDataSource {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let index = self.dataViewControllers.firstIndex(of: viewController),
            index - 1 >= 0
        else { return nil }
        return self.dataViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.dataViewControllers.firstIndex(of: viewController),
            index + 1 < self.dataViewControllers.count
        else { return nil }
        return self.dataViewControllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?[0],
            let index = self.dataViewControllers.firstIndex(of: viewController)
        else { return }
        self.currentPage = index
        self.segmentedControl.selectedSegmentIndex = index
    }
}

// MARK: HandleFriendCellDelegate
extension RecommendingViewController: HandleFriendCellDelegate {
    func presentModal(index: Int) {
        friendsDetailProfile(id: index)
        
        let nav = UINavigationController(rootViewController: recommendProfileViewController)
        
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
                present(nav, animated: true, completion: nil)
            }
        }
    }
}

extension RecommendingViewController: HandleAddFriendButtonDelegate {
    func addFriendButtonTapped(id: Int) {
        if currentFriendViewController == schoolFriendViewController {
            schoolFriendViewController.schoolFriendView.addFriendAtModal(friendId: id)
        } else if currentFriendViewController == kakaoFriendViewController {
            kakaoFriendViewController.kakaoFriendView.addFriendAtModal(friendId: id)
        }
    }
}
