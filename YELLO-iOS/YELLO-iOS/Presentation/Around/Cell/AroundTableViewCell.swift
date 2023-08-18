//
//  AroundTableViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/01.
//

import UIKit

import SnapKit
import Then

final class AroundTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "AroundTableViewCell"
    
    // MARK: Component
    let genderImageView = UIImageView()
    let receiverStackView = UIStackView()
    let genderLabel = UILabel()
    let polygonImageView = UIImageView()
    let receiverLabel = UILabel()
    let nameLabel = UILabel()
    let keywordHeadLabel = UILabel()
    let keywordLabel = UILabel()
    let keywordView = UIView(frame: CGRect(x: 0, y: 0, width: 76.adjustedWidth, height: 20.adjustedHeight))
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        genderImageView.image = nil
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
        
        genderImageView.do {
            $0.image = ImageLiterals.MyYello.imgGenderFemale
        }
        
        receiverStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 4.adjustedHeight
        }
        
        genderLabel.do {
            $0.text = StringLiterals.Around.female
            $0.font = .uiBody02
            $0.textColor = .grayscales500
        }
        
        polygonImageView.do {
            $0.image = ImageLiterals.Around.icPolygon
        }
        
        receiverLabel.do {
            $0.text = " "
            $0.font = .uiBody04
            $0.textColor = .grayscales500
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
        
        timeLabel.do {
            $0.text = " "
            $0.font = .uiLabelSmall
            $0.textColor = .grayscales600
        }
    }
    
    private func setLayout() {
        
        contentView.addSubviews(genderImageView,
                                receiverStackView,
                                nameLabel,
                                keywordHeadLabel,
                                keywordView,
                                keywordLabel,
                                keywordFootLabel,
                                timeLabel)
        
        receiverStackView.addArrangedSubviews(genderLabel, polygonImageView, receiverLabel)
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(343.adjustedWidth)
            $0.height.equalTo(108.adjustedHeight)
        }
        
        genderImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16.adjustedHeight)
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
            $0.width.height.equalTo(20.adjusted)
        }
        
        receiverStackView.snp.makeConstraints {
            $0.leading.equalTo(genderImageView.snp.trailing).inset(-8.adjustedWidth)
            $0.centerY.equalTo(genderImageView)
        }
        
        timeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.top.equalToSuperview().inset(19.adjustedHeight)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(receiverStackView.snp.bottom).offset(10.adjustedHeight)
            $0.leading.equalTo(receiverStackView)
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
            self.genderImageView.image = ImageLiterals.MyYello.imgGenderMale
            self.genderLabel.text = StringLiterals.Around.male
            self.keywordLabel.textColor = .semanticGenderM300
        } else {
            self.genderImageView.image = ImageLiterals.MyYello.imgGenderFemale
            self.genderLabel.text = StringLiterals.Around.female
            self.keywordLabel.textColor = .semanticGenderF300
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
