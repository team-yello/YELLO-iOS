//
//  LoadingView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2/21/24.
//

import UIKit

import Lottie
import SnapKit
import Then

final class YelloLoadingView: UIView {
    // MARK: - Variables
    // MARK: Component
    let yelloIndicatorView = LottieAnimationView(name: "lottie_spinner_loading_profile")
    
    // MARK: - Function
    // MARK: LifeCycle
    init() {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Layout Helpers
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.do {
            $0.isHidden = true
            $0.backgroundColor = .black.withAlphaComponent(0.5)
        }
        
        yelloIndicatorView.do {
            $0.play()
            $0.loopMode = .loop
        }
    }
    
    private func setLayout() {
        self.addSubviews(yelloIndicatorView)
        
        yelloIndicatorView.snp.makeConstraints {
            $0.size.equalTo(85.adjusted)
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    func showIndicator() {
        self.isHidden = false
    }
    
    func stopIndicator() {
        self.isHidden = true
    }
}
