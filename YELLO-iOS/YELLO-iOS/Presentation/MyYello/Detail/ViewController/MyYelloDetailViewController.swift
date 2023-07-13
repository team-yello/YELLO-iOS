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
    
    // MARK: - Variables
    // MARK: Constants
    private let myYelloDetailView = MyYelloDetailView()
    let dummy = myYelloBackgroundColorDummy
    let hexDummy = myYelloBackgroundColorStringDummy
    var colorIndex: Int = 2
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setAddTarget()
    }
    
    // MARK: Layout Helpers
    override func setStyle() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        setBackgroundView()
    }
    
    override func setLayout() {
        view.addSubviews(myYelloDetailView)
        
        myYelloDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - extension
extension MyYelloDetailViewController {
    
    // MARK: Custom Function
    private func setDelegate() {
        myYelloDetailView.myYelloDetailNavigationBarView.handleBackButtonDelegate = self
        myYelloDetailView.handleInstagramButtonDelegate = self
        
        myYelloDetailView.pointLackView = PointLackView()
        myYelloDetailView.pointLackView?.handleYelloButtonDelegate = self
    }
    
    // MARK: objc Function
    private func setAddTarget() {
        myYelloDetailView.senderButton.addTarget(self, action: #selector(senderButtonTapped), for: .touchUpInside)
    }
    
    @objc private func senderButtonTapped() {
        let paymentViewController = PaymentViewController()
        navigationController?.pushViewController(paymentViewController, animated: true)
    }
    
    private func setBackgroundView() {
        let gradientView = CAGradientLayer()
        gradientView.frame = view.bounds
        gradientView.colors = [dummy[colorIndex].backgroundColorTop.cgColor, dummy[colorIndex].backgroundColorBottom.cgColor]
        
        gradientView.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientView.endPoint = CGPoint(x: 1.0, y: 1.0)
        view.layer.insertSublayer(gradientView, at: 0)
    }
}

// MARK: HandleBackButtonDelegate
extension MyYelloDetailViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: HandleInstagramButtonDelegate
extension MyYelloDetailViewController: HandleInstagramButtonDelegate {
    @objc func instagramButtonTapped() {
        if let storyShareURL = URL(string: "instagram-stories://share?source_application=" + Config.metaAppID) {
            
            if UIApplication.shared.canOpenURL(storyShareURL) {
                let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
                
                let renderImage = renderer.image { _ in
                    view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
                }
                
                let topColor = "#" + hexDummy[colorIndex].backgroundColorTop
                let bottomColor = "#" + hexDummy[colorIndex].backgroundColorBottom
                
                guard let imageData = renderImage.pngData() else {return}
                let pasteboardItems: [String: Any] = [
                    "com.instagram.sharedSticker.backgroundImage": imageData,
                    "com.instagram.sharedSticker.backgroundTopColor": topColor, "com.instagram.sharedSticker.backgroundBottomColor" : bottomColor
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

extension MyYelloDetailViewController: HandleYelloButtonDelegate {
    func yelloButtonTapped() {
        print("안녀엉")
        self.dismiss(animated: true, completion: nil)
        let votingViewController = VotingViewController()
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: votingViewController)
    }
}