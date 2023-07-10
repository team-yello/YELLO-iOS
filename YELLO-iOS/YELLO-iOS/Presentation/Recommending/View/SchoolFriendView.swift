//
//  SchoolFriendView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class SchoolFriendView: UIView {
    
    private let inviteBannerView = InviteBannerView()
    
    var schoolFriendTableViewModel: [FriendModel] = [
        FriendModel(name: "정채은", school: "이화여자대학교 물리학과 21학번", isButtonSelected: false),
//        FriendModel(name: "김채은", school: "이화여자대학교 물리학과 22학번", isButtonSelected: false),
//        FriendModel(name: "이채은", school: "이화여자대학교 물리학과 23학번", isButtonSelected: false),
//        FriendModel(name: "황채은", school: "이화여자대학교 물리학과 24학번", isButtonSelected: false),
//        FriendModel(name: "최채은", school: "이화여자대학교 물리학과 25학번", isButtonSelected: false),
//        FriendModel(name: "윤채은", school: "이화여자대학교 물리학과 26학번", isButtonSelected: false),
//        FriendModel(name: "성채은", school: "이화여자대학교 물리학과 27학번", isButtonSelected: false),
//        FriendModel(name: "박채은", school: "이화여자대학교 물리학과 28학번", isButtonSelected: false),
//        FriendModel(name: "방채은", school: "이화여자대학교 물리학과 29학번", isButtonSelected: false),
//        FriendModel(name: "홍채은", school: "이화여자대학교 물리학과 30학번", isButtonSelected: false),
        FriendModel(name: "백채은", school: "이화여자대학교 융합콘텐츠학과 20학번", isButtonSelected: false)]
    
//    var schoolFriendTableViewModel: [FriendModel] = []
    
    lazy var schoolFriendTableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setDelegate()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SchoolFriendView {
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
        
        schoolFriendTableView.do {
            $0.rowHeight = 77
            $0.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.identifier)
            $0.backgroundColor = .black
            $0.separatorColor = .gray
            $0.separatorStyle = .singleLine
        }
    }
    
    private func setLayout() {
        self.addSubview(inviteBannerView)
        self.addSubview(schoolFriendTableView)

        inviteBannerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(76)
        }
        
        schoolFriendTableView.snp.makeConstraints {
            $0.top.equalTo(inviteBannerView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        schoolFriendTableView.dataSource = self
        schoolFriendTableView.delegate = self
    }

    @objc func addButtonTapped(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: schoolFriendTableView)
        guard let indexPath = schoolFriendTableView.indexPathForRow(at: point) else { return }
       schoolFriendTableViewModel.remove(at: indexPath.row)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.schoolFriendTableView.deleteRows(at: [indexPath], with: .right)
        }
    }
}

extension SchoolFriendView: UITableViewDelegate { }

extension SchoolFriendView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolFriendTableViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as? FriendTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        cell.configureFriendCell(schoolFriendTableViewModel[indexPath.row])
        return cell
    }
}
