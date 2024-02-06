//
//  LunchEventViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2/6/24.
//

import Lottie
import UIKit

final class LunchEventViewController: BaseViewController {
    
    private let originView = LunchEventView()
    private var animationView = LottieAnimationView()
    private let eventPointView = EventPointView()
    
    override func loadView() {
        self.view = originView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 점심시간 이벤트 서버통신
        getLunchEvent()
        setAnimationView()
        tabBarController?.tabBar.isHidden = false
    }
    
}

extension LunchEventViewController {
    private func getLunchEvent() {
        
    }
    
    private func setAnimationView() {
        animationView = .init(name: "eventbox_default")
        let animationWidth: CGFloat = 400.adjustedWidth
        let animationHeight: CGFloat = 450.adjustedHeight
        animationView.frame = CGRect(x: 0, y: 0, width: animationWidth, height: animationHeight)
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        let centerX = view.bounds.midX
        let centerY = view.bounds.midY
        animationView.center = CGPoint(x: centerX, y: centerY)
        animationView.play()
        
        animationView.isUserInteractionEnabled = true
        view.addSubview(animationView)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.animationViewTapped))
        self.animationView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func animationViewTapped() {
        animationView.removeFromSuperview()
        animationView = .init(name: "eventbox_open")
        let animationWidth: CGFloat = 400.adjustedWidth
        let animationHeight: CGFloat = 450.adjustedHeight
        animationView.frame = CGRect(x: 0, y: 0, width: animationWidth, height: animationHeight)
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        let centerX = view.bounds.midX
        let centerY = view.bounds.midY
        animationView.center = CGPoint(x: centerX, y: centerY)
        animationView.play()
        view.addSubview(animationView)
        animationView.removeFromSuperview()
    }
}