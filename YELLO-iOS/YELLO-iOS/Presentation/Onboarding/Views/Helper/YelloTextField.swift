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
    case id
    case search
    case cancel
    case toggle
    case error
    case done
}

final class YelloTextField: UITextField {
    // MARK: - Variables
    
    // MARK: Constants
    let padding: CGFloat = 20
    var textFieldState = iconState.normal
    
    // MARK: Components
    private lazy var paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
    private lazy var cancelButton = UIButton()
    private lazy var toggleImageView = UIImageView()
    private lazy var searchImageView = UIImageView()
    private let errorImageView = UIImageView()
    
    private let labelPaddingView = UIView()
    private let idLabel = UILabel()
    
    private var buttonStackView = UIStackView()
    private var idLabelStackView = UIStackView()
    
    // MARK: - Function
    
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(state: iconState) {
        super.init(frame: CGRect())
        setUI()
        setButtonState(state: state)
        
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
        self.backgroundColor = .black
        self.textColor = .white
        self.addLeftPadding(20)
        self.rightViewMode = .always
        self.leftViewMode = .always
        
        self.do {
            $0.makeBorder(width: 1, color: .grayscales600)
            $0.makeCornerRound(radius: 8)
        }
        
        searchImageView.do {
            $0.image = ImageLiterals.OnBoarding.icSearch
                .withTintColor(.grayscales600, renderingMode: .alwaysOriginal)
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
        
        idLabel.do {
            $0.text = "@"
            $0.font = .uiBodyLarge
            $0.textColor = .white
        }
        
        idLabelStackView.do {
            $0.addArrangedSubviews(labelPaddingView, idLabel)
            $0.distribution = .fillEqually
        }
        
    }
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(52)
        }
        
        [labelPaddingView, paddingView].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(20)
            }
        }
        
        idLabelStackView.snp.makeConstraints {
            $0.width.equalTo(39)
        }
        
    }
    
    // MARK: Custom Function
    func setButtonState(state: iconState) {
        /// 텍스트 필드 타입에 따라 subView 다르게
        switch state {
        case .normal:
            buttonStackView.addArrangedSubview(paddingView)
            self.backgroundColor = .black.withAlphaComponent(0)
            self.layer.borderColor = UIColor.grayscales600.cgColor
            
        case .search:
            buttonStackView.addArrangedSubviews(searchImageView, paddingView)
        case .cancel:
            buttonStackView.addArrangedSubviews(cancelButton, paddingView)
            self.rightViewMode = .whileEditing
            self.backgroundColor = .grayscales900
            self.layer.borderColor = UIColor.grayscales600.cgColor
        case .toggle:
            buttonStackView.addArrangedSubviews(toggleImageView, paddingView)
        case .error:
            buttonStackView.addArrangedSubviews(errorImageView, paddingView)
            self.backgroundColor = .semanticStatusRed500.withAlphaComponent(0.2)
            self.layer.borderColor = UIColor.semanticStatusRed500.cgColor
        case .id:
            self.leftView = idLabelStackView
            self.backgroundColor = .black.withAlphaComponent(0)
            self.layer.borderColor = UIColor.grayscales600.cgColor
            return
        case .done:
            self.backgroundColor = .grayscales900
            self.layer.borderColor = UIColor.grayscales500.cgColor
        }
        self.rightView = buttonStackView
        
    }
}
