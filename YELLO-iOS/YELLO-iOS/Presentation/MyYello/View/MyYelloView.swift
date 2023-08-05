//
//  MyYelloView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

protocol HandleUnlockButton: AnyObject {
    func unlockButtonTapped()
}

final class MyYelloView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    static var myYelloCount: Int = 0
    weak var handleUnlockButton: HandleUnlockButton?
    
    // MARK: Component
    let myYellowNavigationBarView = MyYelloNavigationBarView()
    let myYelloListView = MyYelloListView()
    lazy var unlockButton = MyYelloButton(frame: CGRect(x: 0, y: 0, width: 400, height: 62.adjusted))
//    lazy var unlockButton = MyYelloTicketButton(frame: CGRect(x: 0, y: 0, width: 400, height: 62))
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black
        
        unlockButton.do {
            $0.addTarget(self, action: #selector(unlockButtonTapped), for: .touchUpInside)
        }
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
            $0.height.equalTo(62.adjusted)
            $0.bottom.equalTo(myYelloListView).inset(28.adjustedHeight)
        }
    }
    
    func resetLayout() {
        myYellowNavigationBarView.yelloCountLabel.text = String(MyYelloView.myYelloCount) + "개"
        myYellowNavigationBarView.yelloCountLabel.asColor(targetString: "개", color: .grayscales500)
    }
    
    @objc func unlockButtonTapped() {
        handleUnlockButton?.unlockButtonTapped()
    }
}
