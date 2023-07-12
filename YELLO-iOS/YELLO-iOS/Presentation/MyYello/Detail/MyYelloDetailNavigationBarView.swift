//
//  MyYelloDetailNavigationBarView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyYelloDetailNavigationBarView: UIView {
    
    // MARK: - Variables
    // MARK: Property
    weak var handleBackButtonDelegate: HandleBackButtonDelegate?
    
    // MARK: Component
    lazy var backButton = UIButton()
    let pointView = UIView()
    let pointImageView = UIImageView()
    let pointLabel = UILabel()

    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - extension
extension MyYelloDetailNavigationBarView {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.backgroundColor = .clear

        backButton.do {
            $0.setImage(ImageLiterals.Profile.icArrowLeftWhite, for: .normal)
            $0.imageView?.tintColor = .white
            $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        }
        
        pointImageView.do {
            $0.image = ImageLiterals.MyYello.icPointWhite
        }
        
        pointLabel.do {
            $0.setTextWithLineHeight(text: "2500", lineHeight: 22)
            $0.font = .uiBodyMedium
            $0.textColor = .white
        }
    }
    
    private func setLayout() {
        self.addSubviews(backButton,
                         pointView)
        
        pointView.addSubviews(pointImageView,
                              pointLabel)
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
        
        pointView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16.adjusted)
        }
        
        pointImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        pointLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(pointImageView.snp.trailing).inset(-8)
        }
    
    }
    
    // MARK: Objc Function
    @objc private func backButtonDidTap() {
        self.handleBackButtonDelegate?.popView()
    }
}
