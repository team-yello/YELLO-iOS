//
//  DetailSenderView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class DetailSenderView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    let senderBackView = UIView(frame: CGRect(x: 0, y: 0, width: 62.adjustedWidth, height: 28.adjustedHeight))
    let senderLabel = UILabel()
    let sendLabel = UILabel()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .clear
        
        senderBackView.do {
            $0.backgroundColor = UIColor(hex: "212529", alpha: 0.6)
            $0.makeCornerRound(radius: 6.adjustedHeight)
            $0.addDottedBorder()
        }
        
        senderLabel.do {
            $0.backgroundColor = .yelloMain500
            $0.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -60)
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Detail.sender, lineHeight: 20.adjustedHeight)
            $0.font = .uiSenderLabel
            $0.textColor = UIColor(hex: "000000")
        }
        
        sendLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Detail.send, lineHeight: 32.adjustedHeight)
            $0.font = .uiHeadline01
            $0.textColor = .white
        }
    }
    
    override func setLayout() {
        self.addSubviews(senderBackView,
                         senderLabel,
                         sendLabel)
        self.snp.makeConstraints {
            $0.width.equalTo(148.adjustedWidth)
            $0.height.equalTo(30.adjustedHeight)
        }
        
        senderBackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(28.adjustedHeight)
            $0.width.equalTo(62.adjustedWidth)
        }
        
        senderLabel.snp.makeConstraints {
            $0.center.equalTo(senderBackView)
            $0.height.equalTo(22.adjustedHeight)
            $0.width.equalTo(62.adjustedWidth)
        }
        
        sendLabel.snp.makeConstraints {
            $0.centerY.equalTo(senderBackView)
            $0.leading.equalTo(senderBackView.snp.trailing).inset(-4.adjustedWidth)
        }
    }
}
