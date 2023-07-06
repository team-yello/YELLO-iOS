//
//  YelloHelperButton.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//
//

import UIKit

final class YelloHelperButton: UIButton {
    
    var buttonText: String?
    
    
    init(buttonText: String){
        super.init(frame: CGRect())
        self.buttonText = buttonText
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.setTitle(buttonText, for: .normal)
        self.setTitleColor(.gray, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 12)
        self.setUnderline()

    }
    
    private func setLayout() {
        
    }
    
}
