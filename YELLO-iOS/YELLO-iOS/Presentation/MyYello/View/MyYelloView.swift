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
    
    var myYelloCount: Int = MyYelloModelDummy.count
    
    private let myYellowNavigationBarView = MyYelloNavigationBarView()
    private let myYelloEmptyView = MyYelloEmptyView()
    private let myYelloListView = MyYelloListView()
    
    override func setStyle() {
        self.backgroundColor = .black
        
        myYellowNavigationBarView.yelloCountLabel.text = String(myYelloCount) + "개"
        myYellowNavigationBarView.yelloCountLabel.asColor(targetString: "개", color: .grayscales500)
    }
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        let tabbarHeight = 60 + safeAreaBottomInset()
        
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
                $0.bottom.equalToSuperview().inset(tabbarHeight)
            }
        } else {
            self.addSubviews(myYelloListView)
            myYelloListView.snp.makeConstraints {
                $0.top.equalTo(myYellowNavigationBarView.snp.bottom)
                $0.width.equalToSuperview()
                $0.bottom.equalToSuperview().inset(tabbarHeight)
            }
        }
    }
}
