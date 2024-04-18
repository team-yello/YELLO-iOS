//
//  LunchEventViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2/6/24.
//

import UIKit

import Amplitude
import Lottie

final class LunchEventViewController: BaseViewController {
    
    private let originView = LunchEventView()
    private var animationView = LottieAnimationView()
    private let eventPointView = EventPointView()
    
    override func loadView() {
        self.view = originView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setAnimationView()
        tabBarController?.tabBar.isHidden = false
    }
}

extension LunchEventViewController {
    private func setAnimationView() {
        animationView = .init(name: "eventbox_default-4")
        let animationWidth: CGFloat = 400.adjustedWidth
        let animationHeight: CGFloat = 534.adjustedHeight
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
        self.originView.touchLabel.isHidden = true
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
        
        // 점심시간 이벤트 서버통신
        getLunchEvent()
        
        animationView.removeFromSuperview()
        animationView = .init(name: "eventbox_open-4")
        let animationWidth: CGFloat = 400.adjustedWidth
        let animationHeight: CGFloat = 534.adjustedHeight
        animationView.frame = CGRect(x: 0, y: 0, width: animationWidth, height: animationHeight)
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1.0
        let centerX = view.bounds.midX
        let centerY = view.bounds.midY
        animationView.center = CGPoint(x: centerX, y: centerY)
        animationView.play(completion: { _ in
            self.showEventPointView()
        })
        view.addSubview(animationView)
    }
    
    private func showEventPointView() {
        animationView.removeFromSuperview()
        UserDefaults.standard.set(false, forKey: "lunchEventAvailable")
        
        self.eventPointView.frame = self.view.bounds
        self.eventPointView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(self.eventPointView)
        
        self.eventPointView.checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func checkButtonTapped() {
        self.eventPointView.removeFromSuperview()
        self.navigationController?.popViewController(animated: false)
        UserDefaults.standard.set(nil, forKey: "uuid.uuidString")
    }
    
    private func getLunchEvent() {
        NetworkService.shared.eventService.lunchEventStart(requestDTO: EventRequestDTO(tag: "LUNCH_EVENT")) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.getRewardPoint()
                }
            default:
                print("network failure")
                return
            }
        }
    }
    
    private func getRewardPoint() {
        NetworkService.shared.eventService.eventReward { result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                if data.rewardTag == "TICKET" {
                    self.eventPointView.pointLabel.text = StringLiterals.Event.ticket
                    self.eventPointView.pointImage.image = UIImage(imageLiteralResourceName: "imgTicket")
                } else {
                    self.eventPointView.pointLabel.text = String(data.rewardValue) + " " + StringLiterals.Event.point
                    self.eventPointView.pointImage.image = UIImage(imageLiteralResourceName: "imgPoint")
                }
                Amplitude.instance().logEvent("complete_lunch_event")
            default:
                print("network failure")
                return
            }
        }
    }
}
