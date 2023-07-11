//
//  YelloSearchTextField.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/10.
//

import UIKit

class YelloSearchTextField: UISearchTextField {
    
    let searchImageView = UIImageView()
    let paddingView = UIView()
    let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomSearch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCustomSearch() {
        self.makeCornerRound(radius: CGFloat(Constraints.round))
        self.makeBorder(width: 1, color: .grayscales400)
        
        searchImageView.do {
            $0.image = ImageLiterals.OnBoarding.icSearch
        }
        
        stackView.do {
            $0.addArrangedSubviews(searchImageView, paddingView)
        }
        
        self.addLeftPadding(20)
        self.snp.makeConstraints {
            $0.height.equalTo(52)
        }
        
        paddingView.snp.makeConstraints {
            $0.width.equalTo(20)
        }
        
        self.rightView = stackView
        self.rightViewMode = .always
    }
}
