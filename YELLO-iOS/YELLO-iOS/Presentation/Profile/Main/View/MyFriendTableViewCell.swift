//
//  MyFriendTableViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/11.
//

import UIKit

import Kingfisher
import SnapKit
import Then

final class MyFriendTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    // MARK: Component
    static let identifier = "MyFriendTableViewCell"
    
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let schoolLabel = UILabel()
    
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
extension MyFriendTableViewCell {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
        
        separatorInset.left = 14
        separatorInset.right = 14
        selectionStyle = .default
        
        profileImageView.do {
            $0.image = ImageLiterals.Profile.imgDefaultProfile
            $0.contentMode = .scaleAspectFill
            $0.makeCornerRound(radius: 20)
        }
        
        nameLabel.do {
            $0.font = .boldSystemFont(ofSize: 18)
            $0.setTextWithLineHeight(text: "", lineHeight: 24)
            $0.textColor = .white
        }
        
        schoolLabel.do {
            $0.font = .systemFont(ofSize: 11)
            $0.setTextWithLineHeight(text: "", lineHeight: 15)
            $0.textColor = .gray
        }
    }
    
    private func setLayout() {
        
        contentView.addSubviews(profileImageView,
                               nameLabel,
                               schoolLabel)
        
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
            $0.width.height.equalTo(42)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
        }
        
        schoolLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(nameLabel)
        }
    }
    
    // MARK: Custom Function
    func configureMyProfileFriendCell(_ model: ProfileFriendResponseDetail) {
        nameLabel.text = model.name
        profileImageView.kfSetImage(url: model.profileImageUrl)
        schoolLabel.text = model.group
    }
}
