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
/// 버튼 타입 설정 (학력/성별)
@frozen enum ButtonFormat {
    case school
}
/// 성별 구분
@frozen enum Gender {
    case female
    case male
}
/// 성별 구분
@frozen enum SchoolLevel {
    case high
    case univ
}

class YelloSelectButton: UIButton {
    // MARK: - Variables
    // MARK: Property
    var buttonText = ""
    var buttonFormat: ButtonFormat = .school
    var gender: Gender = .female
    var schoolLevel: SchoolLevel = .high
    var IconImage: UIImage?
    let imageLiteral = ImageLiterals.OnBoarding.self
    let stringLiteral = StringLiterals.Onboarding.self
    
    // MARK: Component
    let checkButton = UIButton()
    var iconImageView = UIImageView()
    let buttonLabel = UILabel()
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
    init(buttonFormat: ButtonFormat, buttonText: String) {
        super.init(frame: CGRect())
        self.buttonFormat = buttonFormat
        self.buttonText = buttonText
        setUI()
    }
}

// MARK: - extension
extension YelloSelectButton {
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        setButtonUI()
        self.do {
            $0.makeCornerRound(radius: 8)
            $0.backgroundColor = .black
            $0.makeBorder(width: 1, color: .grayscales700)
            $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        }
        
        iconImageView.do {
            $0.image = IconImage
            
        }
        buttonLabel.do {
            $0.text = buttonText
            $0.font = .uiSubtitle02
        }
        stackView.do {
            $0.addArrangedSubviews(iconImageView, buttonLabel)
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 4
        }
        checkButton.do {
            $0.backgroundColor = .grayscales800
            $0.makeCornerRound(radius: 10)
            $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
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
            $0.size.equalTo(20)
        }
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    private func setSelected() {
        switch buttonFormat {
        case .school:
            schoolLevel = (buttonText == "대학생") ? .univ : .high
            buttonLabel.textColor = .yelloMain500
            self.makeBorder(width: 1, color: .yelloMain500)
            checkButton.setImage(ImageLiterals.OnBoarding.icCheckCircleSelected, for: .normal)
            
            switch schoolLevel {
            case .high:
                iconImageView.image = imageLiteral.icHighSelected
            case .univ:
                iconImageView.image = imageLiteral.icUnivSelected
            }
        }
        
    }
    
    private func setButtonUI() {
        
        switch buttonFormat {
        case .school:
            let schoolLevel = (self.buttonText == "중/고등학생") ? SchoolLevel.high : SchoolLevel.univ
            buttonLabel.textColor = .grayscales500
            switch schoolLevel {
            case .high:
                IconImage = ImageLiterals.OnBoarding.icHighschool
            case .univ:
                IconImage = ImageLiterals.OnBoarding.icUniv
            }
        }
    }
    
    // MARK: Objc Function
    @objc func buttonDidTap() {
        guard !isSelected else { return } // 이미 선택된 버튼이면 무시
        
        // 다른 버튼들을 선택 해제
        superview?.subviews.forEach { subview in
            if let button = subview as? YelloSelectButton, button != self {
                button.isSelected = false
                button.backgroundColor = .grayscales900
                button.makeBorder(width: 1, color: .grayscales700)
                var image = UIImage()
                switch buttonFormat {
                case .school:
                    image = (buttonText == stringLiteral.SchoolSelect.selectHighText) ? imageLiteral.icUniv : imageLiteral.icHighschool
                }
                button.iconImageView.image = image.withTintColor(.grayscales700, renderingMode: .alwaysOriginal)
                button.buttonLabel.textColor = .grayscales700
                button.checkButton.setImage(ImageLiterals.OnBoarding.icCheckCircleGender, for: .normal)
            }
        }
        
        isSelected = true
        setSelected()
    }
    
}
