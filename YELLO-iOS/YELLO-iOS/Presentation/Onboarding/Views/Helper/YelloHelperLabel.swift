//
//  YelloHelperLabel.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/14.
//

import UIKit

final class YelloHelperLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.numberOfLines = 2
        self.font = .uiLabelLarge
        setLabelStyle(text: "", State: .normal)
        self.asCustomFont(targetString: "인스타그램 아이디", color: .yelloMain500, font: .uiBody05)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    func setLabelStyle(text: String, State: iconState) {
        self.text = text
        if State == .error {
            self.textColor = .semanticStatusRed500
        } else {
            self.textColor = .grayscales500
            self.asCustomFont(targetString: "인스타그램 아이디", color: .yelloMain500, font: .uiBody05)
        }
    }
    
}
