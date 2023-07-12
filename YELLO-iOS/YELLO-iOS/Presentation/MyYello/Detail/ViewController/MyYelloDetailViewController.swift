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
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        
        view.backgroundColor = UIColor(hex: "000000")
        myYelloDetailView.myYelloDetailNavigationBarView.handleBackButtonDelegate = self
    }
    
    override func setLayout() {
        view.addSubviews(myYelloDetailView)

        myYelloDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

// MARK: HandleBackButtonDelegate
extension MyYelloDetailViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
}
