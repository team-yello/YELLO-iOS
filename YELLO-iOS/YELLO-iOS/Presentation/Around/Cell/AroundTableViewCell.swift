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
    let keywordView = UIView(frame: CGRect(x: 0, y: 0, width: 91, height: 20))
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

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        genderImageView.image = nil
//        genderLabel.text = nil
//        polygonImageView.image = nil
//        receiverLabel.text = nil
//        nameLabel.text = nil
//        keywordHeadLabel.text = nil
//        keywordLabel.text = nil
//        keywordFootLabel.text = nil
//        timeLabel.text = nil
    }
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .grayscales900
        contentView.makeCornerRound(radius: 8)
        
        genderImageView.do {
            $0.image = ImageLiterals.MyYello.imgGenderFemale
        }
        
        receiverStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 4
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
            $0.text = "김이름"
            $0.font = .uiBody04
            $0.textColor = .grayscales500
        }
        
        nameLabel.do {
            $0.text = "술자리에서 너가"
            $0.font = .uiBodyLarge
            $0.textColor = .white
        }
        
        keywordHeadLabel.do {
            $0.text = "사라진다면"
            $0.font = .uiBodyLarge
            $0.textColor = .white
        }
        
        keywordView.do {
            $0.backgroundColor = .grayscales800
            $0.makeCornerRound(radius: 4)
            $0.addDottedBorder()
        }
        
        keywordLabel.do {
            $0.text = "달빛산책 간 거"
            $0.font = .uiBodyLarge
            $0.textColor = .semanticGenderF300
            $0.isHidden = true
        }
        
        keywordFootLabel.do {
            $0.text = "(이)야"
            $0.font = .uiBodyLarge
            $0.textColor = .white
        }
        
        timeLabel.do {
            $0.text = "1분 전"
            $0.font = .uiLabelSmall
            $0.textColor = .grayscales600
        }
    }
    
    private func setLayout() {
        
        // 데이터 어떻게 들어오는지에 따라서 변경 예정
//        let maxKeywordLength = votingList[VotingViewController.pushCount].keywordList.compactMap { $0.count }.max() ?? 0
        let keywordLength = (keywordLabel.text?.count ?? 0 * 14).adjusted + 28.adjusted
        
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
            $0.height.equalTo(108)
        }
        
        genderImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }
        
        receiverStackView.snp.makeConstraints {
            $0.leading.equalTo(genderImageView.snp.trailing).inset(-8)
            $0.centerY.equalTo(genderImageView)
        }
        
        timeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(19)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(receiverStackView.snp.bottom).offset(10)
            $0.leading.equalTo(receiverStackView)
        }
        
        keywordHeadLabel.snp.makeConstraints {
//            $0.top.equalTo(keywordView)
            $0.leading.equalTo(nameLabel)
            $0.centerY.equalTo(keywordLabel)
        }
        
        keywordView.snp.makeConstraints {
            $0.bottom.equalTo(keywordLabel)
            $0.leading.equalTo(keywordHeadLabel.snp.trailing).inset(-6)
            $0.height.equalTo(20)
            $0.centerX.equalTo(keywordLabel)
            $0.width.equalTo(keywordLabel)
        }
        
        keywordLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(23)
            $0.leading.equalTo(keywordHeadLabel.snp.trailing).inset(-6)
        }
        
        keywordFootLabel.snp.makeConstraints {
            $0.leading.equalTo(keywordLabel.snp.trailing).inset(-6)
            $0.centerY.equalTo(keywordLabel)
        }
    }
    
    // MARK: Custom Function
    func configureAroundCell(_ model: Yello) {
        // 서버 통신 시 함수 구현 예정
    }
}
