//
//  UIStackView+.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
         for view in views {
             self.addArrangedSubview(view)
         }
     }
    
    func clearSubViews() {
        self.arrangedSubviews.forEach {
            self.removeArrangedSubview($0) // superview에서 view 삭제
            $0.removeFromSuperview() // 자식view에서도 superview 삭제
        }
    }
}
