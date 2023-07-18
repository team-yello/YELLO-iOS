//
//  MyYelloListView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

// MARK: - Protocol
protocol HandleMyYelloCellDelegate: AnyObject {
    func pushMyYelloDetailViewController(index: Int)
}

final class MyYelloListView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    weak var handleMyYelloCellDelegate: HandleMyYelloCellDelegate?
    var fetchingMore = false
    var myYelloModel: [Yello] = []
    var initialMyYelloDataCount = 10
    var myYelloPage: Int = 0
    var indexNumber: Int = -1

    var myYelloModelDummy: [Yello] = []
//        Yello(id: 1, senderGender: "MALE", senderName: "권세훈", nameHint: -1, vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: false, isRead: true, createdAt: "1시간 전"),
//        Yello(id: 2, senderGender: "FEMALE", senderName: "정채은", nameHint: 0, vote: Vote(nameHead: "나는", nameFoot: "와", keywordHead: "한강에서", keyword: "산책하고", keywordFoot: "싶어"), isHintUsed: true, isRead: true, createdAt: "1시간 전"),
//        Yello(id: 3, senderGender: "FEMALE", senderName: "이지희", nameHint: 1, vote: Vote(nameHead: "", nameFoot: "는 학교에서", keywordHead: "", keyword: "연예인", keywordFoot: "역할을 맡을 것 같아"), isHintUsed: true, isRead: true, createdAt: "1시간 전"),
//        Yello(id: 4, senderGender: "MALE", senderName: "김효원", nameHint: 0, vote: Vote(nameHead: "세상에", nameFoot: "랑 둘이", keywordHead: "남으면", keyword: "모르는 척 하고", keywordFoot: "싶어"), isHintUsed: true, isRead: true, createdAt: "1시간 전"),
//        Yello(id: 5, senderGender: "MALE", senderName: "권세훈", nameHint: 1, vote: Vote(nameHead: "", nameFoot: "의 MBTI는", keywordHead: "", keyword: "CUTE", keywordFoot: "일 것 같아"), isHintUsed: true, isRead: true, createdAt: "1시간 전"),
//        Yello(id: 6, senderGender: "FEMALE", senderName: "강국희", nameHint: -1, vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: false, isRead: false, createdAt: "1시간 전"),
//        Yello(id: 7, senderGender: "MALE", senderName: "권세훈", nameHint: -1, vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: false, isRead: false, createdAt: "1시간 전"),
//        Yello(id: 8, senderGender: "FEMALE", senderName: "권세훈", nameHint: 0, vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: true, isRead: true, createdAt: "1시간 전"),
//        Yello(id: 8, senderGender: "FEMALE", senderName: "권세훈", nameHint: 0, vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: true, isRead: true, createdAt: "1시간 전"),
//        Yello(id: 8, senderGender: "FEMALE", senderName: "권세훈", nameHint: 0, vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: true, isRead: true, createdAt: "1시간 전"),
//        Yello(id: 8, senderGender: "FEMALE", senderName: "권세훈", nameHint: 0, vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: true, isRead: true, createdAt: "1시간 전"),
//        Yello(id: 8, senderGender: "MALE", senderName: "권세훈", nameHint: 0, vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: true, isRead: true, createdAt: "1시간 전"),
//        Yello(id: 8, senderGender: "MALE", senderName: "권세훈", nameHint: 0, vote: Vote(nameHead: "술자리에서", nameFoot: "가", keywordHead: "사라진다면", keyword: "달빛산책간 거", keywordFoot: "(이)야"), isHintUsed: true, isRead: true, createdAt: "1시간 전")
//    ]

    // MARK: Component
    lazy var myYelloTableView = UITableView()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        myYello(page: myYelloPage)
        self.backgroundColor = .black

        myYelloTableView.do {
            $0.register(MyYelloDefaultTableViewCell.self, forCellReuseIdentifier: MyYelloDefaultTableViewCell.identifier)
            $0.register(MyYelloKeywordTableViewCell.self, forCellReuseIdentifier: MyYelloKeywordTableViewCell.identifier)
            $0.register(MyYelloNameTableViewCell.self, forCellReuseIdentifier: MyYelloNameTableViewCell.identifier)
            $0.dataSource = self
            $0.delegate = self
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .black
        }
    }
    
    override func setLayout() {
        if myYelloModelDummy.count < 10 {
            initialMyYelloDataCount = myYelloModelDummy.count
        } else {
            initialMyYelloDataCount = 10
        }
        myYelloModel = Array(myYelloModelDummy[0..<initialMyYelloDataCount])
        
        self.addSubviews(myYelloTableView)
        
        myYelloTableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
        }
    }
    
    // MARK: Custom Function
    private func pushMyYelloDetailViewController(index: Int) {
        handleMyYelloCellDelegate?.pushMyYelloDetailViewController(index: index)
    }
    
    // MARK: - Network
    func myYello(page: Int) {
        let queryDTO = MyYelloRequestQueryDTO(page: page)
        NetworkService.shared.myYelloService.myYello(queryDTO: queryDTO) { response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                
                let myYelloModels = data.votes.map { myYello in
                    
                    return Yello(id: myYello.id, senderGender: myYello.senderGender, senderName: myYello.senderName, nameHint: myYello.nameHint, vote: Vote(nameHead: myYello.vote.nameHead, nameFoot: myYello.vote.nameFoot, keywordHead: myYello.vote.keywordHead, keyword: myYello.vote.keyword, keywordFoot: myYello.vote.keywordFoot), isHintUsed: myYello.isHintUsed, isRead: myYello.isRead, createdAt: myYello.createdAt)
                }
                
                self.myYelloModelDummy.append(contentsOf: myYelloModels)
                MyYelloView().myYelloCount = data.totalCount
//                self.myYelloTableView.reloadData()
                dump(data)
                print("통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
}

// MARK: - extension
// MARK: UITableViewDelegate
extension MyYelloListView: UITableViewDelegate { }

// MARK: UITableViewDataSource
extension MyYelloListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myYelloModelDummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if myYelloModelDummy[indexPath.row].isHintUsed == true {
            if myYelloModelDummy[indexPath.row].nameHint == -1 {
                guard let keywordCell = myYelloTableView.dequeueReusableCell(withIdentifier: MyYelloKeywordTableViewCell.identifier, for: indexPath) as? MyYelloKeywordTableViewCell else { return UITableViewCell() }

                keywordCell.configureKeywordCell(myYelloModelDummy[indexPath.row])
                keywordCell.selectionStyle = .none
                return keywordCell
            } else {
                guard let nameCell = myYelloTableView.dequeueReusableCell(withIdentifier: MyYelloNameTableViewCell.identifier, for: indexPath) as? MyYelloNameTableViewCell else { return UITableViewCell() }
                
                nameCell.configureNameCell(myYelloModelDummy[indexPath.row])
                nameCell.selectionStyle = .none
                return nameCell
            }
        } else {
            guard let defaultCell = myYelloTableView.dequeueReusableCell(withIdentifier: MyYelloDefaultTableViewCell.identifier, for: indexPath) as? MyYelloDefaultTableViewCell else { return UITableViewCell() }

            defaultCell.configureDefaultCell(myYelloModelDummy[indexPath.row])
            defaultCell.selectionStyle = .none
            return defaultCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // cell의 높이 + inset 8 더한 값
        if myYelloModelDummy[indexPath.row].isHintUsed == true {
            if myYelloModelDummy[indexPath.row].nameHint == -1 {
                return 74
            } else {
                return 98
            }
        } else {
            return 74
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 102
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushMyYelloDetailViewController(index: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetch()
                myYelloPage += 1
                myYello(page: myYelloPage)
            }
        }
    }
    
    func beginBatchFetch() {
        fetchingMore = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [self] in
            if myYelloModelDummy.count - initialMyYelloDataCount < 10 {
                if myYelloModelDummy.count - initialMyYelloDataCount == 0 {
                    print("쪽지 데이터가 더 없어요")
                } else {
                    let newItems = (initialMyYelloDataCount...myYelloModelDummy.count - 1).map { index in
                        myYelloModelDummy[index]
                    }
                    self.myYelloModel.append(contentsOf: newItems)
                }
            } else {
                let newItems = (initialMyYelloDataCount...initialMyYelloDataCount + 9).map { index in
                    myYelloModelDummy[index]
                }
                self.myYelloModel.append(contentsOf: newItems)
            }
            
            self.fetchingMore = false
            self.myYelloTableView.reloadData()
            initialMyYelloDataCount = myYelloModel.count
        }
    }
}
