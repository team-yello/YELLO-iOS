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
    
    var myYelloCount: Int = 90
    
    private let myYellowNavigationBar = MyYelloNavigationBarView()
    private let myYelloEmptyView = MyYelloEmptyView()
    private let myYelloListView = MyYelloListView()
    
    override func setStyle() {
        self.backgroundColor = .black
    }
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        let tabbarHeight = 60 + safeAreaBottomInset()
        
        self.addSubviews(myYellowNavigationBar)
        
        myYellowNavigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
        }
        
        if myYelloCount == 0 {
            self.addSubviews(myYelloEmptyView)
            myYelloEmptyView.snp.makeConstraints {
                $0.top.equalTo(myYellowNavigationBar.snp.bottom)
                $0.width.equalToSuperview()
                $0.bottom.equalToSuperview().inset(tabbarHeight)
            }
        } else {
            self.addSubviews(myYelloListView)
            myYelloListView.snp.makeConstraints {
                $0.top.equalTo(myYellowNavigationBar.snp.bottom)
                $0.width.equalToSuperview()
                $0.bottom.equalToSuperview().inset(tabbarHeight)
            }
        }
    }
}
