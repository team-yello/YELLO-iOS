//
//  VotingTimerViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/08.
//

import UIKit

import Amplitude
import SnapKit
import Then

final class VotingTimerViewController: BaseViewController {
    
    var timer: Timer?
    var myPoint = 0
    let userNotiCenter = UNUserNotificationCenter.current()
    
    var remainingSeconds: TimeInterval? {
        didSet {
            if let remainingSeconds {
                self.timerView.timeLabel.text = String(format: "%02d : %02d", Int(remainingSeconds/60), Int(remainingSeconds.truncatingRemainder(dividingBy: 60)))
            }
            if remainingSeconds == 0 {
                let viewController = VotingStartViewController()
                viewController.myPoint = myPoint
                UIView.transition(with: self.navigationController!.view, duration: 0.001, options: .transitionCrossDissolve, animations: {
                    // 전환 시 스르륵 바뀌는 애니메이션 적용
                    self.navigationController?.pushViewController(viewController, animated: false)
                })
            }
        }
    }
    
    private let originView = BaseVotingETCView()
    private var invitingView = InvitingView()
    
    let statusBarHeight = UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .first?
        .statusBarManager?
        .statusBarFrame.height ?? 20
    
    lazy var myView = UIView(frame: CGRect(x: 0, y: -statusBarHeight, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + statusBarHeight))
    let backgroundImage = ImageLiterals.Voting.imgTimerViewBackground
    
    // Timer 관련 컴포넌트
    private let timerBackGround = UIImageView()
    private let timerView = VotingTimerView()
    
    private let speechBubbleBackground = UIImageView()
    private let speechBubbleText = UILabel()
    
    override func loadView() {
        self.view = originView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPoint = UserDefaults.standard.integer(forKey: "UserPoint")
        originView.topOfMyPoint.setTextWithLineHeight(text: String(myPoint), lineHeight: 24)
        getCreatedAt()
    }
    
    deinit {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        getVotingAvailable()
    }
    
    // MARK: - Style
    
