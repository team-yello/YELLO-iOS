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
    
    // MARK: - Variables
    // MARK: Property
    
    var fetchingMore = false
    var kakaoFriendTableViewModel: [FriendModel] = []
    var initialKakaoDataCount = 10
    
    var kakaoFriendTableViewDummy: [FriendModel] = [
        FriendModel(name: "정채은", school: "이화여자대학교 융합콘텐츠학과 21학번", isButtonSelected: false),
        FriendModel(name: "김채은", school: "이화여자대학교 융합콘텐츠학과 22학번", isButtonSelected: false),
        FriendModel(name: "이채은", school: "이화여자대학교 융합콘텐츠학과 23학번", isButtonSelected: false),
        FriendModel(name: "황채은", school: "이화여자대학교 융합콘텐츠학과 24학번", isButtonSelected: false),
        FriendModel(name: "최채은", school: "이화여자대학교 융합콘텐츠학과 25학번", isButtonSelected: false),
        FriendModel(name: "윤채은", school: "이화여자대학교 융합콘텐츠학과 26학번", isButtonSelected: false),
        FriendModel(name: "성채은", school: "이화여자대학교 융합콘텐츠학과 27학번", isButtonSelected: false),
        FriendModel(name: "박채은", school: "이화여자대학교 융합콘텐츠학과 28학번", isButtonSelected: false),
        FriendModel(name: "성채은", school: "이화여자대학교 융합콘텐츠학과 27학번", isButtonSelected: false),
        FriendModel(name: "박채은", school: "이화여자대학교 융합콘텐츠학과 28학번", isButtonSelected: false),
        FriendModel(name: "방채은", school: "이화여자대학교 융합콘텐츠학과 29학번", isButtonSelected: false),
        FriendModel(name: "홍채은", school: "이화여자대학교 융합콘텐츠학과 30학번", isButtonSelected: false),
        FriendModel(name: "백채은", school: "이화여자대학교 융합콘텐츠학과 20학번", isButtonSelected: false),
        FriendModel(name: "박채은", school: "이화여자대학교 융합콘텐츠학과 28학번", isButtonSelected: false),
        FriendModel(name: "방채은", school: "이화여자대학교 융합콘텐츠학과 29학번", isButtonSelected: false),
        FriendModel(name: "홍채은", school: "이화여자대학교 융합콘텐츠학과 30학번", isButtonSelected: false),
        FriendModel(name: "백채은", school: "이화여자대학교 융합콘텐츠학과 20학번", isButtonSelected: false)]
    
    // MARK: Component
    private let inviteBannerView = InviteBannerView()
    private let emptyFriendView = EmptyFriendView()
    lazy var kakaoFriendTableView = UITableView()
    
    // MARK: - Function
    // MARK: LifeCycle
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

// MARK: - extension
extension KakaoFriendView {
    
    // MARK: Layout Helpers
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
            $0.showsVerticalScrollIndicator = false
        }
        
        emptyFriendView.do {
            $0.isHidden = true
        }
    }
    
    private func setLayout() {
        if kakaoFriendTableViewDummy.count < 10 {
            initialKakaoDataCount = kakaoFriendTableViewDummy.count
        } else {
            initialKakaoDataCount = 10
        }
        
        kakaoFriendTableViewModel = Array(kakaoFriendTableViewDummy[0..<initialKakaoDataCount])
        
        self.addSubviews(
            inviteBannerView,
            kakaoFriendTableView,
            emptyFriendView)
        
        inviteBannerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(76)
        }
        
        kakaoFriendTableView.snp.makeConstraints {
            $0.top.equalTo(inviteBannerView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        
        emptyFriendView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
    private func setDelegate() {
        kakaoFriendTableView.dataSource = self
        kakaoFriendTableView.delegate = self
    }
    
    // MARK: Objc Function
    @objc func addButtonTapped(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: kakaoFriendTableView)
        guard let indexPath = kakaoFriendTableView.indexPathForRow(at: point) else { return }
        kakaoFriendTableViewModel.remove(at: indexPath.row)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.kakaoFriendTableView.deleteRows(at: [indexPath], with: .right)
            self.updateView()
        }
    }
    
    // MARK: Custom Function
    private func updateView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if self.kakaoFriendTableViewModel.isEmpty {
                self.inviteBannerView.isHidden = true
                self.kakaoFriendTableView.isHidden = true
                self.emptyFriendView.isHidden = false
                
            } else {
                self.inviteBannerView.isHidden = false
                self.kakaoFriendTableView.isHidden = false
                self.emptyFriendView.isHidden = true
            }
        }
    }
}

// MARK: UITableViewDelegate
extension KakaoFriendView: UITableViewDelegate { }

// MARK: UITableViewDataSource
extension KakaoFriendView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kakaoFriendTableViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as? FriendTableViewCell else {
            return UITableViewCell()
        }
        
        if tableView.isLast(for: indexPath) {
            DispatchQueue.main.async {
                cell.addAboveTheBottomBorderWithColor(color: .black)
            }
        }
        cell.selectionStyle = .none
        cell.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        cell.configureFriendCell(kakaoFriendTableViewModel[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetch()
            }
        }
    }
    
    func beginBatchFetch() {
        fetchingMore = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [self] in
            if kakaoFriendTableViewDummy.count - initialKakaoDataCount < 10 {
                if kakaoFriendTableViewDummy.count - initialKakaoDataCount == 0 {
                    print("친구 데이터가 더 없어요")
                } else {
                    let newItems = (initialKakaoDataCount...kakaoFriendTableViewDummy.count - 1).map { index in
                        kakaoFriendTableViewDummy[index]
                    }
                    self.kakaoFriendTableViewModel.append(contentsOf: newItems)
                }
            }
            else {
                let newItems = (initialKakaoDataCount...initialKakaoDataCount + 9).map { index in
                    kakaoFriendTableViewDummy[index]
                }
                self.kakaoFriendTableViewModel.append(contentsOf: newItems)
            }
            
            self.fetchingMore = false
            self.kakaoFriendTableView.reloadData()
            initialKakaoDataCount = kakaoFriendTableViewModel.count
        }
    }
}
