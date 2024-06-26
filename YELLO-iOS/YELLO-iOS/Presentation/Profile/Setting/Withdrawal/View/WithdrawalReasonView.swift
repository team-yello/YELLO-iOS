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
    var isCompleteEnabled = false {
        didSet {
            self.setCompleteButton(isEnabled: isCompleteEnabled)
        }
    }
    var isNoFriendSelected = false
    var etcReason: String = ""
    var tap = UITapGestureRecognizer()
    var withdrawalReason: String = ""
    
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
            $0.layer.borderColor = UIColor.grayscales600.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 24.adjustedHeight
            $0.titleLabel?.font = .uiBodyMedium
            $0.setTitleColor(.grayscales600, for: .normal)
            $0.setTitle(StringLiterals.Profile.WithdrawalReason.complete, for: .normal)
            $0.isEnabled = false
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
    
    func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setCompleteButton(isEnabled: Bool) {
        completeButton.do {
            $0.layer.borderColor = isEnabled ? UIColor.grayscales700.cgColor : UIColor.grayscales600.cgColor
            $0.setTitleColor(isEnabled ? .semanticStatusRed500 : .grayscales600, for: .normal)
            $0.isEnabled = isEnabled
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
            cell.etcTextView.isUserInteractionEnabled = true
            cell.etcTextView.delegate = self
            cell.etcTextView.text = self.etcReason.isEmpty ? StringLiterals.Profile.WithdrawalReason.etcReason : self.etcReason
            cell.etcTextView.textColor = self.etcReason.isEmpty ? .grayscales600 : .white
            self.isCompleteEnabled = !self.etcReason.isEmpty
        } else {
            cell.setTextView(isEtc: false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 91.adjustedHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row != selectedIndex {
            selectedIndex = indexPath.row
            
            isCompleteEnabled = selectedIndex != 7 ? true : false
            reasonCollectionView.reloadData()
            if indexPath.row == 7 {
                let indexPath = IndexPath(item: self.reasonList.count - 1, section: 0)
                reasonCollectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                withdrawalReason = etcReason
            } else {
                withdrawalReason = reasonList[indexPath.row]
                isNoFriendSelected = indexPath.row == 0 ? true : false
            }
        }
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

extension WithdrawalReasonView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        hideKeyboardWhenTappedAround()
        if textView.text == StringLiterals.Profile.WithdrawalReason.etcReason {
            textView.text = nil
            textView.textColor = .white
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text.isEmpty || textView.text == "" || textView.text == StringLiterals.Profile.WithdrawalReason.etcReason {
            self.isCompleteEnabled = false
            textView.text = StringLiterals.Profile.WithdrawalReason.etcReason
            textView.textColor = .grayscales600
            self.etcReason = ""
        } else {
            self.isCompleteEnabled = true
            self.etcReason = textView.text
        }
        withdrawalReason = etcReason
        textView.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let maxCharacterCount = 30
        let currentText = textView.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: text)
        return newText.count <= maxCharacterCount
    }
}

extension WithdrawalReasonView {
    func hideKeyboardWhenTappedAround() {
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = true
        self.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
        self.removeGestureRecognizer(tap)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height - 26.adjustedHeight, right: 0)
            reasonCollectionView.contentInset = scrollIndicatorInsets
            reasonCollectionView.scrollIndicatorInsets = scrollIndicatorInsets
        }
        let indexPath = IndexPath(item: self.reasonList.count - 1, section: 0)
        reasonCollectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        reasonCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 26.adjustedHeight, right: 0)
        reasonCollectionView.scrollIndicatorInsets = .zero
    }
}
