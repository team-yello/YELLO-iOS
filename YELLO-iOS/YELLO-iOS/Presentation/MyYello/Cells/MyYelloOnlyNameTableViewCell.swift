//
//  MyYelloOnlyNameTableViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/06.
//

import UIKit

import SnapKit
import Then

final class MyYelloOnlyNameTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "MyYelloOnlyNameTableViewCell"
    
    // MARK: Component
    let genderImageView = UIImageView()
    let nameStackView = UIStackView()
    let nameLabel = UILabel()
    let titleLabel = UILabel()
    let timeLabel = UILabel()
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8.adjustedHeight, right: 0))
    }
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
        contentView.backgroundColor = .semanticGenderF700
        contentView.makeCornerRound(radius: 8.adjustedHeight)
        
        genderImageView.do {
            $0.image = ImageLiterals.MyYello.imgGenderFemale
        }
        
        nameStackView.do {
            $0.addArrangedSubviews(nameLabel, titleLabel)
            $0.axis = .horizontal
            $0.spacing = 2.adjustedWidth
        }
        
        nameLabel.do {
            $0.text = " "
            $0.font = .uiKeywordBold
            $0.textColor = .semanticGenderF300
        }
        
        titleLabel.do {
            $0.text = StringLiterals.MyYello.List.nameTitle
            $0.font = .uiBodySmall
            $0.textColor = .semanticGenderF300
        }
        
        timeLabel.do {
            $0.text = " "
            $0.font = .uiLabelLarge
            $0.textColor = .grayscales600
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(genderImageView,
                                nameStackView,
                         timeLabel)
        
        genderImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12.adjustedWidth)
        }
        
        nameStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(genderImageView.snp.trailing).inset(-12.adjustedWidth)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12.adjustedWidth)
        }
    }
    
    // MARK: Custom Function
    func configureOnlyNameCell(_ model: Yello) {
        
        if model.senderGender == "MALE" {
            contentView.backgroundColor = .semanticGenderM700
            genderImageView.image = ImageLiterals.MyYello.imgGenderMale
            nameLabel.text = model.senderName
            nameLabel.textColor = .semanticGenderM300
            titleLabel.textColor = .semanticGenderM300
            timeLabel.textColor = .semanticGenderM500
        } else {
            contentView.backgroundColor = .semanticGenderF700
            genderImageView.image = ImageLiterals.MyYello.imgGenderFemale
            nameLabel.text = model.senderName
            nameLabel.textColor = .semanticGenderF300
            titleLabel.textColor = .semanticGenderF300
            timeLabel.textColor = .semanticGenderF500
        }
        
        timeLabel.text = model.createdAt
    }
}
