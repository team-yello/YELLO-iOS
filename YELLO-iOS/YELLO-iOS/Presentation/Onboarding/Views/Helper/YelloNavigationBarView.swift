//
//  YelloNavigationBarView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/04.
//

import UIKit

final class YelloNavigationBarView: UIView {
    let backButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        backButton.do {
            $0.setImage(ImageLiterals.OnBoarding.icArrowLeft, for: .normal)
        }
    }
    
    private func setLayout() {
        self.addSubviews(backButton)
        
        self.snp.makeConstraints {
            $0.height.equalTo(Constraints.navigationBarHeight)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
    }
}
