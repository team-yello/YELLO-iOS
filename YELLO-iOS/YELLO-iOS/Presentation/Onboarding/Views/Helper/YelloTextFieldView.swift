//
//  YelloTextFieldView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//
//

import UIKit

import SnapKit
import Then

final class YelloTextFieldView: UIView {
    // MARK: - Variables
    var state: iconState = .normal
    
    // MARK: Components
    let titleLabel = YelloGuideLabel()
    let textField = YelloTextField()
    let helperLabel = YelloHelperLabel()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    /// 텍스트필드 상태도 인자로 받아서 분기 처리
    init(title: String, state: iconState,
         placeholder: String, helper: String = "") {
        super.init(frame: CGRect())
        titleLabel.text = title
        self.state = state
        textField.setButtonState(state: state)
        helperLabel.setLabelStyle(text: helper, State: state)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - extension
extension YelloTextFieldView {
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        if state == .error {
            textField.setButtonState(state: .error)
            helperLabel.setLabelStyle(text: "", State: .error)
        }
        
        textField.do {
            $0.autocapitalizationType = .none
        }
        
    }
    
    private func setLayout() {
        self.addSubviews(titleLabel, textField, helperLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(18.adjusted)
        }
        
        helperLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12.adjusted)
            $0.top.equalTo(textField.snp.bottom).offset(4.adjusted)
            $0.bottom.equalToSuperview()
        }
    }
}
