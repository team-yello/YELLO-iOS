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
    var myYelloCount: Int = MyYelloModelDummy.count
    
    // MARK: Component
    private let myYellowNavigationBarView = MyYelloNavigationBarView()
    private let myYelloEmptyView = MyYelloEmptyView()
    let myYelloListView = MyYelloListView()
    let unlockButton = UIButton()
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .black
        
        myYellowNavigationBarView.yelloCountLabel.text = String(myYelloCount) + "개"
        myYellowNavigationBarView.yelloCountLabel.asColor(targetString: "개", color: .grayscales500)
        
        unlockButton.do {
            $0.backgroundColor = .yelloMain500
            $0.layer.cornerRadius = 8
            $0.titleLabel?.font = .uiSubtitle03
            $0.setTitleColor(.black, for: .normal)
            $0.setImage(ImageLiterals.MyYello.icLock, for: .normal)
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 4)
            $0.setTitle(StringLiterals.MyYello.List.unlockButton, for: .normal)
        }
    }
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        self.addSubviews(myYellowNavigationBarView)
        
        myYellowNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
        }
        
        if myYelloCount == 0 {
            self.addSubviews(myYelloEmptyView)
            myYelloEmptyView.snp.makeConstraints {
                $0.top.equalTo(myYellowNavigationBarView.snp.bottom)
                $0.width.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
        } else {
            self.addSubviews(myYelloListView)
            myYelloListView.snp.makeConstraints {
                $0.top.equalTo(myYellowNavigationBarView.snp.bottom)
                $0.width.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
            
            self.addSubviews(unlockButton)
            unlockButton.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.height.equalTo(54)
                $0.bottom.equalTo(myYelloListView).inset(28)
            }
        }
    }
}
