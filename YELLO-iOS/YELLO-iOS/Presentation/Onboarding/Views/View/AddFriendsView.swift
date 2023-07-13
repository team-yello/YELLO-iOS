//
//  AddFriendsView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/07.
//

import UIKit

import SnapKit
import Then

class AddFriendsView: BaseView {
    
    // MARK: - Variables
    // MARK: Constants
    /// dummy data
    lazy var kakaoFriendTableViewModel: [FriendModel] = [
        FriendModel(name: "정옐로", school: "솝트대학교 옐로학부 21학번", isButtonSelected: false),
        FriendModel(name: "김옐로", school: "솝트대학교 옐로학부 22학번", isButtonSelected: false),
        FriendModel(name: "이옐로", school: "솝트대학교 옐로학부 23학번", isButtonSelected: false),
        FriendModel(name: "황옐로", school: "솝트대학교 옐로학부 24학번", isButtonSelected: false),
        FriendModel(name: "최옐로", school: "솝트대학교 옐로학부 25학번", isButtonSelected: false),
        FriendModel(name: "윤옐로", school: "솝트대학교 옐로학부 26학번", isButtonSelected: false),
        FriendModel(name: "성옐로", school: "솝트대학교 옐로학부 27학번", isButtonSelected: false),
        FriendModel(name: "박옐로", school: "솝트대학교 옐로학부 28학번", isButtonSelected: false),
        FriendModel(name: "정옐로", school: "솝트대학교 옐로학부 21학번", isButtonSelected: false),
        FriendModel(name: "김옐로", school: "솝트대학교 옐로학부 22학번", isButtonSelected: false),
        FriendModel(name: "이옐로", school: "솝트대학교 옐로학부 23학번", isButtonSelected: false),
        FriendModel(name: "황옐로", school: "솝트대학교 옐로학부 24학번", isButtonSelected: false),
        FriendModel(name: "최옐로", school: "솝트대학교 옐로학부 25학번", isButtonSelected: false),
        FriendModel(name: "윤옐로", school: "솝트대학교 옐로학부 26학번", isButtonSelected: false),
        FriendModel(name: "성옐로", school: "솝트대학교 옐로학부 27학번", isButtonSelected: false),
        FriendModel(name: "박옐로", school: "솝트대학교 옐로학부 28학번", isButtonSelected: false),
        FriendModel(name: "정옐로", school: "솝트대학교 옐로학부 21학번", isButtonSelected: false),
        FriendModel(name: "김옐로", school: "솝트대학교 옐로학부 22학번", isButtonSelected: false),
        FriendModel(name: "이옐로", school: "솝트대학교 옐로학부 23학번", isButtonSelected: false),
        FriendModel(name: "황옐로", school: "솝트대학교 옐로학부 24학번", isButtonSelected: false),
        FriendModel(name: "최옐로", school: "솝트대학교 옐로학부 25학번", isButtonSelected: false),
        FriendModel(name: "윤옐로", school: "솝트대학교 옐로학부 26학번", isButtonSelected: false),
        FriendModel(name: "성옐로", school: "솝트대학교 옐로학부 27학번", isButtonSelected: false),
        FriendModel(name: "박옐로", school: "솝트대학교 옐로학부 28학번", isButtonSelected: false)]
    
    // MARK: Property
    var count = 0
    
    // MARK: Component
    let addFriendsLabel = YelloGuideLabel(labelText: "친구를 추가하세요!")
    let countFriendLabel = UILabel()
    let friendsTableView = UITableView()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        count = kakaoFriendTableViewModel.count

        countFriendLabel.do {
            $0.text = "선택된 친구 \(count)명"
            $0.font = .uiLabelLarge
            $0.textColor = .white
        }
        
        friendsTableView.do {
            $0.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.identifier)
            $0.backgroundColor = .black
            $0.rowHeight = 58
            $0.separatorStyle = .none
            $0.dataSource = self
        }
        
    }
    
    override func setLayout() {
        self.addSubviews(addFriendsLabel, countFriendLabel, friendsTableView)
        
        addFriendsLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constraints.bigMargin)
        }
        
        countFriendLabel.snp.makeConstraints {
            $0.top.equalTo(addFriendsLabel.snp.bottom).offset(Constraints.topMargin)
            $0.trailing.equalToSuperview().inset(Constraints.smallMargin)
        }
        
        friendsTableView.snp.makeConstraints {
            $0.top.equalTo(countFriendLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
            $0.bottom.equalToSuperview()
        }
    }
    
}

// MARK: - extension
// MARK: UITableViewDataSource
extension AddFriendsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kakaoFriendTableViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.identifier) as! FriendsTableViewCell
        if cell.isTapped == true {
            kakaoFriendTableViewModel[indexPath.row].isButtonSelected = true
        }
        cell.delegate = self
        cell.configureFriendCell(kakaoFriendTableViewModel[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: FriendsTableViewCellDelegate
extension AddFriendsView: FriendsTableViewCellDelegate {
    func friendCell(_ cell: FriendsTableViewCell, didTapButtonAt indexPath: IndexPath, isSelected: Bool) {
        // FriendModel의 isButtonSelected 값을 변경
        kakaoFriendTableViewModel[indexPath.row].isButtonSelected = isSelected
        count = kakaoFriendTableViewModel.filter { !$0.isButtonSelected }.count
        countFriendLabel.text = "선택된 친구 \(count)명"
    }
}
