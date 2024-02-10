//
//  BaseIconButton.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2/10/24.
//

import UIKit

class BaseIconButton: UIButton {

    // MARK: - Functions
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let expandedBounds = bounds.insetBy(dx: -23.adjustedWidth, dy: -20.adjustedHeight)
        return expandedBounds.contains(point)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
