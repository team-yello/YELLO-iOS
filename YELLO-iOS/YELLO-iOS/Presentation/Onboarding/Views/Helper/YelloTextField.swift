//
//  YelloTextField.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//


import UIKit

import SnapKit
import Then

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
    private lazy var toggleButton = UIButton()
    private lazy var searchButton = UIButton()
    private var textFieldRightButton = UIButton()
    
    private lazy var paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
    private lazy var buttonStackView = UIView()
    
    // MARK: - Function
    
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout Helpers
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle(){
        self.do {
            $0.makeBorder(width: 1, color: .grayscales400)
            $0.makeCornerRound(radius: 8)
        }
        
        cancelButton.do{
            $0.setImage(ImageLiterals.OnBoarding.icXCircle, for: .normal)
        }
        toggleButton.do{
            $0.setImage(ImageLiterals.OnBoarding.icChevronDown, for: .normal)
        }
        searchButton.do{
            $0.setImage(ImageLiterals.OnBoarding.icSearch, for: .normal)
        }
        
        self.addLeftPadding(padding)
        self.addSubview(buttonStackView)
    }
    
    private func setLayout(){
        self.snp.makeConstraints {
            $0.height.equalTo(52)
        }
        buttonStackView.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.width.equalTo(40)
        }
    }
    
    //MARK: Custom Function
    func setButtonState(state: iconState){
        ///텍스트 필드 타입에 따라 subView 다르게
        switch state {
        case iconState.search:
            textFieldRightButton = searchButton
        case iconState.toggle:
            textFieldRightButton = toggleButton
        case iconState.cancel:
            textFieldRightButton = cancelButton
        default:
            textFieldRightButton = UIButton()
        }
        buttonStackView.addSubviews(textFieldRightButton)
        
    }
}
