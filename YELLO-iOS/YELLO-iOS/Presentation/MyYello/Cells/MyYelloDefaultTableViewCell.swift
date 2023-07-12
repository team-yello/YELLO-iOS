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
    
    static let identifier = "MyYelloDefaultTableViewCell"
    
    let genderImageView = UIImageView()
    let titleLabel = UILabel()
    let newView = UIView()
    let timeLabel = UILabel()
    
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

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
    }
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
        contentView.backgroundColor = .grayscales900
        contentView.makeCornerRound(radius: 8)
        
        genderImageView.do {
            $0.image = ImageLiterals.MyYello.imgGenderFemale
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.List.femaleTitle, lineHeight: 20)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales300
        }
        
        newView.do {
            $0.backgroundColor = .semanticStatusYellow500
            $0.makeCornerRound(radius: 2)

        }
        
        timeLabel.do {
            $0.setTextWithLineHeight(text: "1시간 전", lineHeight: 16)
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
            $0.leading.equalToSuperview().inset(12.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(genderImageView.snp.trailing).inset(-12.adjusted)
        }
        
        newView.snp.makeConstraints {
            $0.top.equalTo(titleLabel).offset(1)
            $0.leading.equalTo(titleLabel.snp.trailing).inset(-1)
            $0.width.height.equalTo(4)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12.adjusted)
        }
    }
    
    // MARK: Custom Function
    func configureDefaultCell(_ model: Yello) {
        
        if model.gender == "M" {
            genderImageView.image = ImageLiterals.MyYello.imgGenderMale
        }
        
        if model.isRead == true {
            newView.isHidden = true
        }
        
        timeLabel.text = model.createdAt
    }
}
