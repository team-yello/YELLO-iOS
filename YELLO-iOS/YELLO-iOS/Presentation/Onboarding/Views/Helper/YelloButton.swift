//
//  YelloButton.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//

import UIKit
import SnapKit

enum ButtonState {
    case enable
    case unable
}

final class YelloButton: UIButton {
    
    let roundAmount: CGFloat = 8
    let buttonHeight: CGFloat = 48
    let textSize: CGFloat = 15
    var buttonState = ButtonState.enable
    var buttonText: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(buttonText: String, state: ButtonState){
        super.init(frame: CGRect(x: 0, y: 0, width: buttonHeight, height: 0))
        self.buttonState = state
        self.buttonText = buttonText
        setUI()
    }
    
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.setTitle(buttonText, for: .normal)
        self.makeCornerRound(radius: roundAmount)
        self.titleLabel?.font = .uiBtn01
        
        switch self.isEnabled {
        case true:
            self.backgroundColor = .black
            self.setTitleColor(.yelloMain500, for: .normal)
        case false:
            self.backgroundColor = .grayscales500
            self.titleLabel?.textColor = .grayscales400
        }
    }
    
    private func setLayout() {
        self.snp.makeConstraints{
            $0.height.equalTo(buttonHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

