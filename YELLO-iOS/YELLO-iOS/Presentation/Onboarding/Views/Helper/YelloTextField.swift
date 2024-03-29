//
//  YelloTextField.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//

import UIKit

import SnapKit
import Then

// MARK: - enum
/// textField 악세사리 구분
@frozen enum iconState {
    case normal
    case id
    case search
    case toggle
    case editing
    case cancel
    case error
    case done
}

final class YelloTextField: UITextField {
    // MARK: - Variables
    // MARK: Constants
    let padding: CGFloat = 20
    
    // MARK: Property
    var textFieldState = iconState.normal
    var isCanceled = false
    deinit {
        self.removeTarget(self, action: #selector(self.editingChanged(_:)), for: .editingChanged)
    }
    
    private var workItem: DispatchWorkItem?
    private var delay: Double = 0
    private var callback: ((String?) -> Void)? = nil
    
    // MARK: Components
    private lazy var paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
    lazy var cancelButton = UIButton()
    lazy var toggleButton = UIButton()
    lazy var searchButton = UIButton()
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
    
    init(state: iconState, placeholder: String = "") {
        super.init(frame: CGRect())
        setButtonState(state: state)
        self.placeholder = placeholder
        setUI()
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
        
        self.do {
            $0.backgroundColor = .grayscales800
            $0.textColor = .white
            $0.setPlaceholderColor(.grayscales600)
            $0.addLeftPadding(20)
            $0.rightViewMode = .always
            $0.leftViewMode = .always
            $0.autocorrectionType = .no
            $0.spellCheckingType = .no
            $0.makeCornerRound(radius: 8)
        }
        
        searchButton.do {
            let searchImage = ImageLiterals.OnBoarding.icSearch
                .withTintColor(.yelloMain500, renderingMode: .alwaysOriginal)
            $0.setImage(searchImage, for: .normal)
            $0.isUserInteractionEnabled = true
        }
        
        cancelButton.do {
            let cancelImage = ImageLiterals.OnBoarding.icXCircle
                .withTintColor(.yelloMain500, renderingMode: .alwaysOriginal)
            $0.setImage(cancelImage, for: .normal)
            $0.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
        }
        
        toggleButton.do {
            let toggleimage = ImageLiterals.OnBoarding.icChevronDown
                .withTintColor(.yelloMain500, renderingMode: .alwaysOriginal)
            $0.setImage(toggleimage, for: .normal)
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
            $0.height.equalTo(52.adjusted)
        }
        
        [labelPaddingView, paddingView].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(20.adjustedWidth)
            }
        }
        
    }
    
    // MARK: Custom Function
    func setButtonState(state: iconState) {
        /// 텍스트 필드 타입에 따라 subView 다르게
        textFieldState = state
        let xCircleImage = ImageLiterals.OnBoarding.icXCircle
        let cancelImage = xCircleImage.withTintColor(.yelloMain500)
        switch state {
        case .normal:
            self.makeBorder(width: 0, color: .grayscales700)
            self.backgroundColor = .grayscales800
            self.rightViewMode = .never
        case .search:
            buttonStackView.addArrangedSubviews(searchButton, paddingView)
        case .editing:
            self.backgroundColor = .grayscales800
            self.makeBorder(width: 1, color: .grayscales700)
        case .cancel:
            self.backgroundColor = .grayscales800
            self.makeBorder(width: 1, color: .grayscales700)
            cancelButton.setImage(cancelImage, for: .normal)
            buttonStackView.addArrangedSubviews(cancelButton, paddingView)
            self.rightViewMode = .always
        case .toggle:
            buttonStackView.addArrangedSubviews(toggleButton, paddingView)
        case .error:
            buttonStackView.clearSubViews()
            let errorImage = xCircleImage.withTintColor(.semanticStatusRed500)
            cancelButton.setImage(errorImage, for: .normal)
            buttonStackView.addArrangedSubviews(cancelButton, paddingView)
            self.rightViewMode = .always
            self.backgroundColor = .semanticStatusRed500.withAlphaComponent(0.2)
            self.layer.borderColor = UIColor.semanticStatusRed500.cgColor
        case .id:
            self.placeholder = StringLiterals.Onboarding.Id.idPlaceholder
            cancelButton.setImage(cancelImage, for: .normal)
            self.leftView = idLabelStackView
            guard let text = self.text else { break }
            self.rightViewMode = (text.isEmpty) ? .never : .always
            self.attributedPlaceholder = NSAttributedString(
                string: self.placeholder ?? "",
                attributes: [
                    .foregroundColor: UIColor.grayscales600,
                    .font: self.font ?? .uiBodyLarge,
                ]
            )
            let borderWidth: CGFloat = (text.isEmpty) ? 1 : 0
            self.makeBorder(width: borderWidth, color: .grayscales700)
            return
        case .done:
            self.makeBorder(width: 1, color: .grayscales700)
            self.backgroundColor = .grayscales800
        }
        self.rightView = buttonStackView
    }
    
    func debounce(delay: Double, callback: @escaping ((String?) -> Void)) {
        self.delay = delay
        self.callback = callback
        DispatchQueue.main.async {
            self.callback?(self.text)
        }
        self.addTarget(self, action: #selector(self.editingChanged(_:)), for: .editingChanged)
    }
    
    // MARK: Objc Function
    @objc func cancelButtonDidTap() {
        isCanceled.toggle()
        self.setButtonState(state: .normal)
        self.rightViewMode = .never
        self.text = ""
    }
    
    @objc private func editingChanged(_ sender: UITextField) {
        self.workItem?.cancel()
        let workItem = DispatchWorkItem(block: { [weak self] in
            self?.callback?(sender.text)
        })
        self.workItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + self.delay, execute: workItem)
    }
}
