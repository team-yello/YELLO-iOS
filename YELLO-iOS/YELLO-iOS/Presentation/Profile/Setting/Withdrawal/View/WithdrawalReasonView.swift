//
//  WithdrawalReasonView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 1/23/24.
//

import UIKit

import SnapKit
import Then

final class WithdrawalReasonView: BaseView {

    let reasonList = [StringLiterals.Profile.WithdrawalReason.nobody,
                      StringLiterals.Profile.WithdrawalReason.expensive,
                      StringLiterals.Profile.WithdrawalReason.error,
                      StringLiterals.Profile.WithdrawalReason.notFunny,
                      StringLiterals.Profile.WithdrawalReason.lessPoint,
                      StringLiterals.Profile.WithdrawalReason.delete,
                      StringLiterals.Profile.WithdrawalReason.otherApp,
                      StringLiterals.Profile.WithdrawalReason.etc]    
    var selectedIndex = -1
    
    let withdrawalNavigationBarView = SettingNavigationBarView()
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    lazy var reasonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: reasonFlowLayout)
    let reasonFlowLayout = UICollectionViewFlowLayout()
    let completeButton = UIButton()
    
    func setCollectionView() {
        reasonCollectionView.register(ReasonCollectionViewCell.self, forCellWithReuseIdentifier: ReasonCollectionViewCell.identifier)
        reasonCollectionView.delegate = self
        reasonCollectionView.dataSource = self
    }
    
    override func setStyle() {
        self.backgroundColor = .black
        
        withdrawalNavigationBarView.do {
            $0.titleLabel.setTextWithLineHeight(text: StringLiterals.Profile.WithdrawalCheck.withdrawal, lineHeight: 24.adjustedHeight)
            $0.backgroundColor = .black
        }
        
        scrollView.do {
            $0.backgroundColor = .clear
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Profile.WithdrawalReason.title, lineHeight: 32.adjustedHeight)
            $0.font = .uiHeadline01
            $0.textColor = .white
        }
        
        reasonCollectionView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.isScrollEnabled = false
            $0.isHidden = false
        }
        
        reasonFlowLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 4.adjustedWidth
            $0.itemSize = CGSize(width: UIScreen.main.bounds.width - 68.adjustedWidth, height: 56.adjustedHeight)
        }
        
        completeButton.do {
            $0.backgroundColor = .black
            $0.layer.borderColor = UIColor.grayscales700.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 24.adjustedHeight
            $0.titleLabel?.font = .uiBodyMedium
            $0.setTitleColor(.semanticStatusRed500, for: .normal)
            $0.setTitle(StringLiterals.Profile.WithdrawalReason.complete, for: .normal)
        }
    }
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        self.addSubviews(withdrawalNavigationBarView,
                         scrollView,
                         completeButton)
        
        scrollView.addSubviews(titleLabel,
                               reasonCollectionView)
        
        withdrawalNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(withdrawalNavigationBarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(39.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        reasonCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20.adjustedHeight)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(476.adjustedHeight)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().inset(108.adjustedHeight)
        }
        
        completeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(48.adjustedHeight)
            $0.width.equalTo(343.adjustedWidth)
            $0.bottom.equalToSuperview().inset(34.adjustedHeight)
        }
    }
}

extension WithdrawalReasonView: UICollectionViewDelegate { }
extension WithdrawalReasonView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reasonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReasonCollectionViewCell.identifier, for: indexPath) as? ReasonCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(data: reasonList[indexPath.row])
        cell.isReasonSelected = (indexPath.row == selectedIndex)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        reasonCollectionView.reloadData()
    }
}
