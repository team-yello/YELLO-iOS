//
//  FriendEmptyTableViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/19.
//

import UIKit

import SnapKit
import Then

final class FriendEmptyTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "FriendEmptyTableViewCell"
    
    // MARK: Component
    let emptyFriendView = EmptyFriendView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
    }
    
    private func setLayout() {
        contentView.addSubview(emptyFriendView)
        emptyFriendView.snp.makeConstraints {
            $0.top.width.bottom.equalToSuperview()
        }
    }
}
