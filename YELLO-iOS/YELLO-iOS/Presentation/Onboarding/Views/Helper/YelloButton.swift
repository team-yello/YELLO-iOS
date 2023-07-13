//
//  YelloButton.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//

import UIKit
import SnapKit

enum ButtonState {
    case enabled
    case unabled
}

final class YelloButton: UIButton {
    
    let roundAmount: CGFloat = 8
    let buttonHeight: CGFloat = 48
    let textSize: CGFloat = 15
    var buttonState: Bool = false
    var buttonText: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - Function

    // MARK: LifeCycle
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

extension YelloButton {
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.setTitle(buttonText, for: .normal)
        self.makeCornerRound(radius: roundAmount)
        self.titleLabel?.font = .uiButton
        setButtonEnable(state: self.buttonState)
    }
    
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
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(buttonHeight)
        }
    }
}
