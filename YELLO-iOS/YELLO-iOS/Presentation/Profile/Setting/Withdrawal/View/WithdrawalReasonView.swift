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
    let reasonHeaderView = ReasonHeaderView()
    lazy var reasonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: reasonFlowLayout)
    let reasonFlowLayout = UICollectionViewFlowLayout()
    let completeButton = UIButton()
    
    func setCollectionView() {
        reasonCollectionView.register(ReasonCollectionViewCell.self, forCellWithReuseIdentifier: ReasonCollectionViewCell.identifier)
        reasonCollectionView.register(ReasonHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReasonHeaderView.identifier)
        reasonCollectionView.delegate = self
        reasonCollectionView.dataSource = self
    }
    
    override func setStyle() {
        self.backgroundColor = .black
        
        withdrawalNavigationBarView.do {
            $0.titleLabel.setTextWithLineHeight(text: StringLiterals.Profile.WithdrawalCheck.withdrawal, lineHeight: 24.adjustedHeight)
            $0.backgroundColor = .black
        }
        
        reasonCollectionView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 26.adjustedHeight, right: 0)
        }
        
        reasonFlowLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 4.adjustedWidth
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
                         reasonCollectionView,
                         completeButton)
        
        withdrawalNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        reasonCollectionView.snp.makeConstraints {
            $0.top.equalTo(withdrawalNavigationBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().inset(82.adjustedHeight)
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReasonHeaderView.identifier, for: indexPath) as? ReasonHeaderView else {
                return ReasonHeaderView()
            }
            
            header.setUI()
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReasonCollectionViewCell.identifier, for: indexPath) as? ReasonCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(data: reasonList[indexPath.row])
        cell.isReasonSelected = (indexPath.row == selectedIndex)
        if selectedIndex == 7 && indexPath.row == 7 {
            cell.setTextView(isEtc: true)
        } else {
            cell.setTextView(isEtc: false)
        }
        cell.isUserInteractionEnabled = !cell.isReasonSelected
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 91.adjustedHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        reasonCollectionView.reloadData()
    }
}

extension WithdrawalReasonView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if selectedIndex == 7 && indexPath.row == 7 {
            return CGSize(width: UIScreen.main.bounds.width - 68.adjustedWidth, height: 141.adjustedHeight)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 68.adjustedWidth, height: 56.adjustedHeight)
        }
    }
}
