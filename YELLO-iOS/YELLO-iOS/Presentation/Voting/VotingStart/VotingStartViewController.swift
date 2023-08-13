//
//  VotingStartViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/07.
//

import UIKit

import Lottie
import SnapKit
import Then

final class VotingStartViewController: BaseViewController {
    
    let originView = BaseVotingETCView()
    private var animationView = LottieAnimationView()
    var myPoint = 0
    
    override func loadView() {
        self.view = originView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originView.yellowButton.isEnabled = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        animationView = .init(name: "VotingStart")
//        let animationWidth: CGFloat = 230
//        let animationHeight: CGFloat = 230
//        animationView.frame = CGRect(x: 0, y: 0, width: animationWidth, height: animationHeight)
//
//        animationView.contentMode = .scaleAspectFit
//        animationView.loopMode = .loop
//        animationView.animationSpeed = 1.1
//
//        let centerX = view.bounds.midX
//        let centerY = view.bounds.midY - 40.adjusted
//
//        animationView.center = CGPoint(x: centerX, y: centerY)
//
//        animationView.play()
//        view.addSubview(animationView)
        
        getVotingAvailable()
        
        myPoint = UserDefaults.standard.integer(forKey: "UserPoint")
        originView.topOfMyPoint.setTextWithLineHeight(text: String(myPoint), lineHeight: 24)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
//        animationView.removeFromSuperview()
    }
    
    // MARK: - Style
    
    override func setStyle() {
        view.backgroundColor = .black
        
        originView.yellowButton.do {
            $0.setTitle("START!", for: .normal)
            $0.addTarget(self, action: #selector(yellowButtonClicked), for: .touchUpInside)
            $0.titleLabel?.font = .uiVotingLabel
            $0.makeCornerRound(radius: 30.adjusted)
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
        
        originView.topOfPointIcon.snp.makeConstraints {
            $0.centerY.equalTo(originView.topOfMyPoint)
            $0.trailing.equalTo(originView.topOfMyPoint.snp.leading).offset(-8.adjustedWidth)
        }
        
        originView.topOfMyPoint.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 24.adjustedHeight)
            $0.trailing.equalToSuperview().inset(16.adjusted)
        }
        
        originView.yellowButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabBarHeight + 80.adjustedHeight)
            $0.width.equalTo(198.adjusted)
            $0.height.equalTo(58.adjusted)
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
        let viewController = VotingViewController()
        viewController.votingList = loadVotingData() ?? []
        viewController.myPoint = UserDefaults.standard.integer(forKey: "UserPoint")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension VotingStartViewController {
    func getVotingAvailable() {
        NetworkService.shared.votingService.getVotingAvailable {
            result in
            switch result {
            case .success(let data):
                let status = data.status
                if status == 200 {
                    guard let data = data.data else { return }
                    if data.isPossible {
                        let point = data.point
                        self.originView.realMyPoint.setTextWithLineHeight(text: String(point), lineHeight: 22)
                        self.myPoint = point
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
                        for i in 0..<friendListCount {
                            friends.append(data.friendList[i].friendName + "\n@" + data.friendList[i].friendYelloId)
                            friendsID.append(data.friendList[i].friendId)
                        }
                        
                        var keywords = [String]()
                        let keywordListCount = min(data.keywordList.count, 4)
                        for i in 0..<keywordListCount {
                            keywords.append(data.keywordList[i])
                        }
                        
                        return VotingData(nameHead: data.question.nameHead ?? "", nameFoot: data.question.nameFoot ?? "", keywordHead: data.question.keywordHead ?? "", keywordFoot: data.question.keywordFoot ?? "", friendList: friends, keywordList: keywords, questionId: data.question.questionId, friendId: friendsID, questionPoint: data.questionPoint)
                    }
                    saveVotingData(votingList)
                    self.originView.yellowButton.isEnabled = true
            default:
                print("network failure")
                return
            }
        }
    }
}
