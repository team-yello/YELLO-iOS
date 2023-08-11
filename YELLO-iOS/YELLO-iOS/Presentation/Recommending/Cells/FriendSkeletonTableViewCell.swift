//
//  FriendSkeletonTableViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/07.
//

import UIKit

import SnapKit
import Then

final class FriendSkeletonTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "FriendSkeletonTableViewCell"
    
    // MARK: Component
    let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 42.adjusted, height: 42.adjusted))
    let nameLabel = UILabel()
    let schoolLabel = UILabel()
    let separatorLine = UIView()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        schoolLabel.text = nil
    }
}

// MARK: - extension
extension FriendSkeletonTableViewCell {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        separatorInset.left = 14
        separatorInset.right = 14
        selectionStyle = .default
        
        profileImageView.do {
            $0.backgroundColor = .grayscales800
            $0.contentMode = .scaleAspectFill
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
        
        separatorLine.do {
            $0.backgroundColor = .grayscales800
        }
    }
    
    private func setLayout() {
        
        contentView.addSubviews(profileImageView,
                                nameLabel,
                                schoolLabel,
                                separatorLine)
        
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8.adjusted)
            $0.width.height.equalTo(42.adjusted)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(11.adjustedHeight)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8.adjusted)
            $0.height.equalTo(16.adjustedHeight)
            $0.width.equalTo(66.adjustedWidth)
        }
        
        schoolLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-11.adjustedHeight)
            $0.leading.equalTo(nameLabel)
            $0.height.equalTo(16.adjustedHeight)
            $0.width.equalTo(221.adjustedWidth)
        }
        
        separatorLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
    }
}

extension FriendSkeletonTableViewCell {
    func showShimmer() {
        self.profileImageView.animateShimmer()
        self.nameLabel.animateShimmer()
        self.schoolLabel.animateShimmer()
    }
}
