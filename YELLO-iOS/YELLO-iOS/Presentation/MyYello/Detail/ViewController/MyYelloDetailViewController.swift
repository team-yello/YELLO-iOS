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
        myYelloDetailView.handleInstagramButtonDelegate = self
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

extension MyYelloDetailViewController: HandleInstagramButtonDelegate {
    @objc func instagramButtonTapped() {
        
        if let storyShareURL = URL(string: "instagram-stories://share?source_application=" + Config.metaAppID) {
            
            if UIApplication.shared.canOpenURL(storyShareURL) {
                let renderer = UIGraphicsImageRenderer(size: myYelloDetailView.bounds.size)
                
                let renderImage = renderer.image { _ in
                    myYelloDetailView.drawHierarchy(in: myYelloDetailView.bounds, afterScreenUpdates: true)
                }
                guard let imageData = renderImage.pngData() else {return}
                let pasteboardItems: [String: Any] = [
                    "com.instagram.sharedSticker.backgroundImage": imageData,
                    "com.instagram.sharedSticker.backgroundTopColor": "#000000",
                    "com.instagram.sharedSticker.backgroundBottomColor": "#000000"
                ]
                let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300)]
                UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
                UIApplication.shared.open(storyShareURL, options: [:], completionHandler: nil)
            } else {
                let alert = UIAlertController(title: "알림", message: "인스타그램이 필요합니다", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
