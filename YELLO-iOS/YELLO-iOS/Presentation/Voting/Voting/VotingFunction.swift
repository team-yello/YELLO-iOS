//
//  Voting.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/11.
//

import UIKit

extension VotingViewController {
    func createTwoLineLabel(text: String, firstLineFont: UIFont, firstLineColor: UIColor, secondLineFont: UIFont, secondLineColor: UIColor) -> UILabel {
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
    
    func updateLabelAppearance(_ label: UILabel) {
        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        attributedString.addAttributes([.foregroundColor: UIColor.yelloMain500, .font: UIFont.uiBodyMedium], range: NSRange(location: 0, length: 3))
        attributedString.addAttributes([.foregroundColor: UIColor.grayscales600, .font: UIFont.uiLabelSmall], range: NSRange(location: 3, length: attributedString.length - 3))
        label.attributedText = attributedString
    }
    
}
