//
//  FriendsTableViewCell.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/07.
//

import UIKit

struct FriendModel {
    let name: String
    let school: String
    var isButtonSelected: Bool
}

protocol FriendsTableViewCellDelegate: AnyObject {
    func friendCell(_ cell: FriendsTableViewCell, didTapButtonAt indexPath: IndexPath, isSelected: Bool)
}

class FriendsTableViewCell: UITableViewCell {
    
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let schoolLabel = UILabel()
    lazy var checkButton = UIButton()
    lazy var stackView = UIStackView()
    let selectedOverlayView = UIView()
    weak var delegate: FriendsTableViewCellDelegate?
    
    var isTapped: Bool = false {
        didSet {
            updateCheckButtonImage()
        }
    }
    
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
    
    func configureFriendCell(_ model: FriendModel) {
        nameLabel.text = model.name
        schoolLabel.text = model.school
        self.isTapped = model.isButtonSelected
        updateCheckButtonImage()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.image = nil
        nameLabel.text = nil
        schoolLabel.text = nil
        isTapped = false
        selectedOverlayView.isHidden = true
    }
    
    private func updateCheckButtonImage() {
        let imageName = isTapped ? ImageLiterals.OnBoarding.icCheckCircleEnable : ImageLiterals.OnBoarding.icCheckCircleYello
        checkButton.setImage(imageName, for: .normal)
    }
    
    @objc func checkButtonDidTap() {
        isTapped.toggle()
        
        updateCheckButtonImage()
        
        if isTapped {
            if selectedOverlayView.superview == nil {
                // 흰색 뷰 생성
                selectedOverlayView.backgroundColor = .black.withAlphaComponent(0.5)
                contentView.addSubview(selectedOverlayView)
                contentView.bringSubviewToFront(selectedOverlayView)
                selectedOverlayView.snp.makeConstraints {
                    $0.top.leading.bottom.equalToSuperview()
                    $0.trailing.equalToSuperview().inset(50)
                }
                
            }
        } else {
            // 선택 해제 시 흰색 뷰 제거
            selectedOverlayView.removeFromSuperview()
        }
        
        // FriendModel의 isButtonSelected 값을 변경
        if let indexPath = getIndexPath() {
            delegate?.friendCell(self, didTapButtonAt: indexPath, isSelected: isTapped)
        }
    }
    
    private func getIndexPath() -> IndexPath? {
        guard let tableView = superview as? UITableView else { return nil }
        return tableView.indexPath(for: self)
    }
    
}

extension FriendsTableViewCell {
    
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
