//
//  MyYelloView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyYelloView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    static var myYelloCount: Int = 0
    
    // MARK: Component
    private let myYellowNavigationBarView = MyYelloNavigationBarView()
    let myYelloListView = MyYelloListView()
    let unlockButton = MyYelloButton(frame: CGRect(x: 0, y: 0, width: 343, height: 62))
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black
        
//        unlockButton.do {
//            $0.backgroundColor = .yelloMain500
//            $0.applyGradientBackground(topColor: UIColor(hex: "D96AFF"), bottomColor: UIColor(hex: "7C57FF"))
//            $0.makeCornerRound(radius: 31)
//            $0.layer.cornerCurve = .continuous
//            $0.titleLabel?.font = .uiSubtitle03
//            $0.setTitleColor(.black, for: .normal)
//            $0.setImage(ImageLiterals.MyYello.icLock, for: .normal)
//            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 4)
//            $0.setTitle(StringLiterals.MyYello.List.unlockButton, for: .normal)
//        }
    }
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        self.addSubviews(myYellowNavigationBarView,
                         myYelloListView,
                         unlockButton)
        
        myYellowNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
        }
        
        myYelloListView.snp.makeConstraints {
            $0.top.equalTo(myYellowNavigationBarView.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        unlockButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(62)
            $0.bottom.equalTo(myYelloListView).inset(28.adjustedHeight)
        }
    }
    
    func resetLayout() {
        myYellowNavigationBarView.yelloCountLabel.text = String(MyYelloView.myYelloCount) + "개"
        myYellowNavigationBarView.yelloCountLabel.asColor(targetString: "개", color: .grayscales500)
    }
}
