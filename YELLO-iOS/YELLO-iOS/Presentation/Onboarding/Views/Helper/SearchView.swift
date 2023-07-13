//
//  SearchView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

import SnapKit
import Then

class SearchView: BaseView {
    // MARK: - Variables
    // MARK: Constants
    let padding = 16
    
    // MARK: Component
    let cancelButton = UIButton()
    let titleLabel = UILabel()
    let searchTextField = YelloTextField(state: .search)
    let helperButton = YelloHelperButton(buttonText: "")
    let searchResultTableView = UITableView()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Function
    // MARK: LifeCycle
    init() {
        super.init(frame: CGRect())
        setUI()
    }
    
    // MARK: Layout Helpers
    override func setStyle() {
        titleLabel.do {
            $0.font = .uiSubtitle02
            $0.textColor = .white
        }
        
        cancelButton.do {
            $0.setImage(ImageLiterals.OnBoarding.icX.withTintColor(.white, renderingMode: .alwaysOriginal),
                        for: .normal)
        }
        
        searchResultTableView.do {
            $0.rowHeight = 64
            $0.separatorStyle = .none
            $0.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
            $0.backgroundColor = .black
            
        }
        
    }
    
    override func setLayout() {
        self.addSubviews(cancelButton, titleLabel, searchTextField, helperButton, searchResultTableView)
        
        cancelButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constraints.bigMargin)
            $0.top.equalToSuperview().offset(24)
        }
        
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
