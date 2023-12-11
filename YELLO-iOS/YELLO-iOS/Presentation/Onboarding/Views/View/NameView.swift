//
//  NameView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/10.
//

import UIKit

import SnapKit
import Then

final class NameView: UIView {
    // MARK: - Variables
    // MARK: Property
    // MARK: Component
    let nameGuideImageView = UIImageView()
    let nameTextFieldView = YelloTextFieldView(title: "나의 이름은?", state: .normal, placeholder: "ex.김옐로", helper: "이후에는 이름 수정이 어려우니 실제 이름을 적어주세요.")
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        nameGuideImageView.do {
            $0.image = ImageLiterals.OnBoarding.nameGuide
        }
        
        nameTextFieldView.helperLabel.do {
            $0.asColor(targetString: "실제 이름", color: .yelloMain500)
        }
    }
    
    private func setLayout() {
        self.addSubviews(nameGuideImageView, nameTextFieldView)
        
        nameGuideImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20.adjusted)
            $0.trailing.equalToSuperview()
        }
        
        nameTextFieldView.snp.makeConstraints {
            $0.top.equalTo(nameGuideImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(32.adjusted)
        }
        
    }
    
}
