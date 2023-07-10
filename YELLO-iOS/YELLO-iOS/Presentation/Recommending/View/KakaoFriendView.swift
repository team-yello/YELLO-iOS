//
//  KakaoFriendView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class KakaoFriendView: UIView {
    
    private let inviteBannerView = InviteBannerView()
    
    var kakaoFriendTableViewModel: [FriendModel] = [
        FriendModel(name: "정채은", school: "이화여자대학교 융합콘텐츠학과 21학번", isButtonSelected: false),
        FriendModel(name: "김채은", school: "이화여자대학교 융합콘텐츠학과 22학번", isButtonSelected: false),
        FriendModel(name: "이채은", school: "이화여자대학교 융합콘텐츠학과 23학번", isButtonSelected: false),
        FriendModel(name: "황채은", school: "이화여자대학교 융합콘텐츠학과 24학번", isButtonSelected: false),
        FriendModel(name: "최채은", school: "이화여자대학교 융합콘텐츠학과 25학번", isButtonSelected: false),
        FriendModel(name: "윤채은", school: "이화여자대학교 융합콘텐츠학과 26학번", isButtonSelected: false),
        FriendModel(name: "성채은", school: "이화여자대학교 융합콘텐츠학과 27학번", isButtonSelected: false),
        FriendModel(name: "박채은", school: "이화여자대학교 융합콘텐츠학과 28학번", isButtonSelected: false),
        FriendModel(name: "방채은", school: "이화여자대학교 융합콘텐츠학과 29학번", isButtonSelected: false),
        FriendModel(name: "홍채은", school: "이화여자대학교 융합콘텐츠학과 30학번", isButtonSelected: false),
        FriendModel(name: "백채은", school: "이화여자대학교 융합콘텐츠학과 20학번", isButtonSelected: false)]
    
    lazy var kakaoFriendTableView = UITableView()
    
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

extension KakaoFriendView {
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
        
        kakaoFriendTableView.do {
            $0.rowHeight = 77
            $0.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.identifier)
            $0.backgroundColor = .black
            $0.separatorColor = .grayscales800
            $0.separatorStyle = .singleLine
        }
    }
    
    private func setLayout() {
        self.addSubviews(
            inviteBannerView,
            kakaoFriendTableView)
        
        inviteBannerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
            $0.height.equalTo(76.adjustedHeight)
        }
        
        kakaoFriendTableView.snp.makeConstraints {
            $0.top.equalTo(inviteBannerView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
            $0.bottom.equalToSuperview()
        }
    }
    private func setDelegate() {
        kakaoFriendTableView.dataSource = self
        kakaoFriendTableView.delegate = self
    }
    
    @objc func addButtonTapped(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: kakaoFriendTableView)
        guard let indexPath = kakaoFriendTableView.indexPathForRow(at: point) else { return }
        kakaoFriendTableViewModel.remove(at: indexPath.row)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.kakaoFriendTableView.deleteRows(at: [indexPath], with: .right)
        }
    }
}

extension KakaoFriendView: UITableViewDelegate { }

extension KakaoFriendView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kakaoFriendTableViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as? FriendTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        cell.configureFriendCell(kakaoFriendTableViewModel[indexPath.row])
        return cell
    }
}
