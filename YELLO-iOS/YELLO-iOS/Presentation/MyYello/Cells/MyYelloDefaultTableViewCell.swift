//
//  MyYelloDefaultTableViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyYelloDefaultTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "MyYelloDefaultTableViewCell"
    
    // MARK: Component
    let genderImageView = UIImageView()
    let titleLabel = UILabel()
    let newView = UIView()
    let timeLabel = UILabel()
    var isRead: Bool = false {
        didSet {
            newView.isHidden = isRead
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
        contentView.backgroundColor = .grayscales900
        contentView.makeCornerRound(radius: 8.adjustedHeight)
        
        genderImageView.do {
            $0.image = ImageLiterals.MyYello.imgGenderFemale
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.List.femaleTitle, lineHeight: 20.adjustedHeight)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales300
        }
        
        newView.do {
            $0.backgroundColor = .semanticStatusYellow500
            $0.makeCornerRound(radius: 2.adjustedHeight)

        }
        
        timeLabel.do {
            $0.setTextWithLineHeight(text: "1시간 전", lineHeight: 16.adjustedHeight)
            $0.font = .uiLabelLarge
            $0.textColor = .grayscales600
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(genderImageView,
                         titleLabel,
                         newView,
                         timeLabel)
        
        genderImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12.adjustedWidth)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(genderImageView.snp.trailing).inset(-12.adjustedWidth)
        }
        
        newView.snp.makeConstraints {
            $0.top.equalTo(titleLabel).offset(1.adjustedHeight)
            $0.leading.equalTo(titleLabel.snp.trailing).inset(-1.adjustedWidth)
            $0.width.height.equalTo(4.adjusted)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12.adjustedWidth)
        }
    }
    
    // MARK: Custom Function
    func configureDefaultCell(_ model: Yello) {
        
        if model.senderGender == "MALE" {
            genderImageView.image = ImageLiterals.MyYello.imgGenderMale
            titleLabel.text = StringLiterals.MyYello.List.maleTitle
        } else {
            genderImageView.image = ImageLiterals.MyYello.imgGenderFemale
            titleLabel.text = StringLiterals.MyYello.List.femaleTitle
        }
        
        if model.isRead == true {
            newView.isHidden = true
        } else {
            newView.isHidden = false
        }
        
        timeLabel.text = model.createdAt
    }
}
