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
    let separatorLine = UIView()
    var isTapped: Bool = false {
        didSet {
            updateAddButtonImage()
        }
    }
    
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
        
        self.addButton.setImage(ImageLiterals.Recommending.icAddFriendButton, for: .normal)
        isTapped = false
        separatorLine.isHidden = false
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
            $0.image = ImageLiterals.Profile.imgDefaultProfile
            $0.contentMode = .scaleAspectFill
            $0.makeCornerRound(radius: 21)
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
        
        separatorLine.do {
            $0.backgroundColor = .grayscales800
        }
    }
    
    private func setLayout() {
        
        contentView.addSubviews(profileImageView,
                                nameLabel,
                                schoolLabel,
                                addButton,
                                separatorLine)
        
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
        
        separatorLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    func configureFriendCell(_ model: FriendModel) {
        nameLabel.text = model.recommendingFriendListData.name
        schoolLabel.text = model.recommendingFriendListData.group
        profileImageView.kfSetImage(url: model.recommendingFriendListData
            .profileImage)
        isTapped = model.isButtonSelected
        
        updateAddButtonImage()
    }
    
    private func updateAddButtonImage() {
        let imageName = isTapped ? ImageLiterals.Recommending.icAddFriendButtonTapped : ImageLiterals.Recommending.icAddFriendButton
        addButton.setImage(imageName, for: .normal)
    }
    
    // MARK: Objc Function
    @objc private func changeAddButton() {
        isTapped.toggle()
        /// 두 번 이상 누를 수 없도록 disabled 처리
        addButton.setImage(ImageLiterals.Recommending.icAddFriendButtonTapped, for: .disabled)
        addButton.isEnabled = false
    }
}
