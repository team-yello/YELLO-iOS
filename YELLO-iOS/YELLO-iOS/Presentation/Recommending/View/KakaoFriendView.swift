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
    var recommendingKakaoFriendTableViewModel: [FriendModel] = []
    private var initialKakaoDataCount = 10
    
    var recommendingKakaoFriendTableViewDummy: [FriendModel] = [
        FriendModel(name: "정채은", school: "이화여자대학교 융합콘텐츠학과 21학번", isButtonSelected: false),
        FriendModel(name: "김채은", school: "이화여자대학교 융합콘텐츠학과 22학번", isButtonSelected: false),
        FriendModel(name: "이채은", school: "이화여자대학교 융합콘텐츠학과 23학번", isButtonSelected: false),
        FriendModel(name: "황채은", school: "이화여자대학교 융합콘텐츠학과 24학번", isButtonSelected: false),
        FriendModel(name: "최채은", school: "이화여자대학교 융합콘텐츠학과 25학번", isButtonSelected: false),
        FriendModel(name: "윤채은", school: "이화여자대학교 융합콘텐츠학과 26학번", isButtonSelected: false),
        FriendModel(name: "성채은", school: "이화여자대학교 융합콘텐츠학과 27학번", isButtonSelected: false),
        FriendModel(name: "박채은", school: "이화여자대학교 융합콘텐츠학과 28학번", isButtonSelected: false),
        FriendModel(name: "성채은", school: "이화여자대학교 융합콘텐츠학과 29학번", isButtonSelected: false),
        FriendModel(name: "박채은", school: "이화여자대학교 융합콘텐츠학과 30학번", isButtonSelected: false),
        FriendModel(name: "방채은", school: "이화여자대학교 융합콘텐츠학과 31학번", isButtonSelected: false),
        FriendModel(name: "홍채은", school: "이화여자대학교 융합콘텐츠학과 32학번", isButtonSelected: false),
        FriendModel(name: "백채은", school: "이화여자대학교 융합콘텐츠학과 33학번", isButtonSelected: false),
        FriendModel(name: "박채은", school: "이화여자대학교 융합콘텐츠학과 34학번", isButtonSelected: false),
        FriendModel(name: "방채은", school: "이화여자대학교 융합콘텐츠학과 35학번", isButtonSelected: false),
        FriendModel(name: "홍채은", school: "이화여자대학교 융합콘텐츠학과 36학번", isButtonSelected: false),
        FriendModel(name: "백채은", school: "이화여자대학교 융합콘텐츠학과 37학번", isButtonSelected: false)]

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
            $0.showsVerticalScrollIndicator = false
        }
        
        emptyFriendView.do {
            $0.isHidden = true
        }
    }
    
    private func setLayout() {
        if recommendingKakaoFriendTableViewDummy.count < 10 {
            initialKakaoDataCount = recommendingKakaoFriendTableViewDummy.count
        } else {
            initialKakaoDataCount = 10
        }
        
        recommendingKakaoFriendTableViewModel = Array(recommendingKakaoFriendTableViewDummy[0..<initialKakaoDataCount])
        
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
        
        recommendingKakaoFriendTableViewModel[indexPath.row].isButtonSelected = true
        print(recommendingKakaoFriendTableViewModel[indexPath.row])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.recommendingKakaoFriendTableViewModel.remove(at: indexPath.row)
            self.recommendingKakaoFriendTableViewDummy.remove(at: indexPath.row)
            self.kakaoFriendTableView.deleteRows(at: [indexPath], with: .right)
            self.updateView()
        }
        
        kakaoFriendTableView.reloadRows(at: [indexPath], with: .none)
        initialKakaoDataCount -= 1
    }
    
    // MARK: Custom Function
    private func updateView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if self.recommendingKakaoFriendTableViewModel.isEmpty {
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
        return recommendingKakaoFriendTableViewModel.count
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
        
        if cell.isTapped == true {
            recommendingKakaoFriendTableViewModel[indexPath.row].isButtonSelected = true
        }
        cell.addButton.removeTarget(nil, action: nil, for: .allEvents)
        
        cell.addButton.setImage(cell.isTapped ? ImageLiterals.Recommending.icAddFriendButtonTapped : ImageLiterals.Recommending.icAddFriendButton, for: .normal)
        cell.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        cell.configureFriendCell(recommendingKakaoFriendTableViewModel[indexPath.row])
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
            if recommendingKakaoFriendTableViewDummy.count - initialKakaoDataCount < 10 {
                if recommendingKakaoFriendTableViewDummy.count - initialKakaoDataCount == 0 {
                    print("친구 데이터가 더 없어요")
                } else {
                    let newItems = (initialKakaoDataCount...recommendingKakaoFriendTableViewDummy.count - 1).map { index in
                        recommendingKakaoFriendTableViewDummy[index]
                    }
                    self.recommendingKakaoFriendTableViewModel.append(contentsOf: newItems)
                }
            } else {
                let newItems = (initialKakaoDataCount...initialKakaoDataCount + 9).map { index in
                    recommendingKakaoFriendTableViewDummy[index]
                }
                self.recommendingKakaoFriendTableViewModel.append(contentsOf: newItems)
            }
            
            self.fetchingMore = false
            self.kakaoFriendTableView.reloadData()
            initialKakaoDataCount = recommendingKakaoFriendTableViewModel.count
        }
    }
}
