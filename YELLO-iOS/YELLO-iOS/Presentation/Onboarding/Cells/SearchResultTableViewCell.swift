//
//  SearchResultTableViewCell.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class SearchResultTableViewCell: UITableViewCell {
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "SearchResultTableViewCell"
    
    // MARK: Component
    
    let searchView = UIView()
    let searchImageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    // MARK: - Function
    // MARK: LifeCycle
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension SearchResultTableViewCell {
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
        searchView.do {
            $0.makeCornerRound(radius: 21)
            $0.backgroundColor = .grayscales800
        }
        
        searchImageView.do {
            $0.image = ImageLiterals.OnBoarding.icSearch.withTintColor(.grayscales500, renderingMode: .alwaysOriginal)
        }
        titleLabel.do {
            $0.font = .uiBodyLarge
            $0.textColor = .white
        }
        
    }
    
    private func setLayout() {
        searchView.addSubview(searchImageView)
        self.addSubviews(searchView, titleLabel)
        
        searchImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        searchView.snp.makeConstraints {
            $0.size.equalTo(42)
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(searchView.snp.trailing).offset(8)
        }
        
    }
    
}
