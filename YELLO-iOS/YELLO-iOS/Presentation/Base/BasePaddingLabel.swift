//
//  BasePaddingLabel.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/13.
//

import UIKit

class BasePaddingLabel: UILabel {
    
    var topInset: CGFloat = 3
    var bottomInset: CGFloat = 3
    var leftInset: CGFloat = 14
    var rightInset: CGFloat = 14
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}
