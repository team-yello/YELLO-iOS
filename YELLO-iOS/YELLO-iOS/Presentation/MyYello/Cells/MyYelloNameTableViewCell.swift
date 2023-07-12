//
//  MyYelloNameTableViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyYelloNameTableViewCell: UITableViewCell {
    
    static let identifier = "MyYelloNameTableViewCell"

    let genderImageView = UIImageView()
    let labelView = UIView()
    let initialLabel = UILabel()
    let sendLabel = UILabel()
    let nameLabel = UILabel()
    let keywordHeadLabel = UILabel()
    let keywordLabel = UILabel()
    let keywordFootLabel = UILabel()
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
        contentView.backgroundColor = .semanticGenderF700
        contentView.makeCornerRound(radius: 8)
        
        genderImageView.do {
            $0.image = ImageLiterals.MyYello.imgGenderFemale
        }
        
        initialLabel.do {
            $0.setTextWithLineHeight(text: "ㄱ", lineHeight: 20)
            $0.font = .uiKeywordBold
            $0.textColor = .semanticGenderF300
        }
        
        sendLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.List.nameTitle, lineHeight: 20)
            $0.font = .uiBodySmall
            $0.textColor = .semanticGenderF300
        }
        
        nameLabel.do {
            $0.setTextWithLineHeight(text: "술자리에서 너가", lineHeight: 20)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales300
        }
        
        keywordHeadLabel.do {
            $0.setTextWithLineHeight(text: "사라진다면", lineHeight: 20)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales300
        }
        
        keywordLabel.do {
            $0.setTextWithLineHeight(text: "달빛산책간 거", lineHeight: 20)
            $0.font = .uiKeywordBold
            $0.textColor = .white
        }
        
        keywordFootLabel.do {
            $0.setTextWithLineHeight(text: "(이)야", lineHeight: 20)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales300
        }
        
        timeLabel.do {
            $0.setTextWithLineHeight(text: "1시간 전", lineHeight: 16)
            $0.font = .uiLabelLarge
            $0.textColor = .semanticGenderF500
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(genderImageView,
                                initialLabel,
                                sendLabel,
                                labelView,
                                timeLabel)
        
        labelView.addSubviews(nameLabel,
                              keywordHeadLabel,
                              keywordLabel,
                              keywordFootLabel)
        
        genderImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12.adjusted)
        }
        
        initialLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.leading.equalTo(genderImageView.snp.trailing).inset(-12.adjusted)
        }

        sendLabel.snp.makeConstraints {
            $0.top.equalTo(initialLabel)
            $0.leading.equalTo(initialLabel.snp.trailing).inset(-2.adjusted)
        }
        
        
        labelView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-2)
            $0.height.equalTo(40)
            $0.leading.equalTo(initialLabel)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        keywordHeadLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        keywordLabel.snp.makeConstraints {
            $0.bottom.equalTo(keywordHeadLabel)
            $0.leading.equalTo(keywordHeadLabel.snp.trailing).inset(-2.adjusted)
        }
        
        keywordFootLabel.snp.makeConstraints {
            $0.bottom.equalTo(keywordHeadLabel)
            $0.leading.equalTo(keywordLabel.snp.trailing).inset(-2.adjusted)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12.adjusted)
        }
    }
}
