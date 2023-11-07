//
//  InstagramButton.swift
//  YELLO-iOS
//
//  Created by 정채은 on 11/5/23.
//

import UIKit

final class InstagramButton: UIButton {

    // MARK: - Functions
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let expandedBounds = bounds.insetBy(dx: -89.adjustedWidth, dy: -84.adjustedHeight)
        return expandedBounds.contains(point)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
