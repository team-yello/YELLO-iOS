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
    
    private var paymentImage = [ImageLiterals.Payment.imgPaymentFirst,
                                ImageLiterals.Payment.imgPaymentSecond,
                                ImageLiterals.Payment.imgPaymentThird]
    
    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 0
        $0.minimumLineSpacing = 0
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: self.flowLayout).then {
        $0.register(PaymentCollectionViewCell.self, forCellWithReuseIdentifier: PaymentCollectionViewCell.paymentIdentifier)
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        $0.isPagingEnabled = true
        $0.backgroundColor = .clear
    }
    
    private let pageControl = UIPageControl().then {
        $0.numberOfPages = 3
        $0.currentPage = 0
        $0.pageIndicatorTintColor = .grayscales700
        $0.currentPageIndicatorTintColor = .white
        $0.transform = CGAffineTransform(scaleX: 1, y: 1)
    }
    
    override func setStyle() {
        self.backgroundColor = .clear
    }
    
    override func setLayout() {
        self.addSubviews(collectionView,
                         pageControl)
        
        self.snp.makeConstraints {
            $0.height.equalTo(228.adjustedHeight)
            $0.width.equalTo(375.adjustedWidth)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(219.adjustedHeight)
            $0.width.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalTo(collectionView)
            $0.top.equalTo(collectionView.snp.bottom).offset(3.adjustedHeight)
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
}

extension PaymentView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 219.adjustedHeight)
    }
}
