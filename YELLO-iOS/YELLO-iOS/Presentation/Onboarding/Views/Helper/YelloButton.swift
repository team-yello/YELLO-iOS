//
//  YelloButton.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//

import UIKit

import SnapKit
import Then

// MARK: - enum
/// 버튼 상태
enum ButtonState {
    case enabled
    case unabled
}

final class YelloButton: UIButton {
    // MARK: - Variables
    // MARK: Constants
    let buttonHeight: CGFloat = 48
    
    // MARK: Property
    var buttonState: Bool = false
    var buttonText: String?
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(buttonText: String, isEnabled: Bool = false) {
        super.init(frame: CGRect(x: 0, y: 0, width: buttonHeight, height: 0))
        self.buttonText = buttonText
        self.buttonState = isEnabled
        setButtonEnable(state: buttonState)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - extension
// MARK: setUI
extension YelloButton {
    func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.setTitle(buttonText, for: .normal)
        self.makeCornerRound(radius: CGFloat(Constraints.buttonRound))
        self.titleLabel?.font = .uiButton
        setButtonEnable(state: self.buttonState)
    }
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(buttonHeight)
        }
    }
    
    // MARK: Custom Method
    func setButtonEnable(state: Bool) {
        self.isEnabled = state
        switch self.isEnabled {
        case true:
            self.backgroundColor = .yelloMain700
            self.setTitleColor(.black, for: .normal)
        case false:
            self.backgroundColor = .grayscales800
            self.setTitleColor(.grayscales700, for: .normal)
        }
    }
}
