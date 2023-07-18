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

    // MARK: Component
    lazy var myYelloTableView = UITableView()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
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
        if myYelloModelDummy[indexPath.row].isHintUsed == false {
            guard let defaultCell = myYelloTableView.dequeueReusableCell(withIdentifier: MyYelloDefaultTableViewCell.identifier, for: indexPath) as? MyYelloDefaultTableViewCell else { return UITableViewCell() }
            
            defaultCell.configureDefaultCell(myYelloModelDummy[indexPath.row])
            defaultCell.selectionStyle = .none
            return defaultCell
        } else {
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
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // cell의 높이 + inset 8 더한 값
        if myYelloModelDummy[indexPath.row].isHintUsed == false {
                return 74
        } else {
            if myYelloModelDummy[indexPath.row].nameHint == -1 {
                return 74
            } else {
                return 98
            }
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
