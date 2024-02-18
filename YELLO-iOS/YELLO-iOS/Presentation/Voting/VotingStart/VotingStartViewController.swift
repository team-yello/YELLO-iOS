//
//  VotingStartViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/07.
//

import UIKit

import Amplitude
import Lottie
import SnapKit
import Then

final class VotingStartViewController: BaseViewController {
    
    let originView = BaseVotingETCView()
    private var animationView = LottieAnimationView()
    var myPoint = "000"
    private let speechBubbleBackground = UIImageView()
    private let speechBubbleText = UILabel()
    let multiplyByTwoText = UILabel()
    let multiplyByTwoImageView = UIImageView()
    let multiplyByTwoStackView = UIStackView()
    private let buttonShadow = UIView()
    private let status = 1
        
    override func viewDidLoad() {
        super.viewDidLoad()
        originView.yellowButton.isEnabled = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Amplitude.instance().setUserProperties(["user_point": myPoint])
        setAnimationView()
        getVotingAvailable()
        myPoint = String(UserDefaults.standard.integer(forKey: "UserPoint"))
        originView.topOfMyPoint.setTextWithLineHeight(text: String(myPoint), lineHeight: 24)
        getSubscribe()
        UserDefaults.standard.set(status, forKey: "status")
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        animationView.removeFromSuperview()
    }
    
    // MARK: - Style
    
