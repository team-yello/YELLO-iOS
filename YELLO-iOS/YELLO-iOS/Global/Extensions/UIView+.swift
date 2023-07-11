//
//  UIView+.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import UIKit

extension UIView {
    
    func makeShadow (radius: CGFloat, color: UIColor = .darkGray, offset: CGSize, opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    func makeCornerRound(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func makeBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
    
    // 원하는 모서리에만 CornerRadius 주기
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    
    // UIView를 UIImage로 변환하는 확장 메서드
    func asImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
    // 토스트 메세지
    func showToast(message: String) {
            let toastLabel = UILabel()
            toastLabel.backgroundColor = UIColor(hex: "343A40", alpha: 0.9)
            toastLabel.textColor = .grayscales200
            toastLabel.textAlignment = .center
            toastLabel.font = .uiLabelLarge
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 8
            toastLabel.clipsToBounds = true
            
            let toastWidth = 253.adjusted
            let toastHeight = 42.adjusted
            toastLabel.frame = CGRect(x: self.frame.size.width/2 - toastWidth/2,
                                       y: self.frame.size.height - toastHeight - 25,
                                       width: toastWidth,
                                       height: toastHeight)
            self.addSubview(toastLabel)
            
            UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    
}
