//
//  PaymentView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class PaymentView: BaseView {
    
    var nowPage: Int = 0
    private var paymentImage = [ImageLiterals.Payment.imgPaymentFirst,
                                ImageLiterals.Payment.imgPaymentSecond,
                                ImageLiterals.Payment.imgPaymentThird]
    
    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 0
        $0.minimumLineSpacing = 0
    }
    
    lazy var collectionView = UICollectionView(frame: .zero,
                                               collectionViewLayout: self.flowLayout).then {
        $0.register(PaymentCollectionViewCell.self, forCellWithReuseIdentifier: PaymentCollectionViewCell.paymentIdentifier)
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        $0.isPagingEnabled = true
        $0.backgroundColor = .clear
    }
    lazy var pageControl = UIPageControl()
    let pageControlStackView = UIStackView()
    let pageControlFirst = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: 6))
    let pageControlSecond = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: 6))
    let pageControlThird = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: 6))
    
    override func setStyle() {
        self.backgroundColor = .clear
        
        pageControlStackView.do {
            $0.spacing = 8.adjustedWidth
            $0.axis = .horizontal
            $0.addArrangedSubviews(pageControlFirst, pageControlSecond, pageControlThird)
        }
        
        pageControl.do {
            $0.numberOfPages = 3
            $0.currentPage = 0
            $0.pageIndicatorTintColor = .grayscales700
            $0.currentPageIndicatorTintColor = .white
        }
    }
    
    override func setLayout() {
        self.addSubviews(collectionView,
                         pageControl)
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(219)
            $0.width.equalTo(375.adjustedWidth)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalTo(collectionView)
            $0.top.equalTo(collectionView.snp.bottom).offset(-3.adjustedHeight)
        }
    }
}

extension PaymentView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paymentImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentCollectionViewCell.paymentIdentifier, for: indexPath) as? PaymentCollectionViewCell else { return UICollectionViewCell() }
        cell.configurePaymentCell(paymentImage[indexPath.row])
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / self.frame.width)
        self.pageControl.currentPage = page
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.size.width
        let x = scrollView.contentOffset.x + (width/2)
        
        let newPage = Int(x/width)
        if pageControl.currentPage != newPage {
            pageControl.currentPage = newPage
        }
    }
    
    private func updatePageControlForPage(_ page: Int) {
        // Update your page control UI here based on the current page
        UIView.animate(withDuration: 0.3) {
            self.pageControlFirst.backgroundColor = (page == 0) ? .white : .grayscales700
            self.pageControlSecond.backgroundColor = (page == 1) ? .white : .grayscales700
            self.pageControlThird.backgroundColor = (page == 2) ? .white : .grayscales700
        }
    }
    
    /// 컬렉션뷰 감속 끝났을 때 현재 페이지 체크
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

extension PaymentView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375.adjustedWidth, height: 219)
    }
}

extension PaymentView {
    /// 3초마다 실행되는 타이머
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    // 배너 움직이는 매서드
    func bannerMove() {
        /// 현재페이지가 마지막 페이지일 경우
        if nowPage == paymentImage.count-1 {
            /// 맨 처음 페이지로 돌아감
            collectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            nowPage = 0
            return
        }
        /// 다음 페이지로 전환
        nowPage += 1
        collectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
    }
}
