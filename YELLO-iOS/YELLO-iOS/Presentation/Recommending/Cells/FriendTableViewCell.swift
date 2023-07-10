//
//  FriendTableViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class FriendTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "FriendTableViewCell"
    
    // MARK: Component
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let schoolLabel = UILabel()
    lazy var addButton = UIButton()
    var isTapped: Bool = false
    
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
extension FriendTableViewCell {
    
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
            $0.image = UIImage(systemName: "circle.fill")
            $0.tintColor = .white
        }
        
        nameLabel.do {
            $0.font = .uiSubtitle01
            $0.setTextWithLineHeight(text: "정채은", lineHeight: 24)
            $0.textColor = .white
        }
        
        schoolLabel.do {
            $0.font = .uiLabelMedium
            $0.setTextWithLineHeight(text: "이화여자대학교 융합콘텐츠학과 20학번", lineHeight: 15)
            $0.textColor = .grayscales600
        }
        
        addButton.do {
            $0.setImage(ImageLiterals.Recommending.icAddFriendButton, for: .normal)
            $0.tintColor = .yellow
            $0.addTarget(self, action: #selector(changeAddButton), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        
        contentView.addSubviews(profileImageView,
                                nameLabel,
                                schoolLabel,
                                addButton)
        
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8.adjusted)
            $0.width.height.equalTo(42.adjusted)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17.adjusted)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12.adjusted)
        }
        
        schoolLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4.adjusted)
            $0.leading.equalTo(nameLabel)
        }
        
        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8.adjusted)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    func configureFriendCell(_ model: FriendModel) {
        nameLabel.text = model.name
        schoolLabel.text = model.school
        isTapped = model.isButtonSelected
        
        let imageName = isTapped ? ImageLiterals.Recommending.icAddFriendButtonTapped : ImageLiterals.Recommending.icAddFriendButton
        addButton.setImage(imageName, for: .normal)
    }
    
    // MARK: Objc Function
    @objc private func changeAddButton() {
        isTapped.toggle()
        addButton.setImage(ImageLiterals.Recommending.icAddFriendButtonTapped, for: .normal)
    }
}
