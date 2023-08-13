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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        genderImageView.image = nil
        titleLabel.text = nil
        timeLabel.text = nil
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
            $0.axis = .vertical
            $0.spacing = 2.adjustedHeight
        }
        
        nameLabel.do {
            $0.setTextWithLineHeight(text: "김옐로", lineHeight: 20.adjustedHeight)
            $0.font = .uiKeywordBold
            $0.textColor = .semanticGenderF300
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.List.nameTitle, lineHeight: 20.adjustedHeight)
            $0.font = .uiBodySmall
            $0.textColor = .semanticGenderF300
        }
        
        timeLabel.do {
            $0.setTextWithLineHeight(text: "1시간 전", lineHeight: 16.adjustedHeight)
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
    func configureDefaultCell(_ model: Yello) {
        
        if model.senderGender == "MALE" {
            contentView.backgroundColor = .semanticGenderM700
            genderImageView.image = ImageLiterals.MyYello.imgGenderMale
            titleLabel.text = StringLiterals.MyYello.List.maleTitle
            nameLabel.textColor = .semanticGenderM300
            titleLabel.textColor = .semanticGenderM300
            timeLabel.textColor = .semanticGenderM300
        } else {
            contentView.backgroundColor = .semanticGenderF700
            genderImageView.image = ImageLiterals.MyYello.imgGenderFemale
            titleLabel.text = StringLiterals.MyYello.List.femaleTitle
            nameLabel.textColor = .semanticGenderF300
            titleLabel.textColor = .semanticGenderF300
            timeLabel.textColor = .semanticGenderF300
        }
        
        timeLabel.text = model.createdAt
    }
}
