//
//  VotingPointViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/08.
//

import UIKit

import SnapKit
import Then

final class VotingPointViewController: BaseViewController {

    private let originView = BaseVotingETCView()
    var myPoint = 0
    var votingPlusPoint = 0
    var votingAnswer: [VoteAnswerList] = []
    let userNotiCenter = UNUserNotificationCenter.current()
    
    override func loadView() {
        self.view = originView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        
        myPoint = UserDefaults.standard.integer(forKey: "UserPoint")
        votingPlusPoint = UserDefaults.standard.integer(forKey: "UserPlusPoint")
        
        originView.topOfMyPoint.text = String(myPoint + votingPlusPoint)
        originView.realMyPoint.setTextWithLineHeight(text: String(myPoint + votingPlusPoint), lineHeight: 22)
        originView.plusPoint.setTextWithLineHeight(text: "+ " + String(votingPlusPoint) + " Point", lineHeight: 22)
        originView.plusPoint.asColor(targetString: String(votingPlusPoint), color: .yelloMain500)
    }
    
    // MARK: - Style
    
    override func setStyle() {
        view.backgroundColor = .black
        
        originView.titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Point.title, lineHeight: 28)
        }
        
        originView.textLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Voting.Point.text, lineHeight: 20)
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
        let requestDTO = VotingAnswerListRequestDTO(voteAnswerList: loadedUserArray, totalPoint: votingPlusPoint)
        NetworkService.shared.votingService.postVotingAnswerList(requestDTO: requestDTO) { result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                dump(data)
            default:
                print("network failure")
                return
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let viewController = YELLOTabBarController()
            self.navigationController?.pushViewController(viewController, animated: true)
            self.originView.yellowButton.isEnabled = true
        }

        requestSendNoti(seconds: 2402)
        
        UserDefaults.standard.removeObject(forKey: "UserDataKey")
        UserDefaults.standard.removeObject(forKey: "UserPlusPoint")
    }
    
    // 푸시 알림 전송
    func requestSendNoti(seconds: Double) {
        let notiContent = UNMutableNotificationContent()
        notiContent.title = "친구에게 쪽지 보내고 포인트 받기"
        notiContent.body = "대기시간이 다 지났어요. 친구들에게 투표해봐요!"
        notiContent.userInfo = ["targetScene": "splash"] // 푸시 받을때 오는 데이터
        
        // 알림이 trigger되는 시간 설정
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: "myPushAlarm",
            content: notiContent,
            trigger: trigger
        )
        
        userNotiCenter.add(request) { (error) in
            print(#function, error)
        }
    }
}
