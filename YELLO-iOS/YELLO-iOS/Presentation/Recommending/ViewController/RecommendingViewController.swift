//
//  RecommendingViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

import SnapKit
import Then

final class RecommendingViewController: UIViewController {
    
    // MARK: - Variables
    // MARK: Component
    private let recommendingLabel = UILabel()
    private let segmentedControl = RecommendingSegmentedControl(items: [StringLiterals.Recommending.Title.kakaoFriend, StringLiterals.Recommending.Title.schoolFriend])
    private lazy var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    private let kakaoFriendViewController = KakaoFriendViewController()
    private let schoolFriendViewController = SchoolFriendViewController()
    
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
        setSegmentedControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
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
        recommendingLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Recommending.Title.recommend, lineHeight: 28)
            $0.textColor = .white
            $0.font = .uiHeadline03
        }
        pageViewController.do {
            $0.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
        }
    }
    
    private func setLayout() {
        self.navigationController?.navigationBar.isHidden = true
        
        view.addSubviews(
            recommendingLabel,
            segmentedControl,
            pageViewController.view
        )
        
        recommendingLabel.snp.makeConstraints {
            let statusBarHeight = UIApplication.shared.connectedScenes
                        .compactMap { $0 as? UIWindowScene }
                        .first?
                        .statusBarManager?
                        .statusBarFrame.height ?? 20
            
            $0.top.equalTo(view.safeAreaInsets).offset(statusBarHeight + 22.adjusted)
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
        
        segmentedControl.snp.makeConstraints {
            $0.height.equalTo(44.adjusted)
            $0.width.equalToSuperview()
            $0.top.equalTo(recommendingLabel.snp.bottom).inset(-10.adjusted)
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
