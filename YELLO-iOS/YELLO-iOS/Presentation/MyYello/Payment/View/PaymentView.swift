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
        
        pageControlFirst.do {
            $0.backgroundColor = .white
            $0.makeCornerRound(radius: 3)
        }
        
        pageControlSecond.do {
            $0.backgroundColor = .grayscales700
            $0.makeCornerRound(radius: 3)
        }
        
        pageControlThird.do {
            $0.backgroundColor = .grayscales700
            $0.makeCornerRound(radius: 3)
        }
    }
    
    override func setLayout() {
        self.addSubviews(collectionView,
                         pageControlStackView)
        
//        self.snp.makeConstraints {
//            $0.height.equalTo(228.adjustedHeight)
//            $0.width.equalTo(375.adjustedWidth)
//        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(219)
            $0.width.equalTo(375.adjustedWidth)
        }
        
        pageControlFirst.snp.makeConstraints {
            $0.width.height.equalTo(6)
        }
        
        pageControlSecond.snp.makeConstraints {
            $0.width.height.equalTo(6)
        }
        
        pageControlThird.snp.makeConstraints {
            $0.width.height.equalTo(6)
        }
        
        pageControlStackView.snp.makeConstraints {
            $0.centerX.equalTo(collectionView)
            $0.top.equalTo(collectionView.snp.bottom).offset(3.adjustedHeight)
            $0.height.equalTo(6)
            $0.width.equalTo(34)
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
        let pageWidth = collectionView.bounds.size.width
        let currentPage = Int(targetContentOffset.pointee.x / pageWidth)
        updatePageControlForPage(currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.size.width
        let currentPage = Int((scrollView.contentOffset.x + (pageWidth / 2)) / pageWidth)
        updatePageControlForPage(currentPage)
    }
    
    private func updatePageControlForPage(_ page: Int) {
        // Update your page control UI here based on the current page
        UIView.animate(withDuration: 0.3) {
            self.pageControlFirst.backgroundColor = (page == 0) ? .white : .grayscales700
            self.pageControlSecond.backgroundColor = (page == 1) ? .white : .grayscales700
            self.pageControlThird.backgroundColor = (page == 2) ? .white : .grayscales700
        }
    }
}

extension PaymentView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375.adjustedWidth, height: 219)
    }
}
