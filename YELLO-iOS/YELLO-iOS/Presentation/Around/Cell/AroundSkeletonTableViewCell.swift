//
//  AroundSkeletonTableViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/08.
//

import UIKit

import SnapKit
import Then

final class AroundSkeletonTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "AroundSkeletonTableViewCell"
    
    // MARK: Component
    let genderImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20.adjusted, height: 20.adjusted))
    let receiverStackView = UIStackView()
    let genderLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 36.adjustedWidth, height: 13.adjustedHeight))
    let polygonImageView = UIImageView()
    let receiverLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 36.adjustedWidth, height: 13.adjustedHeight))
    let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 149.adjustedWidth, height: 16.adjustedHeight))
    let keywordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 231.adjustedWidth, height: 16.adjustedHeight))
    
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
            $0.backgroundColor = .grayscales600
            $0.makeCornerRound(radius: 10.adjusted)
        }
        
        receiverStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 4
        }
        
        genderLabel.do {
            $0.backgroundColor = .grayscales700
            $0.makeCornerRound(radius: 2)
        }
        
        polygonImageView.do {
            $0.image = ImageLiterals.Around.icPolygon
        }
        
        receiverLabel.do {
            $0.backgroundColor = .grayscales700
            $0.makeCornerRound(radius: 2)
        }
        
        nameLabel.do {
            $0.backgroundColor = .grayscales700
            $0.makeCornerRound(radius: 2)
        }
        
        keywordLabel.do {
            $0.backgroundColor = .grayscales700
            $0.makeCornerRound(radius: 2)
        }
    }
    
    private func setLayout() {
        
        // 데이터 어떻게 들어오는지에 따라서 변경 예정
        //        let maxKeywordLength = votingList[VotingViewController.pushCount].keywordList.compactMap { $0.count }.max() ?? 0
        let keywordLength = (keywordLabel.text?.count ?? 0 * 14).adjusted + 28.adjusted
        
        contentView.addSubviews(genderImageView,
                                receiverStackView,
                                nameLabel,
                                keywordLabel)
        
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
        
        genderLabel.snp.makeConstraints {
            $0.width.equalTo(36.adjustedWidth)
            $0.height.equalTo(13.adjustedHeight)
        }
        
        receiverLabel.snp.makeConstraints {
            $0.width.equalTo(36.adjustedWidth)
            $0.height.equalTo(13.adjustedHeight)
        }
        
        receiverStackView.snp.makeConstraints {
            $0.leading.equalTo(genderImageView.snp.trailing).inset(-8.adjustedWidth)
            $0.centerY.equalTo(genderImageView)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(receiverStackView.snp.bottom).offset(14.adjustedHeight)
            $0.leading.equalTo(receiverStackView)
            $0.height.equalTo(16.adjustedHeight)
            $0.width.equalTo(149.adjustedWidth)
        }
        
        keywordLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6.adjustedHeight)
            $0.leading.equalTo(receiverStackView)
            $0.height.equalTo(16.adjustedHeight)
            $0.width.equalTo(231.adjustedWidth)
        }
    }
}

extension AroundSkeletonTableViewCell {
    func showShimmer() {
        self.genderImageView.animateShimmer()
        self.genderLabel.animateShimmer()
        self.receiverLabel.animateShimmer()
        self.nameLabel.animateShimmer()
        self.keywordLabel.animateShimmer()
    }
}
