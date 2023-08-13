//
//  MyYelloSkeletonTableViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/09.
//

import UIKit

import SnapKit
import Then

final class MyYelloSkeletonTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "MyYelloSkeletonTableViewCell"
    
    // MARK: Component
    let genderImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32.adjusted, height: 32.adjusted))
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
        contentView.backgroundColor = .grayscales900
        contentView.makeCornerRound(radius: 8.adjustedHeight)
        
        genderImageView.do {
            $0.backgroundColor = .grayscales600
            $0.makeCornerRound(radius: 16.adjusted)
        }
        
        titleLabel.do {
            $0.backgroundColor = .grayscales700
            $0.makeCornerRound(radius: 2.adjustedHeight)
        }
        
        timeLabel.do {
            $0.backgroundColor = .grayscales800
            $0.makeCornerRound(radius: 2.adjustedHeight)
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(genderImageView,
                         titleLabel,
                         timeLabel)
        
        genderImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12.adjustedWidth)
            $0.width.height.equalTo(32.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(genderImageView.snp.trailing).inset(-12.adjustedWidth)
            $0.height.equalTo(14.adjustedHeight)
            $0.width.equalTo(98.adjustedWidth)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12.adjustedWidth)
            $0.height.equalTo(14.adjustedHeight)
            $0.width.equalTo(40.adjustedWidth)
        }
    }
}

extension MyYelloSkeletonTableViewCell {
    func showShimmer() {
        self.genderImageView.animateShimmer()
        self.titleLabel.animateShimmer()
        self.timeLabel.animateShimmer()
    }
}
