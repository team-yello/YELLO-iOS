//
//  MyYelloListView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyYelloListView: BaseView {

    lazy var myYelloTableView = UITableView()
    
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
        self.addSubviews(myYelloTableView)
        
        myYelloTableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
        }
    }
}

extension MyYelloListView: UITableViewDelegate { }

extension MyYelloListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyYelloModelDummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if MyYelloModelDummy[indexPath.row].isHintUsed == true {
            if MyYelloModelDummy[indexPath.row].nameHint == -1 {
                guard let keywordCell = myYelloTableView.dequeueReusableCell(withIdentifier: MyYelloKeywordTableViewCell.identifier, for: indexPath) as? MyYelloKeywordTableViewCell else { return UITableViewCell() }

                keywordCell.configureKeywordCell(MyYelloModelDummy[indexPath.row])
                keywordCell.selectionStyle = .none
                return keywordCell
            } else {
                guard let nameCell = myYelloTableView.dequeueReusableCell(withIdentifier: MyYelloNameTableViewCell.identifier, for: indexPath) as? MyYelloNameTableViewCell else { return UITableViewCell() }
                
                nameCell.configureNameCell(MyYelloModelDummy[indexPath.row])
                nameCell.selectionStyle = .none
                return nameCell
            }
        } else {
            guard let defaultCell = myYelloTableView.dequeueReusableCell(withIdentifier: MyYelloDefaultTableViewCell.identifier, for: indexPath) as? MyYelloDefaultTableViewCell else { return UITableViewCell() }

            defaultCell.configureDefaultCell(MyYelloModelDummy[indexPath.row])
            defaultCell.selectionStyle = .none
            return defaultCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // cell의 높이 + inset 8 더한 값
        if MyYelloModelDummy[indexPath.row].isHintUsed == true {
            if MyYelloModelDummy[indexPath.row].nameHint == -1 {
                return 74
            } else {
                return 98
            }
        } else {
            return 74
        }
    }
}
