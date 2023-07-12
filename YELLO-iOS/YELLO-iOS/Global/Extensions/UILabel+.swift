//
//  UILabel+.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import UIKit

extension UILabel {
    func setTextWithLineHeight(text: String?, lineHeight: CGFloat) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - font.lineHeight) * 0.26
            ]
            
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
            self.textAlignment = .center
            self.numberOfLines = 2
        }
    }
    
    /// 특정 Label에 색상 주기
    func asColor(targetString: String, color: UIColor?) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
        attributedText = attributedString
    }
    
    /// 텍스트가 두 줄일 때 각 줄에 폰트, 색상을 다르게 주는 함수
    static func createTwoLineLabel(text: String, firstLineFont: UIFont, firstLineColor: UIColor, secondLineFont: UIFont, secondLineColor: UIColor) -> UILabel {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: text)
        
        // 첫 번째 줄 속성 적용
        attributedText.addAttribute(.font, value: firstLineFont, range: NSRange(location: 0, length: 3))
        attributedText.addAttribute(.foregroundColor, value: firstLineColor, range: NSRange(location: 0, length: 3))
        
        // 두 번째 줄 속성 적용
        attributedText.addAttribute(.font, value: secondLineFont, range: NSRange(location: 3, length: text.count - 3))
        attributedText.addAttribute(.foregroundColor, value: secondLineColor, range: NSRange(location: 3, length: text.count - 3))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        
        label.attributedText = attributedText
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }
    
    /// 텍스트가 두 줄일 때 첫째줄의 색상만 바꾸는 함수
    func updateLabelAppearance() {
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        attributedString.addAttributes([.foregroundColor: UIColor.yelloMain500, .font: UIFont.uiBodyMedium], range: NSRange(location: 0, length: 3))
        attributedString.addAttributes([.foregroundColor: UIColor.grayscales600, .font: UIFont.uiLabelSmall], range: NSRange(location: 3, length: attributedString.length - 3))
        self.attributedText = attributedString
    }
    
}
