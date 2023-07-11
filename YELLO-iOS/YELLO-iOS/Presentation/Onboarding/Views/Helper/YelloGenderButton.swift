//
//  YelloGenderButton.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/07.
//

import UIKit

class YelloGenderButton: UIButton {
    
    var buttonText = ""
    
    var iconImageView = UIImageView()
    let genderLabel = UILabel()
    let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(buttonText: String) {
        super.init(frame: CGRect())
        self.buttonText = buttonText
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
            $0.makeCornerRound(radius: CGFloat(Constraints.round))
            self.backgroundColor = .grayscales50
            $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        }
        
        iconImageView.do {
            $0.backgroundColor = .grayscales300
        }
        genderLabel.do {
            $0.text = buttonText
            $0.font = .uiSubtitle02
            $0.textColor = .black
        }
        stackView.do {
            $0.addArrangedSubviews(iconImageView, genderLabel)
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 4
        }
    }
    
    private func setLayout() {
        self.addSubviews(stackView)
        
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(98)
        }
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
    @objc func buttonDidTap() {
        guard !isSelected else { return } // 이미 선택된 버튼이면 무시
        
        // 다른 버튼들을 선택 해제
        superview?.subviews.forEach { subview in
            if let button = subview as? YelloGenderButton, button != self {
                button.isSelected = false
                button.backgroundColor = .grayscales50
                button.makeBorder(width: 0, color: .white)
            }
        }
        
        isSelected = true
        backgroundColor = .grayscales100
        makeBorder(width: 1, color: .grayscales600)
    }
    
}
