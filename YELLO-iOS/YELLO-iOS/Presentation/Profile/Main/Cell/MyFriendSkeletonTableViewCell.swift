//
//  MyFriendSkeletonTableViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/09.
//

import UIKit

import Kingfisher
import SnapKit
import Then

final class MyFriendSkeletonTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    // MARK: Component
    static let identifier = "MyFriendSkeletonTableViewCell"
    
    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 42.adjusted, height: 42.adjusted))
    let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 66.adjustedWidth, height: 16.adjustedHeight))
    let schoolLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 221.adjustedWidth, height: 16.adjustedHeight))
    
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
}

// MARK: - extension
extension MyFriendSkeletonTableViewCell {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
        
        separatorInset.left = 14.adjustedWidth
        separatorInset.right = 14.adjustedWidth
        selectionStyle = .default
        
        profileImageView.do {
            $0.backgroundColor = .grayscales800
            $0.makeCornerRound(radius: 21.adjusted)
        }
        
        nameLabel.do {
            $0.backgroundColor = .grayscales800
            $0.makeCornerRound(radius: 2.adjustedHeight)
        }
        
        schoolLabel.do {
            $0.backgroundColor = .grayscales800
            $0.makeCornerRound(radius: 2.adjustedHeight)
        }
    }
    
    private func setLayout() {
        
        contentView.addSubviews(profileImageView,
                               nameLabel,
                               schoolLabel)
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17.adjustedHeight)
            $0.leading.equalToSuperview().offset(8.adjustedWidth)
            $0.width.height.equalTo(42.adjusted)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(19.adjustedHeight)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8.adjustedWidth)
            $0.height.equalTo(16.adjustedHeight)
            $0.width.equalTo(66.adjustedWidth)
        }
        
        schoolLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6.adjustedHeight)
            $0.leading.equalTo(nameLabel)
            $0.height.equalTo(16.adjustedHeight)
            $0.width.equalTo(221.adjustedWidth)
            $0.bottom.equalToSuperview().inset(19.adjustedHeight)
        }
    }
    
    func showShimmer() {
        self.profileImageView.animateShimmer()
        self.nameLabel.animateShimmer()
        self.schoolLabel.animateShimmer()
    }
}
