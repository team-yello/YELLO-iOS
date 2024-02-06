//
//  EventPointView.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2/6/24.
//

import UIKit

import SnapKit
import Then

final class EventPointView: BaseView {
    
    let pointLabel = UILabel()
    let nextTimeLabel = UILabel()
    let pointImage = UIImageView()
    let checkButton = UIButton()
    
    override func setStyle() {
        self.backgroundColor = .grayscales900
        self.makeCornerRound(radius: 10.adjustedHeight)
        
        pointLabel.do {
            $0.text = StringLiterals.Event.point
            $0.textColor = .white
            $0.font = .uiSubtitle01
            $0.backgroundColor = .yelloMain500
            $0.textAlignment = .center
            $0.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -60)
        }
        
        nextTimeLabel.do {
            $0.text = StringLiterals.Event.nextTime
            $0.textColor = .grayscales400
            $0.font = .uiLabelLarge
        }
        
        pointImage.do {
            $0.image = UIImage(imageLiteralResourceName: "imgPoint")
        }

        checkButton.do {
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(.grayscales300, for: .normal)
            $0.titleLabel?.font = .uiBodySmall
        }
       
    }
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        self.addSubviews(pointLabel,
                         nextTimeLabel,
                         pointImage,
                         checkButton)
        
        pointLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(38.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        nextTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(66.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        pointImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(200.adjusted)
        }
        
        checkButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.bottom.equalToSuperview().inset(12.adjustedHeight)
        }
    }
}
