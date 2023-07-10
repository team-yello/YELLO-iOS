//
//  YelloTextField.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//


import UIKit

import SnapKit
import Then

@frozen
enum iconState {
    case normal
    case search
    case cancel
    case toggle
    case error
}

final class YelloTextField: UITextField {
    // MARK: - Variables
    
    // MARK: Constants
    let padding: CGFloat = 20
    var textFieldState = iconState.normal
    
    //MARK: Components
    private lazy var cancelButton = UIButton()
    private lazy var toggleImageView = UIImageView()
    private lazy var searchImageView = UIImageView()
    private let errorImageView = UIImageView()
    
    private var buttonStackView = UIStackView()
    
    private lazy var paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
    
    // MARK: - Function
    
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - extension
extension YelloTextField {
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.addLeftPadding(20)
        self.rightViewMode = .always
        
        self.do {
            $0.makeBorder(width: 1, color: .grayscales400)
            $0.makeCornerRound(radius: 8)
        }
        
        searchImageView.do  {
            $0.image = ImageLiterals.OnBoarding.icSearch
        }
        
        cancelButton.do {
            $0.setImage(ImageLiterals.OnBoarding.icXCircle, for: .normal)
        }
        
        toggleImageView.do {
            $0.image = ImageLiterals.OnBoarding.icChevronDown
        }
        
        errorImageView.do {
            $0.image = ImageLiterals.OnBoarding.icXCircle
                .withTintColor(.semanticStatusRed500, renderingMode: .alwaysOriginal)
        }
        
    }
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(52)
        }
        
        paddingView.snp.makeConstraints {
            $0.width.equalTo(20)
        }
        
    }
    
    //MARK: Custom Function
    func setButtonState(state: iconState) {
        ///텍스트 필드 타입에 따라 subView 다르게
        switch state {
        case .normal:
            self.rightView = UIView()
        case .search:
            buttonStackView.addArrangedSubviews(searchImageView,paddingView)
        case .cancel:
            buttonStackView.addArrangedSubviews(cancelButton,paddingView)
        case .toggle:
            buttonStackView.addArrangedSubviews(toggleImageView,paddingView)
        case .error:
            buttonStackView.addArrangedSubviews(cancelButton,paddingView)
        }
        self.rightView = buttonStackView
        
    }
}
