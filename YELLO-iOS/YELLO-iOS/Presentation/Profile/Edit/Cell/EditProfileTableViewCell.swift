//
//  EditProfileTableViewCell.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 1/25/24.
//

import UIKit

import SnapKit
import Then

class EditProfileTableViewCell: UITableViewCell {
    // MARK: - Variables
    // MARK: Constants
    static let reusableId = "EditProfileTableViewCell"

    // MARK: Property
    
    // MARK: Component
    let titleLabel = UILabel()
    let infoLabel = UILabel()
    let editButton = UIButton()
    let separatorView = UIView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        
        self.backgroundColor = .clear
        
        titleLabel.do {
            $0.font = .uiBodySmall
        }
        
        infoLabel.do {
            $0.font = .uiSubtitle01
        }
        
        editButton.do {
            $0.setImage(ImageLiterals.Profile.icEdit, for: .normal)
        }
        
        separatorView.do {
            $0.backgroundColor = .grayscales700
        }
    }
    
    private func setLayout() {
        self.addSubviews(titleLabel, infoLabel, editButton, separatorView)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12.adjustedHeight)
            $0.leading.equalToSuperview().offset(16.adjustedWidth)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3.adjustedHeight)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21.adjustedHeight)
            $0.trailing.equalToSuperview().inset(9.adjustedWidth)
        }
        
        separatorView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(infoLabel.snp.bottom).offset(7.adjustedHeight)
            $0.bottom.equalToSuperview().inset(12.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
        }
    }
    
    // MARK: Custom Function
    func configureCell(isEditable: Bool, title: String, info: String) {
        titleLabel.text = title
        infoLabel.text = info
        editButton.isHidden = !isEditable
        if isEditable {
            titleLabel.textColor = .grayscales500
            infoLabel.textColor = .white
        } else {
            titleLabel.textColor = .grayscales700
            infoLabel.textColor = .grayscales600
        }
    }
}
