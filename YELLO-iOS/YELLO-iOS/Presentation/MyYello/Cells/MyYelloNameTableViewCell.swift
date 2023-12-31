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
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "MyYelloNameTableViewCell"
    
    // MARK: Component
    let genderImageView = UIImageView()
    let labelView = UIView()
    let initialLabel = UILabel()
    let sendLabel = UILabel()
    let nameLabel = UILabel()
    let keywordHeadLabel = UILabel()
    let keywordLabel = UILabel()
    let keywordFootLabel = UILabel()
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
        
        initialLabel.do {
            $0.text = " "
            $0.font = .uiKeywordBold
            $0.textColor = .semanticGenderF300
        }
        
        sendLabel.do {
            $0.text = StringLiterals.MyYello.List.nameTitle
            $0.font = .uiBodySmall
            $0.textColor = .semanticGenderF300
        }
        
        nameLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 20.adjustedHeight)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales300
        }
        
        keywordHeadLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 20.adjustedHeight)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales300
        }
        
        keywordLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 20.adjustedHeight)
            $0.font = .uiKeywordBold
            $0.textColor = .white
        }
        
        keywordFootLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 20.adjustedHeight)
            $0.font = .uiBodySmall
            $0.textColor = .grayscales300
        }
        
        timeLabel.do {
            $0.text = " "
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
            $0.leading.equalToSuperview().inset(12.adjustedWidth)
        }
        
        initialLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13.adjustedHeight)
            $0.height.equalTo(20.adjustedHeight)
            $0.leading.equalTo(genderImageView.snp.trailing).inset(-12.adjustedWidth)
        }
        
        sendLabel.snp.makeConstraints {
            $0.top.equalTo(initialLabel)
            $0.height.equalTo(20.adjustedHeight)
            $0.leading.equalTo(initialLabel.snp.trailing).inset(-2.adjustedWidth)
        }
        
        labelView.snp.makeConstraints {
            $0.top.equalTo(initialLabel.snp.bottom).offset(2.adjustedHeight)
            $0.height.equalTo(40.adjustedHeight)
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
            $0.leading.equalTo(keywordHeadLabel.snp.trailing).inset(-2.adjustedWidth)
        }
        
        keywordFootLabel.snp.makeConstraints {
            $0.bottom.equalTo(keywordLabel)
            $0.leading.equalTo(keywordLabel.snp.trailing).inset(-2.adjustedWidth)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12.adjustedWidth)
        }
    }
    
    // MARK: Custom Function
    func configureNameCell(_ model: Yello) {
        if model.senderGender == "MALE" {
            contentView.backgroundColor = .semanticGenderM700
            genderImageView.image = ImageLiterals.MyYello.imgGenderMale
            timeLabel.textColor = .semanticGenderM500
            initialLabel.textColor = .semanticGenderM300
            sendLabel.textColor = .semanticGenderM300
        } else {
            contentView.backgroundColor = .semanticGenderF700
            genderImageView.image = ImageLiterals.MyYello.imgGenderFemale
            timeLabel.textColor = .semanticGenderF500
            initialLabel.textColor = .semanticGenderF300
            sendLabel.textColor = .semanticGenderF300
        }
        
        if model.vote.nameHead == nil {
            nameLabel.text = "너" + (model.vote.nameFoot ?? "")
        } else {
            nameLabel.text = (model.vote.nameHead ?? "") + " 너" + (model.vote.nameFoot ?? "")
        }
        
        if model.vote.keywordHead == nil {
            keywordLabel.snp.makeConstraints {
                $0.leading.equalToSuperview()
            }
        } else {
            keywordHeadLabel.text = model.vote.keywordHead
            keywordHeadLabel.snp.remakeConstraints {
                $0.bottom.equalToSuperview()
                $0.leading.equalToSuperview()
            }
            
            keywordLabel.snp.remakeConstraints {
                $0.bottom.equalTo(keywordHeadLabel)
                $0.leading.equalTo(keywordHeadLabel.snp.trailing).inset(-2.adjustedWidth)
            }
        }
        
        keywordLabel.text = model.vote.keyword
        keywordFootLabel.text = model.vote.keywordFoot ?? ""
        timeLabel.text = model.createdAt
        
        if model.nameHint == 0 {
            if let initial = getFirstInitial(model.senderName as NSString, index: 0) {
                initialLabel.text = initial
            }
        } else if model.nameHint == 1 {
            if let initial = getSecondInitial(model.senderName as NSString, index: 1) {
                initialLabel.text = initial
            }
        } else if model.nameHint == -3 || model.nameHint == -2 {
            initialLabel.text = model.senderName
        }
    }
}

// MARK: - extension
extension MyYelloNameTableViewCell {
    
    // MARK: Custom Function
    func getFirstInitial(_ str: NSString, index: Int) -> String? {
        let name = str
        var initialName: String = ""
        
        for i in 0..<1 {
            let oneChar: UniChar = name.character(at: i)
            if oneChar >= 0xAC00 && oneChar <= 0xD7A3 {
                var firstCodeValue = ((oneChar - 0xAC00)/28)/21
                firstCodeValue += 0x1100
                initialName = initialName.appending(String(format: "%C", firstCodeValue))
            } else {
                initialName = initialName.appending(String(format: "%C", oneChar))
            }
        }
        return initialName
    }
    
    func getSecondInitial(_ str: NSString, index: Int) -> String? {
        let name = str
        var initialName: String = ""
        
        for i in 1..<2 {
            let oneChar: UniChar = name.character(at: i)
            if oneChar >= 0xAC00 && oneChar <= 0xD7A3 {
                var firstCodeValue = ((oneChar - 0xAC00)/28)/21
                firstCodeValue += 0x1100
                initialName = initialName.appending(String(format: "%C", firstCodeValue))
            } else {
                initialName = initialName.appending(String(format: "%C", oneChar))
            }
        }
        return initialName
    }
}
