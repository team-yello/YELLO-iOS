//
//  YelloGuideLabel.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/07.
//

import UIKit

final class YelloGuideLabel: UILabel {
    // MARK: - Function
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLabelStyle()
    }
    
    init(labelText: String) {
        super.init(frame: CGRect())
        self.text = labelText
        setLabelStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom Function
    private func setLabelStyle() {
        self.font = .uiHeadline01
        self.setTextWithLineHeight(text: self.text, lineHeight: 30)
        self.textColor = .white
    }
    
}
