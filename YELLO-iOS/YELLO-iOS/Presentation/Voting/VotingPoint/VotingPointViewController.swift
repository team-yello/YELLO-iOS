//
//  VotingPointViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/08.
//

import UIKit

import Amplitude
import SnapKit
import Then

final class VotingPointViewController: BaseViewController {

    let originView = BaseVotingETCView()
    let multiplyByTwoImageView = UIImageView()
    var myPoint = 0
    var votingPlusPoint = 0
    var votingPlusPointToPost = 0
    var votingAnswer: [VoteAnswerList] = []
    let userNotiCenter = UNUserNotificationCenter.current()
    
    override func loadView() {
        self.view = originView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        
        myPoint = UserDefaults.standard.integer(forKey: "UserPoint")
        votingPlusPoint = UserDefaults.standard.integer(forKey: "UserPlusPointNotPost")
        votingPlusPointToPost = UserDefaults.standard.integer(forKey: "UserPlusPoint")
        
        originView.topOfMyPoint.text = String(myPoint)
        originView.realMyPoint.setTextWithLineHeight(text: String(myPoint), lineHeight: 22)
        originView.plusPoint.setTextWithLineHeight(text: "+ " + String(votingPlusPoint) + " Point", lineHeight: 22)
        originView.plusPoint.asColor(targetString: String(votingPlusPoint), color: .yelloMain500)
    }
    
    // MARK: - Style
    
    override func setStyle() {
        view.backgroundColor = .black
        
        originView.titleLabel.do {
            $0.text = StringLiterals.Voting.Point.title
        }
        
        originView.textLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Point.text, lineHeight: 20)
        }
        
        multiplyByTwoImageView.do {
            $0.image = ImageLiterals.Voting.imgMultiplyByTwo
        }
        
        originView.yelloImage.do {
            $0.image = ImageLiterals.Voting.imgPointAccumulate
        }
        
        originView.engPoint.do {
            $0.setTextWithLineHeight(text: "Point", lineHeight: 22)
        }
        
        originView.yellowButton.do {
            $0.setTitle("확인", for: .normal)
            $0.titleLabel?.font = .uiSubtitle04
            $0.addTarget(self, action: #selector(yellowButtonClicked), for: .touchUpInside)
            $0.makeCornerRound(radius: 23.adjusted)
        }
    }
    
    // MARK: - Layout
    
    override func setLayout() {
        
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 60
        
        view.addSubview(multiplyByTwoImageView)
        
        originView.topOfPointIcon.snp.makeConstraints {
            $0.centerY.equalTo(originView.topOfMyPoint)
            $0.trailing.equalTo(originView.topOfMyPoint.snp.leading).offset(-8.adjustedWidth)
        }
        
        originView.topOfMyPoint.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 47.adjustedHeight)
            $0.trailing.equalToSuperview().inset(16.adjusted)
        }
                        
        originView.titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 100.adjustedHeight)
        }
        
        originView.textLabel.snp.makeConstraints {
            $0.top.equalTo(originView.titleLabel.snp.bottom).offset(4.adjustedHeight)
        }
        
        multiplyByTwoImageView.snp.makeConstraints {
            $0.bottom.equalTo(originView.plusPoint.snp.bottom).offset(-14.adjustedHeight)
            $0.trailing.equalTo(originView.plusPoint.snp.trailing).offset(25.adjustedHeight)
            $0.width.equalTo(33.adjusted)
            $0.height.equalTo(19.adjusted)
        }
        
        originView.plusPoint.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 198.adjustedHeight)
        }
        
        originView.yelloImage.snp.makeConstraints {
            $0.width.equalTo(240.adjusted)
            $0.height.equalTo(160.adjusted)
            $0.center.equalToSuperview()
        }
        
        originView.grayView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabBarHeight + 105.adjustedHeight)
            $0.width.equalTo(284.adjusted)
            $0.height.equalTo(60.adjusted)
        }
        
        originView.yellowButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabBarHeight + 28.adjustedHeight)
            $0.height.equalTo(48.adjusted)
        }
    }
    
    // MARK: - Objc Function

    @objc
    func yellowButtonClicked() {
        originView.yellowButton.isEnabled = false
        guard let loadedUserArray = loadUserData() else { return }
        let requestDTO = VotingAnswerListRequestDTO(voteAnswerList: loadedUserArray, totalPoint: votingPlusPointToPost)
        NetworkService.shared.votingService.postVotingAnswerList(requestDTO: requestDTO) { result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                dump(data)
                Amplitude.instance().logEvent("click_vote_finish")
            default:
                print("network failure")
                return
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let viewController = YELLOTabBarController()
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            viewController.startStatus = 2
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: viewController)
            self.originView.yellowButton.isEnabled = true
        }
        
        UserDefaults.standard.removeObject(forKey: "UserDataKey")
        UserDefaults.standard.removeObject(forKey: "UserPlusPoint")
    }
    
}
