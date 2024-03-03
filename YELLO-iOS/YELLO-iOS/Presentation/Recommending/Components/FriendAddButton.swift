//
//  FriendAddButton.swift
//  YELLO-iOS
//
//  Created by 정채은 on 3/3/24.
//

import UIKit

final class FriendAddButton: UIButton {

    // MARK: - Functions
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let expandedBounds = bounds.insetBy(dx: 0, dy: -23.adjustedHeight)
        return expandedBounds.contains(point)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
