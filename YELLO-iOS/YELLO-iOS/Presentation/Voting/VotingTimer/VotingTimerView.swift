//
//  VotingTimerView.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/08.
//

import UIKit

import SnapKit
import Then

final class VotingTimerView: BaseView {
    
    let timeLabel = UILabel()
    
    private let backgroundLayer = CAShapeLayer()
    let progressLayer = CAShapeLayer()
    private let animationName = "progressAnimation"

    private var circularPath: UIBezierPath {
        UIBezierPath(
            arcCenter: CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0),
            radius: 95,
            startAngle: CGFloat(3 * Double.pi / 2),
            endAngle: CGFloat(-Double.pi / 2),
            clockwise: false // 시계 방향과 반대 방향을 나타내기 위해 clockwise 값을 false로 변경
        )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        // UIBezierPath는 런타임마다 바뀌는 frame값을 참조하여 원의 윤곽 레이아웃을 알아야 하므로, 이곳에 적용
        self.backgroundLayer.path = self.circularPath.cgPath
        self.progressLayer.path = self.circularPath.cgPath
    }

    override func setStyle() {
        self.backgroundColor = .clear
        
        timeLabel.do {
            $0.textColor = .yelloMain500
            $0.font = .uiTimeLabel
        }
        
        backgroundLayer.do {
            $0.path = self.circularPath.cgPath
            $0.fillColor = UIColor.clear.cgColor
            $0.lineCap = .round
            $0.lineWidth = 16.0
            $0.strokeStart = 0
            $0.strokeColor = UIColor(hex: "3B3B1E").cgColor
            $0.zPosition = 0
        }
        
        progressLayer.do {
            $0.path = self.circularPath.cgPath
            $0.fillColor = UIColor.clear.cgColor
            $0.lineCap = .round
            $0.lineWidth = 16.0
            $0.strokeStart = 0
            $0.strokeEnd = 1
            $0.strokeColor = UIColor.yelloMain500.cgColor
            $0.zPosition = 1
        }
    }
    
    override func setLayout() {
        self.addSubview(self.timeLabel)
        self.layer.addSublayer(self.backgroundLayer)
        self.layer.addSublayer(self.progressLayer)
        
        timeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
