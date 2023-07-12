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

class FriendsTableViewCell: UITableViewCell {
    
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let schoolLabel = UILabel()
    lazy var checkButton = UIButton()
    lazy var stackView = UIStackView()
    let selectedOverlayView = UIView()
    
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
        selectedOverlayView.isHidden = !isTapped
    }
    
    
    private func updateCheckButtonImage() {
        let imageName = isTapped ? ImageLiterals.OnBoarding.icCheckCircleEnable : ImageLiterals.OnBoarding.icCheckCircle
        checkButton.setImage(imageName, for: .normal)
    }
    
    @objc func checkButtonDidTap() {
        isTapped.toggle()
        
        if isTapped {
            // 흰색 뷰 생성
            selectedOverlayView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            contentView.addSubview(selectedOverlayView)
            contentView.bringSubviewToFront(selectedOverlayView)
            selectedOverlayView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            checkButton.setImage(ImageLiterals.OnBoarding.icCheckCircleEnable, for: .normal)
        } else {
            // 선택 해제 시 흰색 뷰 제거
            selectedOverlayView.removeFromSuperview()
            checkButton.setImage(ImageLiterals.OnBoarding.icCheckCircle, for: .normal)
        }
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
        
        stackView.do {
            $0.addArrangedSubviews(nameLabel, schoolLabel)
            $0.axis = .vertical
            $0.spacing = 2
        }
        
        selectedOverlayView.do {
            $0.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            $0.isHidden = true
        }
        
    }
    
    private func setLayout() {
        self.addSubviews(profileImageView, stackView, checkButton)
        
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
        
        contentView.addSubview(selectedOverlayView)
        selectedOverlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}

// MARK: - extension
/// 버튼이 터치 됐을 때 검사
extension FriendsTableViewCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        checkButtonDidTap()
    }
}