    override func setStyle() {
        view.backgroundColor = .black
        
        speechBubbleBackground.do {
            $0.image = ImageLiterals.Voting.lbSpeechBubble
            $0.isHidden = true // 특정조건에서 false로 바꿀 것임
        }
        
        speechBubbleText.do {
            $0.setTextWithLineHeight(text: "💛4명 이상의 친구💛를 가지면 옐로가 더 재밌어요!", lineHeight: 15)
            $0.textColor = .white
            $0.font = .uiLabelMedium
        }
        
        multiplyByTwoText.do {
            $0.text = "Point"
            $0.font = .uiPointLabel
            $0.textColor = .white
        }
        
        multiplyByTwoImageView.do {
            $0.image = ImageLiterals.Voting.imgMultiplyByTwo
        }
        
        multiplyByTwoStackView.do {
            $0.axis = .horizontal
            $0.addArrangedSubviews(multiplyByTwoText, multiplyByTwoImageView)
            $0.alignment = .center
            $0.spacing = 4.adjusted
            $0.isHidden = true
        }
        
        originView.yellowButton.do {
            $0.setTitle("START!", for: .normal)
            $0.addTarget(self, action: #selector(yellowButtonClicked), for: .touchUpInside)
            $0.titleLabel?.font = .uiTimeLabel
            $0.makeCornerRound(radius: 31.adjusted)
        }
        
        buttonShadow.do {
            $0.backgroundColor = UIColor(hex: "D1D412", alpha: 1)
            $0.makeCornerRound(radius: 33.adjusted)
        }
    }
    
    // MARK: - Layout
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        let width = UIScreen.main.bounds.size.width
        
        view.addSubviews(originView, multiplyByTwoStackView, speechBubbleBackground, buttonShadow)
        speechBubbleBackground.addSubview(speechBubbleText)

        originView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        originView.topOfPointIcon.snp.makeConstraints {
            $0.centerY.equalTo(originView.topOfMyPoint)
            $0.trailing.equalTo(originView.topOfMyPoint.snp.leading).offset(-8.adjustedWidth)
        }
        
        originView.topOfMyPoint.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 24.adjustedHeight)
            $0.trailing.equalToSuperview().inset(16.adjusted)
        }
        
        originView.balloonToday.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 66.adjustedHeight)
            $0.leading.equalToSuperview().inset(74.adjusted)
            $0.width.equalTo(92.adjusted)
            $0.height.equalTo(36.adjusted)
        }
        
        originView.balloonWho.snp.makeConstraints {
            $0.top.equalTo(originView.balloonToday.snp.bottom).offset(6.adjusted)
            $0.leading.equalToSuperview().inset(74.adjusted)
            $0.width.equalTo(228.adjusted)
            $0.height.equalTo(36.adjusted)
        }
        
        originView.balloonSend.snp.makeConstraints {
            $0.top.equalTo(originView.balloonWho.snp.bottom).offset(6.adjusted)
            $0.trailing.equalToSuperview().inset(73.adjusted)
            $0.width.equalTo(124.adjusted)
            $0.height.equalTo(36.adjusted)
        }
        
        speechBubbleBackground.snp.makeConstraints {
            $0.width.equalTo(238.adjusted)
            $0.height.equalTo(42.adjusted)
            $0.bottom.equalTo(originView.yellowButton.snp.top).offset(-10.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        speechBubbleText.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        originView.yellowButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabBarHeight + 45.adjustedHeight)
            $0.width.equalTo(315.adjusted)
            $0.height.equalTo(61.adjusted)
        }
        
        buttonShadow.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabBarHeight + 40.adjustedHeight)
            $0.width.equalTo(315.adjusted)
            $0.height.equalTo(66.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        multiplyByTwoImageView.snp.makeConstraints {
            $0.width.equalTo(33.adjusted)
            $0.height.equalTo(19.adjusted)
        }
        
        multiplyByTwoStackView.snp.makeConstraints {
            $0.bottom.equalTo(originView.yellowButton.snp.top).offset(-70.adjusted)
            $0.centerX.equalToSuperview()
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
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        let viewController = VotingViewController()
        viewController.votingList = loadVotingData() ?? []
        viewController.myPoint = UserDefaults.standard.integer(forKey: "UserPoint")
        Amplitude.instance().logEvent("click_vote_start")
        
        // 버튼의 높이 늘림
        self.originView.yellowButton.snp.updateConstraints {
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabBarHeight + 40.adjustedHeight)
            $0.height.equalTo(66.adjusted)
        }
        self.view.layoutIfNeeded()
        // 0.5초 후에 버튼의 높이를 다시 줄임
        UIView.animate(withDuration: 0.5, animations: {
            self.originView.yellowButton.snp.updateConstraints {
                $0.bottom.equalTo(self.view.safeAreaInsets.bottom).inset(tabBarHeight + 45.adjustedHeight)
                $0.height.equalTo(61.adjusted)
            }
            self.view.layoutIfNeeded()
        }) { _ in
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension VotingStartViewController {
    
    // MARK: - 서버통신
    
    func getVotingAvailable() {
        NetworkService.shared.votingService.getVotingAvailable {
            result in
            switch result {
            case .success(let data):
                let status = data.status
                if status == 200 {
                    guard let data = data.data else { return }
                    if data.isPossible {
                        if data.friendStatus == 0 {
                            self.speechBubbleBackground.isHidden = false
                        } else if data.friendStatus == 1 {
                            self.speechBubbleBackground.isHidden = true
                        }
                        let point = data.point
                        UserManager.shared.userPoint = data.point
                        self.originView.topOfMyPoint.setTextWithLineHeight(text: String(point), lineHeight: 24)
                        self.myPoint = String(point)
                        UserDefaults.standard.set(point, forKey: "UserPoint")
                        self.originView.yellowButton.isEnabled = false
                        self.getVotingList()
                    }
                }
                if status == 400 {
                    let viewController = VotingLockedViewController()
                    UIView.transition(with: self.navigationController?.view ?? UIView(), duration: 0.001, options: .transitionCrossDissolve, animations: {
                        // 전환 시 스르륵 바뀌는 애니메이션 적용
                        self.navigationController?.pushViewController(viewController, animated: false)
                    })
                }
            default:
                print("network failure")
                return
            }
        }
    }
    
    func getVotingList() {
        NetworkService.shared.votingService.getVotingList { result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                
                let votingList = data.map { data -> VotingData in
                    var friends = [String]()
                    var friendsID = [Int]()
                    
                    let friendListCount = min(data.friendList.count, 4)
                    
                    if friendListCount >= 1 || friendListCount <= 3 {
                        for i in 0..<friendListCount {
                            friends.append(data.friendList[i].friendName + "\n@" + data.friendList[i].friendYelloId)
                            friendsID.append(data.friendList[i].friendId)
                        }
                        for i in friendListCount..<4 {
                            friends.append("")
                            friendsID.append(-1)
                        }
                    }
                    
                    for i in 0..<friendListCount {
                        friends.append(data.friendList[i].friendName + "\n@" + data.friendList[i].friendYelloId)
                        friendsID.append(data.friendList[i].friendId)
                    }
                    
                    var keywords = [String]()
                    let keywordListCount = min(data.keywordList.count, 4)
                    for i in 0..<keywordListCount {
                        keywords.append(data.keywordList[i])
                    }
                    
                    return VotingData(nameHead: data.question.nameHead ?? "", nameFoot: data.question.nameFoot ?? "", keywordHead: data.question.keywordHead ?? "", keywordFoot: data.question.keywordFoot ?? "", friendList: friends, keywordList: keywords, questionId: data.question.questionId, friendId: friendsID, questionPoint: data.questionPoint, subscribe: data.subscribe)
                }
                saveVotingData(votingList)
                self.originView.yellowButton.isEnabled = true
            default:
                print("network failure")
                return
            }
        }
    }
    
    func getSubscribe() {
        NetworkService.shared.votingService.getVotingList { result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                let subscribeStatus = data[0].subscribe
                if subscribeStatus == "CANCELED" || subscribeStatus == "ACTIVE" {
                    self.multiplyByTwoStackView.isHidden = false
                } else {
                    self.multiplyByTwoStackView.isHidden = true
                }
            default:
                print("network failure")
                return
            }
        }
    }
    
    // MARK: - LottieAnimationView function
    
    func setAnimationView() {
        animationView = .init(name: "VotingStart")
        let animationWidth: CGFloat = 375.adjustedWidth
        let animationHeight: CGFloat = 667.adjustedHeight
        animationView.frame = CGRect(x: 0, y: 0, width: animationWidth, height: animationHeight)
        
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.1
        
        let centerX = view.bounds.midX
        let centerY = view.bounds.midY - 50.adjustedHeight
        
        animationView.center = CGPoint(x: centerX, y: centerY)
        
        animationView.play()
        view.addSubview(animationView)
        view.bringSubviewToFront(buttonShadow)
        view.bringSubviewToFront(originView)
        view.bringSubviewToFront(speechBubbleBackground)
        view.bringSubviewToFront(multiplyByTwoStackView)
    }
}
