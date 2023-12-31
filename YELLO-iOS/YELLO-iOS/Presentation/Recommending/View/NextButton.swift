//
//  NextButton.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/14.
//

import UIKit

class NextButton: UIButton {

    // MARK: - Functions
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let expandedBounds = bounds.insetBy(dx: -295.adjustedWidth, dy: -98.adjustedHeight)
        return expandedBounds.contains(point)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
