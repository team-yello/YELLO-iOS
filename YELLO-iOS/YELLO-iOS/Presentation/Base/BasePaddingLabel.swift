//
//  BasePaddingLabel.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/13.
//

import UIKit

class BasePaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 3, left: 14, bottom: 3, right: 14)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
}
