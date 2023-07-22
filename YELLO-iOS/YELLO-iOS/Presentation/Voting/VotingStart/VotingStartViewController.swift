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
    private var votingList: [VotingData?] = []
    var myPoint = 0
    
    override func loadView() {
        self.view = originView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getPoint()
        getVotingList()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animationView = .init(name: "VotingStart")
        let animationWidth: CGFloat = 230
        let animationHeight: CGFloat = 230
        animationView.frame = CGRect(x: 0, y: 0, width: animationWidth, height: animationHeight)
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.1
        
        let centerX = view.bounds.midX
        let centerY = view.bounds.midY - 40.adjusted
            
        animationView.center = CGPoint(x: centerX, y: centerY)

        animationView.play()
        view.addSubview(animationView)
        
        tabBarController?.tabBar.isHidden = false
        
        getVotingAvailable()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        animationView.removeFromSuperview()
    }
    
    // MARK: - Style
    
    override func setStyle() {
        view.backgroundColor = .black
        
        originView.titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Start.title, lineHeight: 28)
        }
        
        originView.engPoint.do {
            $0.setTextWithLineHeight(text: "Point", lineHeight: 22)
        }
        
        originView.realMyPoint.do {
            $0.setTextWithLineHeight(text: "0", lineHeight: 22)
        }
        
        originView.yellowButton.do {
            $0.setTitle("투표 시작!", for: .normal)
            $0.addTarget(self, action: #selector(yellowButtonClicked), for: .touchUpInside)
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

        originView.titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 100.adjustedHeight)
        }
        
        originView.grayView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabBarHeight + 117.adjustedHeight)
            $0.width.equalTo(284.adjusted)
            $0.height.equalTo(52.adjusted)
        }
        
        originView.yellowButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabBarHeight + 28.adjustedHeight)
        }
        
    }
    
    // MARK: - Objc Function
    
    @objc
    func yellowButtonClicked() {
        let viewController = VotingViewController()
        viewController.votingList = votingList
        viewController.myPoint = myPoint
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension VotingStartViewController {
    func getPoint() {
        NetworkService.shared.votingService.getVotingAvailable {
            result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                let point = data.point
                self.originView.realMyPoint.setTextWithLineHeight(text: String(point), lineHeight: 22)
                self.myPoint = point
            default:
                print("network failure")
                return
            }
        }
    }
    
    func getVotingList() {
        originView.yellowButton.isEnabled = false
        NetworkService.shared.votingService.getVotingList { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                    guard let data = data.data else { return }
                    let votingList = data.map { data -> VotingData? in
                        var friends = [String]()
                        var friendsID = [Int]()
                        for i in 0...3 {
                            friends.append(data.friendList[i].name + "\n@" + data.friendList[i].yelloId)
                            friendsID.append(data.friendList[i].id)
                        }
                        var keywords = [String]()
                        for i in 0...3 {
                            keywords.append(data.keywordList[i])
                        }
                        return VotingData(nameHead: data.question.nameHead ?? "", nameFoot: data.question.nameFoot ?? "", keywordHead: data.question.keywordHead ?? "", keywordFoot: data.question.keywordFoot ?? "", friendList: friends, keywordList: keywords, questionId: data.question.questionId, friendId: friendsID, questionPoint: data.questionPoint)
                    }
                    self.votingList = votingList
                    self.originView.yellowButton.isEnabled = true
                }
            default:
                print("network failure")
                return
            }
        }
    }
    
    func getVotingAvailable() {
        NetworkService.shared.votingService.getVotingAvailable {
            result in
            print(result)
            switch result {
            case .success(let data):
                let status = data.status
                if status == 400 {
                    let viewController = VotingLockedViewController()
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            default:
                print("network failure")
                return
            }
        }
    }
}
