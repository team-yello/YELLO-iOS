//
//  YelloGenderButton.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/07.
//

import UIKit

import SnapKit
import Then

// MARK: - enum
/// 성별 구분
@frozen enum Gender {
    case female
    case male
}

class YelloGenderButton: UIButton {
    // MARK: - Variables
    // MARK: Property
    var buttonText = ""
    var gender: Gender?
    var genderIconImage: UIImage?
    
    // MARK: Component
    let checkButton = UIButton()
    var iconImageView = UIImageView()
    let genderLabel = UILabel()
    let stackView = UIStackView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Custom Init
    init(buttonText: String) {
        super.init(frame: CGRect())
        self.buttonText = buttonText
        setUI()
    }
}

// MARK: - extension
extension YelloGenderButton {
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.do {
            $0.makeCornerRound(radius: CGFloat(Constraints.round))
            $0.backgroundColor = .grayscales900
            $0.makeBorder(width: 1, color: .grayscales400)
            $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        }
        
        gender = (self.buttonText == "여자") ? Gender.female : Gender.male
        
        switch gender {
        case .female:
            genderIconImage = ImageLiterals.OnBoarding.icYelloFaceFemale
            genderLabel.textColor = .semanticGenderF500
        case .male:
            genderIconImage = ImageLiterals.OnBoarding.icYelloFaceMale
            genderLabel.textColor = .semanticGenderM500
        case .none:
            return
        }
        
        iconImageView.do {
            $0.image = genderIconImage
            
        }
        genderLabel.do {
            $0.text = buttonText
            $0.font = .uiSubtitle02
        }
        stackView.do {
            $0.addArrangedSubviews(iconImageView, genderLabel)
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 4
        }
        checkButton.do {
            $0.setImage(ImageLiterals.OnBoarding.icCheckCircleGender, for: .normal)
 
        }
    }
    
    private func setLayout() {
        self.addSubviews(checkButton, stackView)
        
        self.snp.makeConstraints {
            $0.height.equalTo(146)
        }
        
        checkButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(11)
            $0.leading.equalToSuperview().offset(14)
        }
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    private func setSelected() {
        self.iconImageView.image = genderIconImage?.withTintColor(.white, renderingMode: .alwaysOriginal)
        self.genderLabel.textColor = .white
        self.makeBorder(width: 1, color: .white)
        
        switch gender {
        case .female:
            self.backgroundColor = .semanticGenderF700
            self.checkButton.setImage(ImageLiterals.OnBoarding.icCheckCircleFemale, for: .normal)
        case .male:
            self.backgroundColor = .semanticGenderM700
            self.checkButton.setImage(ImageLiterals.OnBoarding.icCheckCircleMale, for: .normal)
        case .none:
            return
        }
    }
    
    // MARK: Objc Function
    @objc func buttonDidTap() {
        guard !isSelected else { return } // 이미 선택된 버튼이면 무시
        
        // 다른 버튼들을 선택 해제
        superview?.subviews.forEach { subview in
            if let button = subview as? YelloGenderButton, button != self {
                button.isSelected = false
                button.backgroundColor = .grayscales900
                button.makeBorder(width: 0, color: .grayscales700)
                button.iconImageView.image = ImageLiterals.OnBoarding.icYelloFaceMale.withTintColor(.grayscales700, renderingMode: .alwaysOriginal)
                button.genderLabel.textColor = .grayscales700
                button.checkButton.setImage(ImageLiterals.OnBoarding.icCheckCircleGender, for: .normal)
            }
        }
        
        isSelected = true
        setSelected()
    }
    
}
