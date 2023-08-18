//
//  AddFriendsView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/07.
//
/// TO DO
/// 싱글톤으로
/// 뷰 안에서 상태관리하는 게 더 좋을 것 같다!

import UIKit

import SnapKit
import Then

class AddFriendsView: BaseView {
    
    // MARK: - Variables
    // MARK: Constants
    /// dummy data
    lazy var joinedFriendsList: [FriendAdd] = [] {
        didSet {
            self.friendsTableView.reloadData()
        }
    }
    
    // MARK: Property
    var count = 0 {
        didSet {
            countFriendLabel.text = "선택된 친구 \(count)명"
            countFriendLabel.asColors(targetStrings: ["선택된 친구", "명"], color: .white)
        }
    }
    
    // MARK: Component
    let addFriendsLabel = YelloGuideLabel(labelText: StringLiterals.Onboarding.addFriendText)
    let subGuideLabel =  UILabel()
    let countFriendLabel = UILabel()
    let friendsTableView = UITableView()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        count = joinedFriendsList.count
        
        subGuideLabel.do {
            $0.text = StringLiterals.Onboarding.addFriendSubText
            $0.font = .uiBodySmall
            $0.textColor = .grayscales500
            $0.setTextWithLineHeight(text: subGuideLabel.text, lineHeight: 22.adjustedHeight)
        }
        
        countFriendLabel.do {
            $0.text = "선택된 친구 \(count)명"
            $0.font = .uiLabelLarge
            $0.textColor = .purpleSub400
            
            $0.asColors(targetStrings: ["선택된 친구", "명"], color: .white)
        }
        
        friendsTableView.do {
            $0.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.identifier)
            $0.backgroundColor = .black
            $0.rowHeight = 58.adjusted
            $0.separatorStyle = .none
            $0.dataSource = self
        }
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        friendsTableView.tableFooterView = footerView
        
    }
    
    override func setLayout() {
        self.addSubviews(addFriendsLabel, subGuideLabel, countFriendLabel, friendsTableView)
        
        addFriendsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constraints.topMargin)
            $0.centerX.equalToSuperview()
        }
        
        subGuideLabel.snp.makeConstraints {
            $0.top.equalTo(addFriendsLabel.snp.bottom).offset(6.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        countFriendLabel.snp.makeConstraints {
            $0.top.equalTo(subGuideLabel.snp.bottom).offset(20.adjusted)
            $0.trailing.equalToSuperview().inset(Constraints.smallMargin)
        }
        
        friendsTableView.snp.makeConstraints {
            $0.top.equalTo(countFriendLabel.snp.bottom).offset(18.adjusted)
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
            $0.bottom.equalToSuperview()
        }
    }
    
}

// MARK: - extension
// MARK: UITableViewDataSource
extension AddFriendsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return joinedFriendsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.identifier) as! FriendsTableViewCell
        
        if cell.isTapped == true {
            joinedFriendsList[indexPath.row].isAdded = true
        }
        cell.delegate = self
        cell.configureFriendCell(joinedFriendsList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: FriendsTableViewCellDelegate
extension AddFriendsView: FriendsTableViewCellDelegate {
    func friendCell(_ cell: FriendsTableViewCell, didTapButtonAt indexPath: IndexPath, isSelected: Bool) {
        // FriendModel의 isButtonSelected 값을 변경
        joinedFriendsList[indexPath.row].isAdded = isSelected
        var currentCount =  count - joinedFriendsList.filter { $0.isAdded }.count
        countFriendLabel.text = "선택된 친구 \(currentCount)명"
        countFriendLabel.asColors(targetStrings: ["선택된 친구", "명"], color: .white)
    }
}
