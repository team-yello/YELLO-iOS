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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        myYelloTableView.rowHeight = 66
        guard let defaultCell = myYelloTableView.dequeueReusableCell(withIdentifier: MyYelloDefaultTableViewCell.identifier, for: indexPath) as? MyYelloDefaultTableViewCell else { return UITableViewCell() }
        defaultCell.selectionStyle = .none
        return defaultCell
    }
}
