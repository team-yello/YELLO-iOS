//
//  FriendsTableViewCell.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/07.
//

import UIKit

import SnapKit
import Then

// MARK: - Protocol
protocol FriendsTableViewCellDelegate: AnyObject {
    func friendCell(_ cell: FriendsTableViewCell, didTapButtonAt indexPath: IndexPath, isSelected: Bool)
}

class FriendsTableViewCell: UITableViewCell {
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "FriendsTableViewCellDelegate"
    
    // MARK: Property
    weak var delegate: FriendsTableViewCellDelegate?
    var isTapped: Bool = false {
        didSet {
            updateCheckButtonImage()
        }
    }
    
    // MARK: Component
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let schoolLabel = UILabel()
    lazy var checkButton = UIButton()
    lazy var stackView = UIStackView()
    let selectedOverlayView = UIView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 재사용 이슈 해결
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.image = nil
        nameLabel.text = nil
        schoolLabel.text = nil
        isTapped = false
        selectedOverlayView.isHidden = true
    }
    
    // MARK: Custom Function
    /// cell 구성
    func configureFriendCell(_ model: OnboardingFriendList) {
        nameLabel.text = model.name
        schoolLabel.text = model.groupName
        profileImageView.kfSetImage(url: model.profileImage)
       // self.isTapped = model.isButtonSelected
        updateCheckButtonImage()
    }
    
    /// 버튼 이미지 업데이트
    private func updateCheckButtonImage() {
        let imageName = isTapped ? ImageLiterals.OnBoarding.icCheckCircleEnable : ImageLiterals.OnBoarding.icCheckCircleYello
        checkButton.setImage(imageName, for: .normal)
    }
    
    /// indexPath 받기
    private func getIndexPath() -> IndexPath? {
        guard let tableView = superview as? UITableView else { return nil }
        return tableView.indexPath(for: self)
    }
    
    // MARK: Objc Function
    @objc func checkButtonDidTap() {
        isTapped.toggle()
        updateCheckButtonImage()
        
        if isTapped {
            if selectedOverlayView.superview == nil {
                selectedOverlayView.backgroundColor = .black.withAlphaComponent(0.5)
                contentView.addSubview(selectedOverlayView)
                contentView.bringSubviewToFront(selectedOverlayView)
                selectedOverlayView.snp.makeConstraints {
                    $0.top.leading.bottom.equalToSuperview()
                    $0.trailing.equalToSuperview().inset(50)
                }
            }
        } else {
            selectedOverlayView.removeFromSuperview()
        }
        if let indexPath = getIndexPath() {
            delegate?.friendCell(self, didTapButtonAt: indexPath, isSelected: isTapped)
        }
    }
}

extension FriendsTableViewCell {
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .black
        
        profileImageView.do {
            $0.backgroundColor = .yelloMain300
            $0.makeCornerRound(radius: 21)
        }
        
        nameLabel.do {
            $0.font = .uiBodyMedium
            $0.textColor = .white
        }
        
        schoolLabel.do {
            $0.font = .uiLabelMedium
            $0.textColor = .grayscales400
        }
        
        checkButton.do {
            $0.addTarget(self, action: #selector(checkButtonDidTap), for: .touchUpInside)
        }
        
        stackView.do {
            $0.addArrangedSubviews(nameLabel, schoolLabel)
            $0.axis = .vertical
            $0.spacing = 2
        }
        
        selectedOverlayView.do {
            $0.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        }
        
    }
    
    private func setLayout() {
        contentView.addSubviews(profileImageView, stackView, checkButton)
        
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(42)
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
        
    }
}
