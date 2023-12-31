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
    func showToast(message: String, at: CGFloat = 25) {
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
        toastLabel.frame = CGRect(x: self.frame.size.width / 2 - toastWidth / 2,
                                  y: self.frame.size.height - toastHeight - at.adjusted,
                                  width: toastWidth,
                                  height: toastHeight)
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(toastLabel)
        }
        
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    /// Border를 점선으로 처리해주는 함수
    func addDottedBorder() {
        let dottedBorderLayer = CAShapeLayer()
        dottedBorderLayer.strokeColor = UIColor.grayscales700.cgColor
        dottedBorderLayer.lineWidth = 1
        
        // 점선 스타일 설정
        dottedBorderLayer.lineDashPattern = [3, 3]
        dottedBorderLayer.fillColor = nil
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius)
        dottedBorderLayer.path = path.cgPath
        
        layer.addSublayer(dottedBorderLayer)
    }
    
    func setBackgroundImageWithScaling(image: UIImage) {
        let backgroundImageView = UIImageView(image: image)
        backgroundImageView.contentMode = .scaleAspectFit
        
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func addBottomBorderWithColor(color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(border)
    }
    
    func addAboveTheBottomBorderWithColor(color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(border)
    }
    
    // 그라데이션 배경 적용
    func applyGradientBackground(topColor: UIColor, bottomColor: UIColor, startPointX: Double = 0.0, startPointY: Double = 0.0, endPointX: Double = 1.0, endPointY: Double = 1.0) {

        removeGradientBackground()

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
        layer.insertSublayer(gradientLayer, at: 0)
       }

    func removeGradientBackground() {
        if let gradientLayer = layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            gradientLayer.removeFromSuperlayer()
        }
    }
    
    func animateShimmer() {
        stopShimmering()
        let gradientLayer = CAGradientLayer()
        let gradationColor = [UIColor.clear, .white.withAlphaComponent(0.2), .clear]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.colors = gradationColor.map { $0.cgColor }
        gradientLayer.locations = [-0.5, 0.5, 1.5]
        self.layer.addSublayer(gradientLayer)

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 1.5
        animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        gradientLayer.add(animation, forKey: animation.keyPath)
    }
    
    func stopShimmering() {
        self.layer.sublayers?.forEach { layer in
            if layer is CAGradientLayer {
                layer.removeFromSuperlayer()
            }
        }
    }
}
