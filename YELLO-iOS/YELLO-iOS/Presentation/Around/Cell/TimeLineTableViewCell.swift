//
//  TimeLineTableViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 11/5/23.
//

import UIKit

import SnapKit
import Then

final class TimeLineTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "TimeLineTableViewCell"
    
    // MARK: Component
    let receiverProfileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28.adjusted, height: 28.adjusted))
    let receiverLabel = UILabel()
    
    let timeLabel = UILabel()
    let dotView = UIView(frame: CGRect(x: 0, y: 0, width: 3.adjusted, height: 3.adjusted))
    let genderLabel = UILabel()
    let rightStackView = UIStackView()
    
    let nameLabel = UILabel()
    let keywordHeadLabel = UILabel()
    let keywordLabel = UILabel()
    let keywordView = UIView(frame: CGRect(x: 0, y: 0, width: 76.adjustedWidth, height: 20.adjustedHeight))
    let keywordFootLabel = UILabel()
    
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
        receiverProfileImageView.image = nil
        genderLabel.text = nil
        receiverLabel.text = nil
        nameLabel.text = nil
        keywordHeadLabel.text = nil
        keywordLabel.text = nil
        keywordFootLabel.text = nil
        timeLabel.text = nil
    }
        
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .grayscales900
        contentView.makeCornerRound(radius: 8.adjustedHeight)
        
        receiverProfileImageView.do {
            $0.image = ImageLiterals.Profile.imgDefaultProfile
            $0.makeCornerRound(radius: 14.adjusted)
        }
        
        receiverLabel.do {
            $0.text = " "
            $0.font = .uiBody04
            $0.textColor = .grayscales500
        }
        
        rightStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 5.adjustedHeight
        }
        
        timeLabel.do {
            $0.text = " "
            $0.font = .uiLabelLarge
            $0.textColor = .grayscales500
        }
        
        dotView.do {
            $0.backgroundColor = .grayscales600
            $0.makeCornerRound(radius: 1.5.adjusted)
        }
        
        genderLabel.do {
            $0.text = StringLiterals.Around.receiveFemale
            $0.font = .uiLabelLarge
            $0.textColor = .semanticGenderF500
        }
        
        nameLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 24.adjustedHeight)
            $0.font = .uiBodyLarge
            $0.textColor = .white
        }
        
        keywordHeadLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 24.adjustedHeight)
            $0.font = .uiBodyLarge
            $0.textColor = .white
        }
        
        keywordView.do {
            $0.backgroundColor = .grayscales800
            $0.makeCornerRound(radius: 4.adjustedHeight)
            $0.addDottedBorder()
        }
        
        keywordLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 24.adjustedHeight)
            $0.font = .uiBodyLarge
            $0.textColor = .semanticGenderF300
            $0.isHidden = true
        }
        
        keywordFootLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 24.adjustedHeight)
            $0.font = .uiBodyLarge
            $0.textColor = .white
        }
    }
    
    private func setLayout() {
        
        contentView.addSubviews(receiverProfileImageView,
                                receiverLabel,
                                rightStackView,
                                nameLabel,
                                keywordHeadLabel,
                                keywordView,
                                keywordLabel,
                                keywordFootLabel)
        
        rightStackView.addArrangedSubviews(timeLabel, 
                                           dotView,
                                           genderLabel)
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(343.adjustedWidth)
            $0.height.equalTo(108.adjustedHeight)
        }
        
        receiverProfileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12.adjustedHeight)
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
            $0.width.height.equalTo(28.adjusted)
        }
        
        receiverLabel.snp.makeConstraints {
            $0.centerY.equalTo(receiverProfileImageView)
            $0.leading.equalTo(receiverProfileImageView.snp.trailing).offset(8.adjustedWidth)
        }
        
        rightStackView.snp.makeConstraints {
            $0.centerY.equalTo(receiverProfileImageView)
            $0.trailing.equalToSuperview().inset(16.adjustedWidth)
        }
        
        dotView.snp.makeConstraints {
            $0.width.height.equalTo(3.adjusted)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(rightStackView.snp.bottom).offset(10.adjustedHeight)
            $0.leading.equalToSuperview().inset(52.adjustedWidth)
        }
        
        keywordHeadLabel.snp.makeConstraints {
            $0.top.equalTo(keywordLabel)
            $0.leading.equalTo(nameLabel)
        }
        
        keywordView.snp.makeConstraints {
            $0.leading.equalTo(keywordHeadLabel.snp.trailing).inset(-6.adjustedWidth)
            $0.height.equalTo(20.adjustedHeight)
            $0.width.equalTo(76.adjustedWidth)
            $0.top.equalTo(keywordLabel).offset(4.adjustedHeight)
        }
        
        keywordLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(-1.adjustedHeight)
            $0.leading.equalTo(keywordView)
        }
        
        keywordFootLabel.snp.makeConstraints {
            $0.top.equalTo(keywordLabel)
            $0.leading.equalTo(keywordLabel.snp.trailing).inset(-6.adjustedWidth)
        }
    }
    
    // MARK: Custom Function
    func configureAroundCell(_ model: FriendVote) {
        if model.senderGender == "MALE" {
            self.genderLabel.text = StringLiterals.Around.receiveMale
            self.genderLabel.textColor = .semanticGenderM500
            self.keywordLabel.textColor = .semanticGenderM300
        } else {
            self.genderLabel.text = StringLiterals.Around.receiveFemale
            self.genderLabel.textColor = .semanticGenderF500
            self.keywordLabel.textColor = .semanticGenderF300
        }
        
        if model.isUserSenderVote {
            self.genderLabel.text = StringLiterals.Around.fromMe
        }
        
        if model.receiverProfileImage != StringLiterals.Recommending.Title.defaultProfileImageLink {
            self.receiverProfileImageView.kfSetImage(url: model.receiverProfileImage)
        } else {
            self.receiverProfileImageView.image = ImageLiterals.Profile.imgDefaultProfile
        }
        
        self.receiverLabel.text = model.receiverName
        
        if model.vote.nameHead == nil {
            self.nameLabel.text = "너" + (model.vote.nameFoot ?? "")
        } else {
            self.nameLabel.text = (model.vote.nameHead ?? "") + " 너" + (model.vote.nameFoot ?? "")
        }
        
        if model.vote.keywordHead == nil {
            if model.isHintUsed == true {
                self.keywordLabel.snp.remakeConstraints {
                    $0.top.equalTo(nameLabel.snp.bottom).offset(-1.adjustedHeight)
                    $0.leading.equalTo(nameLabel)
                }
                
                keywordFootLabel.snp.remakeConstraints {
                    $0.top.equalTo(keywordLabel)
                    $0.leading.equalTo(keywordLabel.snp.trailing).inset(-6.adjustedWidth)
                }
            } else {
                self.keywordView.snp.remakeConstraints {
                    $0.leading.equalTo(nameLabel)
                    $0.height.equalTo(20.adjustedHeight)
                    $0.width.equalTo(76.adjustedWidth)
                    $0.top.equalTo(nameLabel.snp.bottom).offset(3.adjustedHeight)
                }
                
                keywordFootLabel.snp.remakeConstraints {
                    $0.top.equalTo(keywordLabel)
                    $0.leading.equalTo(keywordView.snp.trailing).inset(-6.adjustedWidth)
                }
            }
        } else {
            if model.isHintUsed == true {
                keywordLabel.snp.remakeConstraints {
                    $0.top.equalTo(nameLabel.snp.bottom).offset(-1.adjustedHeight)
                    $0.leading.equalTo(keywordHeadLabel.snp.trailing).offset(6.adjustedWidth)
                }
                
                keywordFootLabel.snp.remakeConstraints {
                    $0.top.equalTo(keywordLabel)
                    $0.leading.equalTo(keywordLabel.snp.trailing).inset(-6.adjustedWidth)
                }
            } else {
                keywordView.snp.remakeConstraints {
                    $0.leading.equalTo(keywordHeadLabel.snp.trailing).inset(-6.adjustedWidth)
                    $0.height.equalTo(20.adjustedHeight)
                    $0.width.equalTo(76.adjustedWidth)
                    $0.top.equalTo(nameLabel.snp.bottom).offset(3.adjustedHeight)
                }
                
                keywordFootLabel.snp.remakeConstraints {
                    $0.top.equalTo(keywordLabel)
                    $0.leading.equalTo(keywordView.snp.trailing).inset(-6.adjustedWidth)
                }
            }
        }
        
        self.keywordHeadLabel.text = model.vote.keywordHead
        self.keywordLabel.text = model.vote.keyword
        self.keywordFootLabel.text = model.vote.keywordFoot ?? ""
        self.timeLabel.text = model.createdAt
        
        if model.isHintUsed {
            self.keywordLabel.isHidden = false
            self.keywordView.isHidden = true
        } else {
            self.keywordLabel.isHidden = true
            self.keywordView.isHidden = false
        }
    }
}
