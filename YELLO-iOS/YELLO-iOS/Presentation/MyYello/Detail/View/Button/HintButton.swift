//
//  HintButton.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/06.
//

import UIKit

import SnapKit
import Then

final class HintButton: UIButton {
    
    // MARK: - enum
    /// 상태 구분
    @frozen enum HintStatus {
        case keyword //100포인트로 키워드 확인하기
        case initial //300포인트로 초성 확인하기
        case plus //0포인트로 초성 확인하기
    }
    
    private let titleStackView = UIStackView()
    private let buttonTitleLabel = UILabel()
    private let plusLabel = UILabel()
    private let strikeView = UIView()
    
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
    
    init(state: HintStatus) {
        super.init(frame: CGRect())
        setUI()
        setButtonState(state: state)
    }
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = UIColor(hex: "FFFFFF", alpha: 0.35)
        self.makeCornerRound(radius: 27.adjustedHeight)
        self.layer.cornerCurve = .continuous
        self.frame = CGRect(x: 0, y: 0, width: 0, height: 54.adjustedHeight)
        
        titleStackView.do {
            $0.addArrangedSubviews(plusLabel, buttonTitleLabel)
            $0.axis = .horizontal
            $0.spacing = 8
            $0.isUserInteractionEnabled = false
        }
        
        buttonTitleLabel.do {
            $0.text = StringLiterals.MyYello.Detail.keywordButton
            $0.textColor = .black
            $0.font = .uiBodyMedium
        }
        
        plusLabel.do {
            $0.text = "300"
            $0.textColor = .white
            $0.font = .uiBodyMedium
            $0.isHidden = true
        }
        
        strikeView.do {
            $0.backgroundColor = .white
            $0.isHidden = true
        }
    }
    
    private func setLayout() {
        
        self.addSubviews(titleStackView)
        plusLabel.addSubviews(strikeView)
        
        titleStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        strikeView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(1.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(-3.adjustedWidth)
        }
    }
    
    // MARK: Custom Function
    func setButtonState(state: HintStatus) {
        switch state {
        case .keyword:
            self.plusLabel.isHidden = true
            self.strikeView.isHidden = true
            self.buttonTitleLabel.text = StringLiterals.MyYello.Detail.keywordButton
            
        case .initial:
            self.plusLabel.isHidden = true
            self.strikeView.isHidden = true
            self.buttonTitleLabel.text = StringLiterals.MyYello.Detail.sendButton

        case .plus:
            self.plusLabel.isHidden = false
            self.strikeView.isHidden = false
            self.buttonTitleLabel.text = StringLiterals.MyYello.Detail.plusSendButton
            self.buttonTitleLabel.asColor(targetString: "0포인트", color: .purpleSub500)
        }
    }
}
