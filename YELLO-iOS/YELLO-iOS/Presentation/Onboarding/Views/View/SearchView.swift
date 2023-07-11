//
//  SearchView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

class SearchView: BaseView {
    
    let padding = 16
    
    let titleLabel = UILabel()
    let searchTextField = YelloTextField(state: .search)
    let helperButton = YelloHelperButton(buttonText: "")
    let searchResultTableView = UITableView()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    init(titleText: String, helperText: String) {
        super.init(frame: CGRect())
        titleLabel.do {
            $0.text = titleText
            $0.font = .uiSubtitle02
        }
        helperButton.setTitle(helperText, for: .normal)
        setUI()
        
    }
    
    override func setStyle() {
        self.backgroundColor = .white
        searchResultTableView.do {
            $0.register(SchoolResultTableViewCell.self, forCellReuseIdentifier: "SchoolResultTableViewCell")
        }
        
    }
    
    override func setLayout() {
        self.addSubviews(titleLabel, searchTextField, helperButton, searchResultTableView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.centerX.equalToSuperview()
        }
        
        searchTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(padding)
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
        
        helperButton.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        searchResultTableView.snp.makeConstraints {
            $0.top.equalTo(helperButton.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
