//
//  UITextField+.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import UIKit

extension UITextField {
    
    func setPlaceholderColor(_ placeholderColor: UIColor) {
                guard let string = self.placeholder else {
                    return
                }
                attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: placeholderColor])
    }
    
    func addLeftPadding(_ value: Double) {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.height))
      self.leftView = paddingView
      self.leftViewMode = ViewMode.always
    }
    
    func addRightPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
