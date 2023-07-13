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
    let senderBackView = UIView()
    let senderLabel = UILabel()
    let sendLabel = UILabel()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .clear
        
        senderBackView.do {
            $0.backgroundColor = UIColor(hex: "212529", alpha: 0.6)
            $0.makeBorder(width: 1, color: .grayscales700)
            $0.makeCornerRound(radius: 6)
        }
        
        senderLabel.do {
            $0.backgroundColor = .yelloMain500
            $0.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -60)
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Detail.sender, lineHeight: 20)
            $0.font = .uiSenderLabel
            $0.textColor = UIColor(hex: "000000")
        }
        
        sendLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Detail.send, lineHeight: 32)
            $0.font = .uiHeadline01
            $0.textColor = .white
        }
    }
    
    override func setLayout() {
        self.addSubviews(senderBackView,
                         senderLabel,
                         sendLabel)
        self.snp.makeConstraints {
            $0.width.equalTo(148)
            $0.height.equalTo(30)
        }
        
        senderBackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(28)
            $0.width.equalTo(62)
        }
        
        senderLabel.snp.makeConstraints {
            $0.center.equalTo(senderBackView)
            $0.height.equalTo(22)
            $0.width.equalTo(62)
        }
        
        sendLabel.snp.makeConstraints {
            $0.centerY.equalTo(senderBackView)
            $0.leading.equalTo(senderBackView.snp.trailing).inset(-4)
        }
    }
}