    override func setStyle() {
        
        myView.do {
            $0.backgroundColor = UIColor.black
            $0.setBackgroundImageWithScaling(image: backgroundImage)
        }
        
        originView.titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Timer.title, lineHeight: 28)
        }
        
        originView.textLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Timer.text, lineHeight: 20)
        }
        
        timerBackGround.do {
            $0.image = ImageLiterals.Voting.imgTimerBackground
        }
        
        speechBubbleBackground.do {
            $0.image = ImageLiterals.Voting.lbSpeechBubble
        }
        
        speechBubbleText.do {
            $0.setTextWithLineHeight(text: "🤩 친구가 가입하면 바로 투표할 수 있어요!", lineHeight: 15)
            $0.textColor = .white
            $0.font = .uiLabelMedium
        }
        
        originView.yellowButton.do {
            $0.setTitle("기다리지 않고 바로 투표하기", for: .normal)
            $0.titleLabel?.font = .uiSubtitle04
            $0.addTarget(self, action: #selector(yellowButtonClicked), for: .touchUpInside)
            $0.makeCornerRound(radius: 23.adjusted)
        }
    }
    
    // MARK: - Layout
    
    override func setLayout() {
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        let width = UIScreen.main.bounds.size.width
        
        originView.addSubview(myView)
        myView.addSubviews(originView.topOfPointIcon,
                           originView.topOfMyPoint,
                           originView.titleLabel,
                           originView.textLabel,
                           timerBackGround,
                           speechBubbleBackground,
                           originView.yellowButton,
                           originView.yelloFace)
        
        timerBackGround.addSubview(timerView)
        speechBubbleBackground.addSubview(speechBubbleText)
        
        originView.topOfPointIcon.snp.makeConstraints {
            $0.centerY.equalTo(originView.topOfMyPoint)
            $0.trailing.equalTo(originView.topOfMyPoint.snp.leading).offset(-8.adjusted)
        }
        
        originView.topOfMyPoint.snp.makeConstraints {
            $0.bottom.equalTo(originView.titleLabel.snp.top).offset(-29.adjustedHeight)
            $0.trailing.equalToSuperview().inset(16.adjusted)
        }
        
        originView.titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(originView.textLabel.snp.top).offset(-4.adjustedHeight)
        }
        
        originView.textLabel.snp.makeConstraints {
            $0.bottom.equalTo(timerBackGround.snp.top).offset(-52.adjustedHeight)
        }
        
        timerBackGround.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(250.adjusted)
        }
        
        timerView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        speechBubbleBackground.snp.makeConstraints {
            $0.width.equalTo(208.adjusted)
            $0.height.equalTo(42.adjusted)
            $0.bottom.equalTo(originView.yellowButton.snp.top).offset(-11.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        speechBubbleText.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        originView.yellowButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabBarHeight + 28.adjustedHeight)
            $0.height.equalTo(48.adjusted)
        }
        
        originView.yelloFace.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(width/2 - 19.5)
            $0.trailing.equalToSuperview().inset(width/2 - 19)
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabBarHeight - 32)
        }
        
    }
    
    // MARK: - Objc Function
    
    @objc
    func yellowButtonClicked() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }

        invitingView.removeFromSuperview()
        invitingView = InvitingView()
        invitingView.profileUserYelloId()
        invitingView.frame = viewController.view.bounds
        invitingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        invitingView.rootViewController = "VotingTimerViewController"
        Amplitude.instance().logEvent("click_invite", withEventProperties: ["invite_view": "timeline_0friend"])
        
        viewController.view.addSubview(invitingView)
    }
    
    // MARK: - Function
    
    private func start(duration: TimeInterval) {
        DispatchQueue.main.async {
            // timer
            self.timer?.invalidate()
            let startDate = Date()
            self.timer = Timer.scheduledTimer(
                withTimeInterval: 1,
                repeats: true,
                block: { [weak self] _ in
                    
                    let elapsedSeconds = round(abs(startDate.timeIntervalSinceNow))
                    let remainingSeconds = max(duration - elapsedSeconds, 0)
                    guard remainingSeconds > 0 else {
                        self?.stop()
                        return
                    }
                    self?.remainingSeconds = remainingSeconds
                    self?.animateProgress(to: Float(remainingSeconds / 2400))
                }
            )
        }
        
    }
    
    private func stop() {
        self.timer?.invalidate()
        self.remainingSeconds = 0
        self.timerView.progressLayer.removeFromSuperlayer()
    }
    
    private func animateProgress(to value: Float) {
        self.timerView.progressLayer.removeAnimation(forKey: "progressAnimation")
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = 1
        circularProgressAnimation.fromValue = self.timerView.progressLayer.presentation()?.strokeEnd ?? 1.0
        circularProgressAnimation.toValue = value
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        self.timerView.progressLayer.add(circularProgressAnimation, forKey: "progressAnimation")
        
    }
}

extension VotingTimerViewController {
    func getCreatedAt() {
        NetworkService.shared.votingService.getVotingAvailable {
            result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                self.originView.topOfMyPoint.text = String(data.point)
                
                let currentDate = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let currentDateString = dateFormatter.string(from: currentDate)
                
                guard let date = dateFormatter.date(from: currentDateString) else { return }
                let secondsSince1970 = date.timeIntervalSince1970
                
                guard let afterDate = dateFormatter.date(from: data.createdAt) else { return }
                let afterSecondsSince1970 = afterDate.timeIntervalSince1970 + 2400
                
                var duration = afterSecondsSince1970 - secondsSince1970
                
                if duration < 0 {
                    duration = 0
                }
                
                if data.isPossible {
                    let viewController = VotingStartViewController()
                    viewController.myPoint = self.myPoint
                    UIView.transition(with: self.navigationController?.view ?? UIView(), duration: 0.001, options: .transitionCrossDissolve, animations: {
                        // 전환 시 스르륵 바뀌는 애니메이션 적용
                        self.navigationController?.pushViewController(viewController, animated: false)
                    })
                }
                self.remainingSeconds = duration
                self.start(duration: duration)
                
            default:
                print("network failure")
                return
            }
        }
    }
    
    func getVotingAvailable() {
        NetworkService.shared.votingService.getVotingAvailable {
            result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                if data.isPossible {
                    let viewController = VotingStartViewController()
                    viewController.myPoint = data.point
                    UIView.transition(with: self.navigationController?.view ?? UIView(), duration: 0.001, options: .transitionCrossDissolve, animations: {
                        // 전환 시 스르륵 바뀌는 애니메이션 적용
                        self.navigationController?.pushViewController(viewController, animated: false)
                    })
                }
                self.myPoint = data.point
            default:
                print("network failure")
                return
            }
        }
    }
}
