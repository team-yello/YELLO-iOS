//
//  MyYelloButton.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/04.
//

import UIKit

import SnapKit
import Then

final class MyYelloButton: UIButton {
    
    enum TicketStatus {
        case yesTicket
        case noTicket
        case useTicket
    }
    
    private enum Color {
        static var gradientColors = [
            UIColor.white,
            UIColor.white.withAlphaComponent(0.6),
            UIColor.white.withAlphaComponent(0.3),
            UIColor.white.withAlphaComponent(0.0),
            UIColor.white.withAlphaComponent(0.3),
            UIColor.white.withAlphaComponent(0.6),
            UIColor.white
        ]
    }
    
    private enum Constants {
        static let gradientLocation = [Int](0..<Color.gradientColors.count)
            .map(Double.init)
            .map { $0 / Double(Color.gradientColors.count) }
            .map(NSNumber.init)
        static let cornerRadius = 31.adjusted
        static let cornerWidth = 3.0
    }
    
    private lazy var backgroundView = UIView()
    private let lockImageView = UIImageView()
    private let titleStackView = UIStackView()
    private let buttonTitleLabel = UILabel()
    private let buttonTicketTitleLabel = UILabel()
    
    private let keyImageView = UIImageView()
    let keyCountLabel = UILabel()
    private let keyStackView = UIStackView()
    private let titleTicketStackView = UIStackView()
    
    let findLabel = UILabel()
    
    private var timer: Timer?

    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    init(state: TicketStatus) {
        super.init(frame: CGRect())
        setUI()
        setButtonState(state: state)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        animateBorderGradation()
    }

    deinit {
        self.timer?.invalidate()
        self.timer = nil
        print("DEINIT: MyYelloButton")
    }
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.frame = CGRect(x: 0, y: 0, width: 343.adjusted, height: 62.adjusted)
        self.makeCornerRound(radius: Constants.cornerRadius)
        self.layer.cornerCurve = .continuous

        backgroundView.do {
            $0.backgroundColor = .clear
            $0.makeCornerRound(radius: Constants.cornerRadius)
            $0.layer.cornerCurve = .continuous
            $0.isUserInteractionEnabled = false
        }
        
        titleStackView.do {
            $0.addArrangedSubviews(lockImageView, buttonTitleLabel)
            $0.axis = .horizontal
            $0.spacing = 4
            $0.isUserInteractionEnabled = false
        }
        
        lockImageView.do {
            $0.image = ImageLiterals.MyYello.icLock
        }
        
        buttonTitleLabel.do {
            $0.text = StringLiterals.MyYello.List.unlockButton
            $0.textColor = .black
            $0.font = .uiSubtitle03
        }
        
        buttonTicketTitleLabel.do {
            $0.text = StringLiterals.MyYello.List.keyButton
            $0.textColor = .white
            $0.font = .uiSubtitle03
        }
        
        keyImageView.do {
            $0.image = ImageLiterals.MyYello.icKeyWhite
        }
        
        keyCountLabel.do {
            $0.text = "0"
            $0.font = .uiSubtitle02
            $0.textColor = .white
        }
        
        keyStackView.do {
            $0.addArrangedSubviews(keyImageView, keyCountLabel)
            $0.axis = .horizontal
            $0.spacing = 4.adjustedWidth
            $0.isUserInteractionEnabled = false
        }
        
        titleTicketStackView.do {
            $0.addArrangedSubviews(keyStackView, buttonTicketTitleLabel)
            $0.axis = .horizontal
            $0.spacing = 12.adjustedWidth
            $0.isUserInteractionEnabled = false
        }
        
        findLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Detail.findLabel, lineHeight: 22.adjustedHeight)
            $0.font = .uiSubtitle02
            $0.textColor = .white
            $0.isHidden = true
        }
    }
    
    private func setLayout() {
        
        self.addSubviews(backgroundView,
                         titleStackView,
                         titleTicketStackView,
                         findLabel)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        titleTicketStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        findLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    func setButtonState(state: TicketStatus) {
        switch state {
        case .noTicket:
            self.removeGradientBackground()
            self.backgroundColor = .yelloMain500
            titleStackView.isHidden = false
            backgroundView.isHidden = false
            titleTicketStackView.isHidden = true
            buttonTitleLabel.textColor = .black
            
        case .yesTicket:
            self.applyGradientBackground(topColor: UIColor(hex: "D96AFF"), bottomColor: UIColor(hex: "7C57FF"))
            titleStackView.isHidden = true
            backgroundView.isHidden = true
            self.backgroundView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            titleTicketStackView.isHidden = false
            buttonTitleLabel.textColor = .white
            
        case .useTicket:
            self.removeGradientBackground()
            self.backgroundColor = .clear
            self.isUserInteractionEnabled = false
            titleStackView.isHidden = true
            backgroundView.isHidden = true
            titleTicketStackView.isHidden = true
            findLabel.isHidden = false
        }
    }
    
    func animateBorderGradation() {
        // 기존 그라데이션 레이어 제거
        self.backgroundView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        // 1. 경계선에만 색상을 넣기 위해서 CAShapeLayer 인스턴스 생성
        let shape = CAShapeLayer()
        shape.path = UIBezierPath(
            roundedRect: self.backgroundView.bounds.insetBy(dx: Constants.cornerWidth, dy: Constants.cornerWidth),
            cornerRadius: Constants.cornerRadius
        ).cgPath
        shape.lineWidth = Constants.cornerWidth
        shape.cornerRadius = Constants.cornerRadius
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.clear.cgColor
        
        // 2. conic 그라데이션 효과를 주기 위해서 CAGradientLayer 인스턴스 생성 후 mask에 CAShapeLayer 대입
        let gradient = CAGradientLayer()
        gradient.frame = self.backgroundView.bounds
        gradient.type = .conic
        gradient.colors = Color.gradientColors.map(\.cgColor) as [Any]
        gradient.locations = Constants.gradientLocation
        gradient.startPoint = CGPoint(x: 0.2, y: 0.2)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.mask = shape
        gradient.cornerRadius = Constants.cornerRadius
        self.backgroundView.layer.addSublayer(gradient)
        
        // 3. 매 0.15초마다 마치 circular queue처럼 색상을 번갈아서 바뀌도록 구현
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
            gradient.removeAnimation(forKey: "myAnimation")
            let previous = Color.gradientColors.map(\.cgColor)
            let last = Color.gradientColors.removeLast()
            Color.gradientColors.insert(last, at: 0)
            let lastColors = Color.gradientColors.map(\.cgColor)
            
            let colorsAnimation = CABasicAnimation(keyPath: "colors")
            colorsAnimation.fromValue = previous
            colorsAnimation.toValue = lastColors
            colorsAnimation.repeatCount = 1
            colorsAnimation.duration = 0.2
            colorsAnimation.isRemovedOnCompletion = false
            colorsAnimation.fillMode = .both
            gradient.add(colorsAnimation, forKey: "myAnimation")
        }
    }
}
