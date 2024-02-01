//
//  EditSchoolInfoView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 1/30/24.
//

import UIKit

import SnapKit
import Then

class EditSchoolInfoView: UIView {
    // MARK: - Variables
    // MARK: Property
    var groupType: UserGroupType = UserManager.shared.groupType {
        didSet {
            if groupType == .high || groupType == .middle {
                convertButton.setTitle(StringLiterals.Profile.EditProfile.convertUnivButton, for: .normal)
            } else {
                convertButton.setTitle(StringLiterals.Profile.EditProfile.convertHighButton, for: .normal)
                return
            }
        }
    }
    
    lazy var convertButtonText: String  = {
        if groupType == .high || groupType == .middle {
            return StringLiterals.Profile.EditProfile.convertUnivButton
        } else {
            return StringLiterals.Profile.EditProfile.convertHighButton
        }
    }()
    
    // MARK: Component
    let navigationBarView = SettingNavigationBarView()
    let iconImageView = UIImageView()
    let guideLabel = UILabel()
    let modificationDateLabel = UILabel()
    let editTableView = UITableView(frame: .zero, style: .plain)
    let convertButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        navigationBarView.do {
            $0.isHasSaveButton = true
            $0.titleLabel.text = StringLiterals.Profile.EditProfile.profileEditTitle
        }
        
        iconImageView.do {
            $0.image = ImageLiterals.Profile.icAlert
        }
        
        guideLabel.do {
            $0.font = .uiLabelLarge
            $0.textColor = .yelloMain500
            $0.text = StringLiterals.Profile.EditProfile.guideText
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
        
        modificationDateLabel.do {
            $0.font = .uiLabelMedium
            $0.textColor = .grayscales400
            $0.text = StringLiterals.Profile.EditProfile.modifireDateText
        }
        
        editTableView.do {
            $0.register(EditSchoolInfoTableViewCell.self,
                        forCellReuseIdentifier: EditSchoolInfoTableViewCell.reuseId)
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = UITableView.automaticDimension
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
        }
        
        convertButton.do {
            $0.setTitle(convertButtonText, for: .normal)
            $0.setTitleColor(.yelloMain500, for: .normal)
            $0.setImage(ImageLiterals.Profile.icRightSmall, for: .normal)
            $0.titleLabel?.font = .uiLabelLarge
            $0.makeCornerRound(radius: 22.adjusted)
            $0.makeBorder(width: 1, color: .yelloMain500)
        }
    }
    
    private func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        self.addSubviews(navigationBarView,
                         iconImageView,
                         guideLabel,
                         modificationDateLabel,
                         editTableView,
                         convertButton)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(6.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(24.adjusted)
        }
        
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(6.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        modificationDateLabel.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(4.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        editTableView.snp.makeConstraints {
            $0.top.equalTo(modificationDateLabel.snp.bottom).offset(16.adjusted)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        convertButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(44.adjusted)
            $0.width.equalTo(140.adjustedWidth)
        }
    }
}
