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
        self.font = .uiLabelLarge
        setLabelStyle(text: "", State: .normal)
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
        }
    }
    
}
