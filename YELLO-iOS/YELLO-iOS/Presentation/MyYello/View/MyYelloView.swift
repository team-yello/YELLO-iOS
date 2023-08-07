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
    var myYelloCount: Int = 0 {
        didSet {
            resetLayout()
        }
    }
    weak var handleUnlockButton: HandleUnlockButton?
    var haveTicket: Bool = true {
        didSet {
            if haveTicket {
                unlockButton.setButtonState(state: .yesTicket)
            } else {
                unlockButton.setButtonState(state: .noTicket)
            }
        }
    }
    
    // MARK: Component
    let myYellowNavigationBarView = MyYelloNavigationBarView()
    let myYelloListView = MyYelloListView()
    lazy var unlockButton = MyYelloButton(state: .yesTicket)
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black
        
        unlockButton.do {
            $0.addTarget(self, action: #selector(unlockButtonTapped), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        self.addSubviews(myYellowNavigationBarView,
                         myYelloListView,
                         unlockButton)
        
        myYellowNavigationBarView.snp.makeConstraints {
            $0.top.equalToSuperview()
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
        myYellowNavigationBarView.yelloCountLabel.text = String(self.myYelloCount) + "개"
        myYellowNavigationBarView.yelloCountLabel.asColor(targetString: "개", color: .grayscales500)
    }
    
    @objc func unlockButtonTapped() {
        handleUnlockButton?.unlockButtonTapped()
    }
}
