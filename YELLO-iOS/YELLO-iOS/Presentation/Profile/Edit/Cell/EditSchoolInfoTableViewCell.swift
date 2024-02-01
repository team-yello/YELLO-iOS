//
//  EditSchoolInfoTableViewCell.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 1/30/24.
//

import UIKit

import SnapKit
import Then

@frozen
enum IconType {
    case search
    case toggle
}

class EditSchoolInfoTableViewCell: UITableViewCell {
    // MARK: - Variables
    // MARK: Constants
    static let reuseId = "EditSchoolInfoTableViewCell"
    // MARK: Property
    var iconType: IconType = .search
    
    // MARK: Component
    let editBackgroundView = UIView()
    let titleLabel = UILabel()
    let infoLabel = UILabel()
    let iconImageView = UIImageView()
    let separatorView = UIView()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.do {
            $0.backgroundColor = .clear
        }
        
        editBackgroundView.do {
            $0.backgroundColor = .grayscales900
            $0.makeCornerRound(radius: 10)
        }
        
        titleLabel.do {
            $0.font = .uiBodySmall
            $0.textColor = .grayscales500
        }
        
        infoLabel.do {
            $0.font = .uiSubtitle01
            $0.textColor = .white
        }
        
        separatorView.do {
            $0.backgroundColor = .grayscales700
        }
        
        switch iconType {
        case .search:
            iconImageView.image = ImageLiterals.OnBoarding.icSearch.withTintColor(.yelloMain500)
        case .toggle:
            iconImageView.image = ImageLiterals.OnBoarding.icChevronDown.withTintColor(.yelloMain500)
        }
    }
    
    private func setLayout() {
        contentView.addSubview(editBackgroundView)
        
        editBackgroundView.addSubviews(titleLabel,
                                infoLabel,
                                iconImageView,
                                separatorView)
        
        editBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.bottom.equalToSuperview().inset(10.adjustedHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12.adjustedHeight)
            $0.leading.equalToSuperview().offset(16.adjustedWidth)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.top)
            $0.trailing.equalToSuperview().inset(16.adjustedWidth)
        }
        
        separatorView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(1)
        }
    }
    
    func configureCell(iconType: IconType, titleText: String, InfoText: String) {
        self.iconType = iconType
        titleLabel.text = titleText
        infoLabel.text = InfoText
        
        setUI()
    }
}
