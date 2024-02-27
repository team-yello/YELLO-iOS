//
//  VotingPointViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/08.
//

import UIKit

import Amplitude
import GoogleMobileAds
import Lottie
import SnapKit
import Then

final class VotingPointViewController: BaseViewController {
    // MARK: - Variables
    // MARK: Constants
    let userNotiCenter = UNUserNotificationCenter.current()
    
    // MARK: Property
    var myPoint = 0
    var votingPlusPoint = 0
    var votingPlusPointToPost = 0
    var votingAnswer: [VoteAnswerList] = []
    private var rewardedAd: GADRewardedAd?
    var uuid = UUID().uuidString
    private var isWatchAd: Bool = false
    private var isYelloPlus: Bool = false
    
    // MARK: Component
    let originView = BaseVotingETCView()
    let multiplyByTwoImageView = UIImageView()
    let adButtonStackView = UIStackView()
    let cancelButton = UIButton()
    let rewardAdButton = UIButton()
    let loadingView = YelloLoadingView()
    
    override func loadView() {
        self.view = originView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserManager.shared.adUUID = uuid
        tabBarController?.tabBar.isHidden = true
        
        myPoint = UserDefaults.standard.integer(forKey: "UserPoint")
        votingPlusPoint = UserDefaults.standard.integer(forKey: "UserPlusPointNotPost")
        votingPlusPointToPost = UserDefaults.standard.integer(forKey: "UserPlusPoint")
        isWatchAd = UserDefaults.standard.bool(forKey: "isWatchAd")
        isYelloPlus = UserDefaults.standard.bool(forKey: "isYelloPlus")
        
        originView.topOfMyPoint.text = String(myPoint)
        originView.realMyPoint.setTextWithLineHeight(text: String(myPoint), lineHeight: 22)
        originView.plusPoint.setTextWithLineHeight(text: "+ " + String(votingPlusPoint) + " Point", lineHeight: 22)
        originView.plusPoint.asColor(targetString: String(votingPlusPoint), color: .yelloMain500)
        VotingViewController.pushCount = 0
        
        if isYelloPlus {
            multiplyByTwoImageView.isHidden = false
        } else {
            multiplyByTwoImageView.isHidden = true
        }
        
        if isWatchAd {
            adButtonStackView.isHidden = true
            originView.yellowButton.isHidden = false
        } else {
            adButtonStackView.isHidden = false
            originView.yellowButton.isHidden = true
        }
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
            $0.setTitle(StringLiterals.Voting.Point.yelloButtonText, for: .normal)
            $0.titleLabel?.font = .uiSubtitle04
            $0.addTarget(self, action: #selector(yellowButtonClicked), for: .touchUpInside)
            $0.makeCornerRound(radius: 23.adjusted)
        }
        
        cancelButton.do {
            $0.setTitle(StringLiterals.Voting.Point.cancelButtonText, for: .normal)
            $0.titleLabel?.font = .uiBody01
            $0.setTitleColor(.white, for: .normal)
            $0.addTarget(self, action: #selector(yellowButtonClicked), for: .touchUpInside)
        }
        
        rewardAdButton.do {
            $0.setTitle(StringLiterals.Voting.Point.rewardAdButtonText, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .uiBody01
            $0.backgroundColor = .yelloMain500
            $0.makeCornerRound(radius: 24.adjustedHeight)
            $0.addTarget(self, action: #selector(rewardAdsButtonClicked), for: .touchUpInside)
        }
        
        adButtonStackView.do {
            $0.axis = .horizontal
            $0.addArrangedSubviews(cancelButton, rewardAdButton)
            $0.spacing = 8.adjustedWidth
            $0.alignment = .center
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
        
        view.addSubviews(multiplyByTwoImageView, adButtonStackView, loadingView)
        
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
        
        cancelButton.snp.makeConstraints {
            $0.width.equalTo(150.adjustedWidth)
            $0.height.equalTo(48.adjustedHeight)
        }
        
        rewardAdButton.snp.makeConstraints {
            $0.width.equalTo(185.adjustedWidth)
            $0.height.equalTo(48.adjustedHeight)
        }
        
        adButtonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabBarHeight + 28.adjustedHeight)
        }
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func loadRewardedAd() {
        loadingView.showIndicator()
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID: Config.rewardAd,
                           request: request,
                           completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load rewarded ad with error: \(error.localizedDescription)")
                loadingView.stopIndicator()
                adButtonStackView.isHidden = true
                originView.yellowButton.isHidden = false
                return
            }
            
            rewardedAd = ad
            let options = GADServerSideVerificationOptions()
            options.customRewardString = uuid
            rewardedAd?.serverSideVerificationOptions = options
            rewardedAd?.fullScreenContentDelegate = self
            debugPrint("Rewarded ad loaded.")
            loadingView.stopIndicator()
            rewardAdButton.isEnabled = true
            cancelButton.isEnabled = true
            showAds()
        }
        )
    }
    
    func getReward() {
        let request = RewardRequestDTO(rewardType: StringLiterals.Reward.admobMultipleReward,
                                       randomType: StringLiterals.Reward.fix,
                                       uuid: uuid,
                                       rewardNumber: votingPlusPoint)
        
        NetworkService.shared.rewardService.postRewardAd(requestDTO: request) { result in
            switch result {
            case .success(let data):
                if data.status == 400 {
                    self.view.showToast(message: "알 수 없는 오류로 보상 받기에 실패했습니다.")
                    return
                }
                self.loadingView.stopIndicator()
                self.adButtonStackView.isHidden = true
                self.originView.yellowButton.isHidden = false
                if let data = data.data {
                    self.myPoint += self.votingPlusPoint
                    self.votingPlusPoint = self.votingPlusPoint * 2
                    self.updateUI()
                }
                UserDefaults.standard.set(true, forKey: "isWatchAd")
                UserDefaults.standard.set(self.myPoint, forKey: "UserPoint")
                UserDefaults.standard.set(self.votingPlusPoint, forKey: "UserPlusPointNotPost")
                
                debugPrint("광고 보상이 완료되었습니다.")
                
            default:
                debugPrint("보상형 광고 보상 실패")
            }
        }
    }
    
    func showAds() {
        if let ad = rewardedAd {
            ad.present(fromRootViewController: self) {
                let reward = ad.adReward
                debugPrint("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
            }
        } else {
            debugPrint("Ad wasn't ready")
        }
    }
    
    private func updateUI() {
        originView.topOfMyPoint.text = String(myPoint)
        originView.realMyPoint.setTextWithLineHeight(text: String(myPoint), lineHeight: 22)
        originView.plusPoint.setTextWithLineHeight(text: "+ " + String(votingPlusPoint) + " Point", lineHeight: 22)
        originView.plusPoint.asColor(targetString: String(votingPlusPoint), color: .yelloMain500)
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
        
        let viewController = YELLOTabBarController()
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        viewController.startStatus = 2
        viewController.notificationReadCount = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: viewController)
            self.originView.yellowButton.isEnabled = true
        }
        UserDefaults.standard.removeObject(forKey: "isWatchAd")
        UserDefaults.standard.removeObject(forKey: "UserDataKey")
        UserDefaults.standard.removeObject(forKey: "UserPlusPoint")
    }
    
    @objc
    func rewardAdsButtonClicked() {
        loadRewardedAd()
    }
}

extension VotingPointViewController: GADFullScreenContentDelegate {
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        getReward()
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        debugPrint("광고 로드 실패")
        loadingView.stopIndicator()
        adButtonStackView.isHidden = true
        originView.yellowButton.isHidden = false
    }
}
