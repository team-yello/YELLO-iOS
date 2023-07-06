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

// MARK: - TODO
/// textField 분리하기
/// delegate 분리


final class YelloTextFieldView: UIView {
    
    // MARK: - Variables


    //MARK: Components
    private let titleLabel = UILabel()
    let textField = YelloTextField()
    private let helperLabel = UILabel()
    
    // MARK: - Function

    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    ///텍스트필드 상태도 인자로 받아서 분기 처리 할 예정
    init(title: String, state: iconState, helper: String = "") {
        super.init(frame: CGRect())
        titleLabel.text = title
        textField.setButtonState(state: state)
        helperLabel.text = helper
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout Helpers
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.addSubviews(titleLabel,textField,helperLabel)
        
        titleLabel.do {
            $0.font = .uiHeadline01
            $0.textColor = .black
        }
        
        helperLabel.do {
            $0.font = .uiBody04
            $0.textColor = .gray
        }
        
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
        
        helperLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.top.equalTo(textField.snp.bottom).offset(4)
            $0.bottom.equalToSuperview()
        }
    }
}


