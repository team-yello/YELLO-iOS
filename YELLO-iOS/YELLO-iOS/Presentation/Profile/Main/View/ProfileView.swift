//
//  ProfileView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

// MARK: - Protocol
protocol HandleFriendCellDelegate: AnyObject {
    func presentModal(index: Int)
}

final class ProfileView: UIView {
    
    var myProfileFriendModelDummy: [MyProfileFriendModel] =
    [MyProfileFriendModel(id: 1, friendName: "정채은", friendProfileImage: "https://blogpfthumb-phinf.pstatic.net/MjAyMjEwMjBfOCAg/MDAxNjY2MjU5NDAyNDM5.bKNb_vCeAwZz248m7c2iaHFS2-TV9iqN6tkJeO1CoHEg.VKQtm2rfXLiCcE3QLk43kOY6EmPd-FpqJe65yt1QFZYg.PNG.mymo_od/profileImage.png?type=s1", friendGroup: "이화여자대학교 융합콘텐츠학과 20학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
     MyProfileFriendModel(id: 2, friendName: "이지희", friendProfileImage: nil, friendGroup: "숭실대학교 글로벌미디어학과 19학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
     MyProfileFriendModel(id: 3, friendName: "김효원", friendProfileImage: "https://postfiles.pstatic.net/MjAyMzA3MDNfNjYg/MDAxNjg4Mzc4Njc5OTk0.QMGDXIgUlEgoIiS72eYHFVwyG1uxjvz_V_OJiz_Ng0Yg.RY163oyuPRQw1gqvB6Q6I472_QT-EyLlHGh8MtvZsTEg.JPEG.mymo_od/IMG_4750.jpg?type=w966", friendGroup: "이화여자대학교 융합콘텐츠학과 20학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
     MyProfileFriendModel(id: 4, friendName: "변희주", friendProfileImage: "https://blogpfthumb-phinf.pstatic.net/MjAyMjEwMjBfOCAg/MDAxNjY2MjU5NDAyNDM5.bKNb_vCeAwZz248m7c2iaHFS2-TV9iqN6tkJeO1CoHEg.VKQtm2rfXLiCcE3QLk43kOY6EmPd-FpqJe65yt1QFZYg.PNG.mymo_od/profileImage.png?type=s1", friendGroup: "숭실대학교 글로벌미디어학과 19학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
     MyProfileFriendModel(id: 5, friendName: "이의제", friendProfileImage: nil, friendGroup: "이화여자대학교 융합콘텐츠학과 20학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
     MyProfileFriendModel(id: 6, friendName: "김효원", friendProfileImage: "https://blogpfthumb-phinf.pstatic.net/MjAyMjEwMjBfOCAg/MDAxNjY2MjU5NDAyNDM5.bKNb_vCeAwZz248m7c2iaHFS2-TV9iqN6tkJeO1CoHEg.VKQtm2rfXLiCcE3QLk43kOY6EmPd-FpqJe65yt1QFZYg.PNG.mymo_od/profileImage.png?type=s1", friendGroup: "숭실대학교 글로벌미디어학과 19학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
     MyProfileFriendModel(id: 7, friendName: "김상호", friendProfileImage: "https://blogpfthumb-phinf.pstatic.net/MjAyMjEwMjBfOCAg/MDAxNjY2MjU5NDAyNDM5.bKNb_vCeAwZz248m7c2iaHFS2-TV9iqN6tkJeO1CoHEg.VKQtm2rfXLiCcE3QLk43kOY6EmPd-FpqJe65yt1QFZYg.PNG.mymo_od/profileImage.png?type=s1", friendGroup: "이화여자대학교 융합콘텐츠학과 20학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
     MyProfileFriendModel(id: 8, friendName: "전채연", friendProfileImage: nil, friendGroup: "숭실대학교 글로벌미디어학과 19학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
     MyProfileFriendModel(id: 9, friendName: "박민주", friendProfileImage: "https://postfiles.pstatic.net/MjAyMzA3MDNfNjYg/MDAxNjg4Mzc4Njc5OTk0.QMGDXIgUlEgoIiS72eYHFVwyG1uxjvz_V_OJiz_Ng0Yg.RY163oyuPRQw1gqvB6Q6I472_QT-EyLlHGh8MtvZsTEg.JPEG.mymo_od/IMG_4750.jpg?type=w966", friendGroup: "이화여자대학교 융합콘텐츠학과 20학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
     MyProfileFriendModel(id: 10, friendName: "강국희", friendProfileImage: nil, friendGroup: "숭실대학교 글로벌미디어학과 19학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
     MyProfileFriendModel(id: 11, friendName: "김나현", friendProfileImage: "https://postfiles.pstatic.net/MjAyMzA3MDNfNjYg/MDAxNjg4Mzc4Njc5OTk0.QMGDXIgUlEgoIiS72eYHFVwyG1uxjvz_V_OJiz_Ng0Yg.RY163oyuPRQw1gqvB6Q6I472_QT-EyLlHGh8MtvZsTEg.JPEG.mymo_od/IMG_4750.jpg?type=w966", friendGroup: "이화여자대학교 융합콘텐츠학과 20학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99)] {
        didSet {
            DispatchQueue.main.async {
                self.myFriendTableView.reloadData()
            }
        }
    }
    
    // MARK: - Variables
    // MARK: Property
    weak var handleFriendCellDelegate: HandleFriendCellDelegate?
    var indexNumber: Int = -1
    
    // MARK: Component
    let navigationBarView = NavigationBarView()
    let myProfileHeaderView = MyProfileHeaderView()
    lazy var myFriendTableView = UITableView(frame: .zero, style: .grouped)

    lazy var topButton = UIButton()
    private var isButtonHidden: Bool = false
    
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
extension ProfileView {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {        
        self.backgroundColor = .black
        
        myFriendTableView.do {
            $0.rowHeight = 77
            $0.register(MyFriendTableViewCell.self, forCellReuseIdentifier: MyFriendTableViewCell.identifier)
            $0.register(MyProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "MyProfileHeaderView")
            $0.backgroundColor = .black
            $0.separatorColor = .grayscales800
            $0.separatorStyle = .singleLine
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
        }
        
        topButton.do {
            $0.backgroundColor = .white
            $0.makeCornerRound(radius: 24)
            $0.setImage(ImageLiterals.Profile.icArrowUp, for: .normal)
            $0.addTarget(self, action: #selector(topButtonTapped), for: .touchUpInside)
            $0.isHidden = true
            $0.layer.applyShadow(color: .black, alpha: 0.6, x: 0, y: 0, blur: 8)
        }
    }
    
    private func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
                    .compactMap { $0 as? UIWindowScene }
                    .first?
                    .statusBarManager?
                    .statusBarFrame.height ?? 20
        
        self.addSubviews(navigationBarView,
                        myFriendTableView,
                         topButton)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        myFriendTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
            $0.bottom.equalToSuperview()
        }
        
        topButton.snp.makeConstraints {
            $0.width.height.equalTo(48.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.bottom.equalTo(myFriendTableView.snp.bottom).inset(16.adjustedHeight)
        }
    }
    
    private func setDelegate() {
        myFriendTableView.dataSource = self
        myFriendTableView.delegate = self
    }
    
    // MARK: Custom Function
    private func updateButtonVisibility() {
        topButton.isHidden = isButtonHidden
    }
    
    // MARK: Objc Function
    @objc func topButtonTapped() {
        myFriendTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    private func presentModal(index: Int) {
        handleFriendCellDelegate?.presentModal(index: index)
    }
}

// MARK: UITableViewDelegate
extension ProfileView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isButtonHidden = scrollView.contentOffset.y <= 0
        updateButtonVisibility()
    }
}

// MARK: UITableViewDataSource
extension ProfileView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyProfileHeaderView.cellIdentifier) as! MyProfileHeaderView
            view.friendCountView.friendCountLabel.text = String(self.myProfileFriendModelDummy.count) + "명"
            DispatchQueue.main.async {
                view.addBottomBorderWithColor(color: .black)
            }
            return view
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 304.adjusted : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myProfileFriendModelDummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyFriendTableViewCell.identifier, for: indexPath) as? MyFriendTableViewCell else {
            return UITableViewCell()
        }
        
        if tableView.isLast(for: indexPath) {
            DispatchQueue.main.async {
                cell.addAboveTheBottomBorderWithColor(color: .black)
            }
        }
        cell.selectionStyle = .none
        cell.configureMyProfileFriendCell(myProfileFriendModelDummy[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Click Cell Number:" + String(indexPath.row))
        self.presentModal(index: indexPath.row)
    }
}
