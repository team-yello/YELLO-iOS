//
//  MyYelloDetailViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyYelloDetailViewController: BaseViewController {
    
    private let myYelloDetailView = MyYelloDetailView()
    
    override func setStyle() {
        view.backgroundColor = .black
        myYelloDetailView.myYelloDetailNavigationBarView.handleBackButtonDelegate = self
    }
    
    override func setLayout() {
        view.addSubviews(myYelloDetailView)
        
        let tabbarHeight = 60 + safeAreaBottomInset()

        myYelloDetailView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

}

// MARK: HandleBackButtonDelegate
extension MyYelloDetailViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}
