//
//  YelloHelperButton.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//
//

import UIKit

import SnapKit
import Then

final class YelloHelperButton: UIButton {
    // MARK: - Variables
    // MARK: Property
    var buttonText: String?
    
    init(buttonText: String) {
        super.init(frame: CGRect())
        self.buttonText = buttonText
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - extension
extension YelloHelperButton {
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.setTitle(buttonText, for: .normal)
        self.setTitleColor(.grayscales500, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 12)
        self.setUnderline()

    }
    
    private func setLayout() {
        
    }
}
