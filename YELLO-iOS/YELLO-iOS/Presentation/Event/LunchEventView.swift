//
//  LunchEventView.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2/6/24.
//

import UIKit

import SnapKit
import Then

final class LunchEventView: BaseView {
        
    let evnetTimeLabel = UILabel()
    let presentLabel = UILabel()
    let timeDescriptionLabel = UILabel()
    let touchLabel = UILabel()

    let itemImage = UIImageView()
    
    override func setStyle() {
        self.backgroundColor = .black
        
        evnetTimeLabel.do {
            $0.text = StringLiterals.Event.eventTime
            $0.textColor = .black
            $0.font = .uiEventLabel
            $0.backgroundColor = .yelloMain500
            $0.textAlignment = .center
            $0.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -60)
        }
        
        presentLabel.do {
            $0.text = StringLiterals.Event.present
            $0.textColor = .white
            $0.font = .uiHeadline00
        }
        
        timeDescriptionLabel.do {
            $0.text = StringLiterals.Event.time
            $0.textColor = .grayscales500
            $0.font = .uiLabelSmall
        }
        
        touchLabel.do {
            $0.text = StringLiterals.Event.touch
            $0.textColor = .grayscales400
            $0.font = .uiLabelLarge
        }

        itemImage.do {
            $0.image = UIImage(imageLiteralResourceName: "imgItemList")
        }
       
    }
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        self.addSubviews(evnetTimeLabel,
                         presentLabel,
                         timeDescriptionLabel,
                         touchLabel,
                         itemImage)
        
        evnetTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(statusBarHeight + 55.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(102.adjusted)
            $0.height.equalTo(21.adjusted)
        }
        
        presentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(statusBarHeight + 92.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        timeDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(statusBarHeight + 128.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        touchLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(statusBarHeight + 178.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        itemImage.snp.makeConstraints {
            $0.width.equalTo(257.adjustedWidth)
            $0.height.equalTo(150.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(40.adjustedHeight)
        }
    }
}

extension LunchEventView {
    
}
