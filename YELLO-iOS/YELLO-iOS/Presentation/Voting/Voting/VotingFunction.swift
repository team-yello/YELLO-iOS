//
//  Voting.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/11.
//

import UIKit

import Amplitude
import SnapKit
import Then

extension VotingViewController {
    /// 8개 투표지의 style을 dummy에 따라 설정
    func setVotingView() {
        let dummy = VotingDummy.dummy()
        let gradientView = UIView(frame: view.bounds)
        gradientView.applyGradientBackground(
            topColor: UIColor(hex: Color.shared.selectedTopColors?[VotingViewController.pushCount] ?? ""),
            bottomColor: UIColor(hex: Color.shared.selectedBottomColors?[VotingViewController.pushCount] ?? ""))
        view.insertSubview(gradientView, at: 0)
        
        let progressPercent = Float(VotingViewController.pushCount + 1) / 8.0
        self.originView.progressView.setProgress(progressPercent, animated: true)
        setAnimationView()
        self.originView.yelloProgress.image =
        dummy[VotingViewController.pushCount].yelloProgress
        
        setNameText(
            first: votingList[VotingViewController.pushCount].friendList[0],
            second: votingList[VotingViewController.pushCount].friendList[1],
            third: votingList[VotingViewController.pushCount].friendList[2],
            fourth: votingList[VotingViewController.pushCount].friendList[3]
        )
        
        originView.keywordOneButton.setTitle(votingList[VotingViewController.pushCount].keywordList[0], for: .normal)
        originView.keywordTwoButton.setTitle(votingList[VotingViewController.pushCount].keywordList[1], for: .normal)
        originView.keywordThreeButton.setTitle(votingList[VotingViewController.pushCount].keywordList[2], for: .normal)
        originView.keywordFourButton.setTitle(votingList[VotingViewController.pushCount].keywordList[3], for: .normal)
        
        nameHead.text = votingList[VotingViewController.pushCount].nameHead
        nameFoot.text = votingList[VotingViewController.pushCount].nameFoot
        keywordHead.text = votingList[VotingViewController.pushCount].keywordHead
        keywordFoot.text = votingList[VotingViewController.pushCount].keywordFoot
        
    }
    
    func setNameText(first: String, second: String, third: String, fourth: String) {
        let firstLineFont = UIFont.uiBodyMedium
        let firstLineColor = UIColor.white
        let secondLineFont = UIFont.uiLabelSmall
        let secondLineColor = UIColor.grayscales600
        
        nameTextOne.removeFromSuperview()
        nameTextOne = UILabel.createTwoLineLabel(text: first,
                                                 firstLineFont: firstLineFont,
                                                 firstLineColor: firstLineColor,
                                                 secondLineFont: secondLineFont,
                                                 secondLineColor: secondLineColor)
        
        nameTextTwo.removeFromSuperview()
        if second.isEmpty {
            nameTextTwo.do {
                $0.text = StringLiterals.Voting.Vote.plusFriend
                $0.textColor = .grayscales600
                $0.font = .uiBody02
            }
            originView.nameTwoButton.isEnabled = false
            // 투명한 버튼 추가
            let overlayTwoButton = UIButton(frame: originView.nameTwoButton.frame)
            overlayTwoButton.addTarget(self, action: #selector(showToast), for: .touchUpInside)
            overlayTwoButton.backgroundColor = .clear
            view.addSubview(overlayTwoButton)
            overlayTwoButton.snp.makeConstraints {
                $0.edges.equalTo(originView.nameTwoButton)
            }
        } else {
            nameTextTwo = UILabel.createTwoLineLabel(text: second,
                                                     firstLineFont: firstLineFont,
                                                     firstLineColor: firstLineColor,
                                                     secondLineFont: secondLineFont,
                                                     secondLineColor: secondLineColor)
        }
        
        nameTextThree.removeFromSuperview()
        if third.isEmpty {
            nameTextThree.do {
                $0.text = StringLiterals.Voting.Vote.plusFriend
                $0.textColor = .grayscales600
                $0.font = .uiBody02
            }
            originView.nameThreeButton.isEnabled = false
            // 투명한 버튼 추가
            let overlayThreeButton = UIButton(frame: originView.nameThreeButton.frame)
            overlayThreeButton.addTarget(self, action: #selector(showToast), for: .touchUpInside)
            overlayThreeButton.backgroundColor = .clear
            view.addSubview(overlayThreeButton)
            overlayThreeButton.snp.makeConstraints {
                $0.edges.equalTo(originView.nameThreeButton)
            }
        } else {
            nameTextThree = UILabel.createTwoLineLabel(text: third,
                                                       firstLineFont: firstLineFont,
                                                       firstLineColor: firstLineColor,
                                                       secondLineFont: secondLineFont,
                                                       secondLineColor: secondLineColor)
        }
        
        nameTextFour.removeFromSuperview()
        if fourth.isEmpty {
            nameTextFour.do {
                $0.text = StringLiterals.Voting.Vote.plusFriend
                $0.textColor = .grayscales600
                $0.font = .uiBody02
            }
            originView.nameFourButton.isEnabled = false
            // 투명한 버튼 추가
            let overlayFourButton = UIButton(frame: originView.nameFourButton.frame)
            overlayFourButton.addTarget(self, action: #selector(showToast), for: .touchUpInside)
            overlayFourButton.backgroundColor = .clear
            view.addSubview(overlayFourButton)
            overlayFourButton.snp.makeConstraints {
                $0.edges.equalTo(originView.nameFourButton)
            }
        } else {
            nameTextFour = UILabel.createTwoLineLabel(text: fourth,
                                                      firstLineFont: firstLineFont,
                                                      firstLineColor: firstLineColor,
                                                      secondLineFont: secondLineFont,
                                                      secondLineColor: secondLineColor)
        }
        
        originView.nameOneButton.addSubview(nameTextOne)
        originView.nameTwoButton.addSubview(nameTextTwo)
        originView.nameThreeButton.addSubview(nameTextThree)
        originView.nameFourButton.addSubview(nameTextFour)
        
        nameTextOne.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        nameTextTwo.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        nameTextThree.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        nameTextFour.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    /// 다음 뷰컨을 지정하는 함수
    func setNextViewController() {
        // 투표 끝나면 포인트뷰컨으로 push
        if VotingViewController.pushCount > 6 {
            VotingViewController.pushCount = 0
            
            let identify = AMPIdentify()
                .add("user_instagram", value: NSNumber(value: votingAnswer.count))
                .add("user_message_cycle", value: NSNumber(value: 1))
            guard let identify = identify else {return}
            Amplitude.instance().identify(identify)
            
            let viewController = VotingPointViewController()
            let myPlusPoint = UserDefaults.standard.integer(forKey: "UserPlusPoint")
            viewController.myPoint = myPoint + myPlusPoint
            viewController.votingPlusPoint = myPlusPoint
            let previousData = loadUserData() ?? []
            let combinedData = previousData + votingAnswer
            saveUserData(combinedData)
            
            let status = votingList[0].subscribe
            if status == "CANCELED" || status == "ACTIVE" {
                viewController.multiplyByTwoImageView.isHidden = false
                viewController.myPoint += myPlusPoint
                viewController.votingPlusPoint *= 2
            } else {
                viewController.multiplyByTwoImageView.isHidden = true
            }
            
            UserDefaults.standard.set(viewController.myPoint, forKey: "UserPoint")
            UserDefaults.standard.set(viewController.votingPlusPoint, forKey: "UserPlusPointNotPost")
            
            UIView.transition(with: self.navigationController?.view ?? UIView(), duration: 0.001, options: .transitionCrossDissolve, animations: {
                self.navigationController?.pushViewController(viewController, animated: false)
            })
        } else {
            let viewController = VotingViewController()
            viewController.votingList = votingList
            let previousData = loadUserData() ?? []
            let combinedData = previousData + votingAnswer
            saveUserData(combinedData)
            print(combinedData)
            
            UIView.transition(with: self.navigationController?.view ?? UIView(), duration: 0.5, options: .transitionCrossDissolve, animations: {
                // 전환 시 스르륵 바뀌는 애니메이션 적용
                VotingViewController.pushCount += 1
                self.navigationController?.pushViewController(viewController, animated: false)
            })
        }
    }
    
    // MARK: - LottieAnimationView function
    
    func setAnimationView() {
        let dummy = VotingDummy.dummy()
        originView.yelloBalloon = .init(name: dummy[VotingViewController.pushCount].yelloBalloon)
        let animationWidth: CGFloat = 72.adjustedWidth
        let animationHeight: CGFloat = 36.adjustedHeight
        originView.yelloBalloon.frame = CGRect(x: 0, y: 0, width: animationWidth, height: animationHeight)

        originView.yelloBalloon.contentMode = .scaleAspectFit
        originView.yelloBalloon.loopMode = .loop
        originView.yelloBalloon.animationSpeed = 1.1
        originView.yelloBalloon.play()
        
        view.addSubview(originView.yelloBalloon)
        originView.yelloBalloon.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(originView.yelloProgress.snp.top).offset(-8.adjustedHeight)
        }
        view.bringSubviewToFront(originView.yelloBalloon)
    }
}

// MARK: - UINavigationControllerDelegate

extension VotingViewController: UINavigationControllerDelegate {
    /// 뷰 컨트롤러가 푸시될 때마다 호출
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        if VotingViewController.pushCount < 8 {
            setVotingView()
        }
        
        let images = [nil, ImageLiterals.Voting.imgProgress1, ImageLiterals.Voting.imgProgress2, ImageLiterals.Voting.imgProgress3, ImageLiterals.Voting.imgProgress4, ImageLiterals.Voting.imgProgress5, ImageLiterals.Voting.imgProgress6, ImageLiterals.Voting.imgProgress7, ImageLiterals.Voting.imgProgress8]

        let imageViews = [self.originView.yelloProgressBackGroundOne, self.originView.yelloProgressBackGroundTwo, self.originView.yelloProgressBackGroundThree, self.originView.yelloProgressBackGroundFour]

        let progressBackGroundsImages = [
            [nil, nil, 1, 2],
            [nil, 1, 3, 4],
            [1, 2, 4, 5],
            [2, 3, 5, 6],
            [3, 4, 6, 7],
            [4, 5, 7, 8],
            [5, 6, 8, nil],
            [6, 7, nil, nil]
        ]

        if VotingViewController.pushCount < progressBackGroundsImages.count {
            let imageIndexes = progressBackGroundsImages[VotingViewController.pushCount]

            for (index, imageView) in imageViews.enumerated() {
                if let imageIndex = imageIndexes[index] {
                    imageView.image = images[imageIndex]
                } else {
                    imageView.image = nil
                }
            }
        } else {
            for imageView in imageViews {
                imageView.image = nil
            }
        }
    }
}

// MARK: - Objc Function

extension VotingViewController {
    @objc
    func nameButtonClicked(_ sender: UIButton) {
        if nameButtonClick {
            view.showToast(message: StringLiterals.Voting.VoteToast.cancel)
        }
        if nameButtonTouch == true {
            return
        }
        nameButtonTouch = true

        let nameButtons = [originView.nameOneButton, originView.nameTwoButton, originView.nameThreeButton, originView.nameFourButton]
        
        let nameTexts = [nameTextOne, nameTextTwo, nameTextThree, nameTextFour]
        
        if sender == originView.nameOneButton {
            friendID = votingList[VotingViewController.pushCount].friendId[0]
        } else if sender == originView.nameTwoButton {
            friendID = votingList[VotingViewController.pushCount].friendId[1]
        } else if sender == originView.nameThreeButton {
            friendID = votingList[VotingViewController.pushCount].friendId[2]
        } else {
            friendID = votingList[VotingViewController.pushCount].friendId[3]
        }
        
        for (index, button) in nameButtons.enumerated() {
            button.isEnabled = (button == sender)
            
            if button.isEnabled {
                let selectedText = nameTexts[index]
                selectedText.updateLabelAppearance()
                nameMiddleText.text = selectedText.text
            } else {
                let unselectedText = nameTexts[index]
                unselectedText.textColor = .grayscales700
            }
        }
        
        view.addSubview(nameMiddleText)
        nameMiddleText.snp.makeConstraints {
            $0.center.equalTo(nameMiddleBackground)
        }
        
        nameButtonClick = true
        nameButtonTouch = false
    }
    
    @objc
    func keywordClicked(_ sender: UIButton) {
        if keywordButtonClick {
            view.showToast(message: StringLiterals.Voting.VoteToast.cancel)
        }
        if keywordButtonTouch == true {
            return
        }
        keywordButtonTouch = true
        
        sender.setTitleColor(.yelloMain500, for: .normal)
        keywordMiddleText.text = sender.titleLabel?.text

        let keywordButtons = [originView.keywordOneButton, originView.keywordTwoButton, originView.keywordThreeButton, originView.keywordFourButton]

        if sender == originView.keywordOneButton {
            keyword = votingList[VotingViewController.pushCount].keywordList[0]
        } else if sender == originView.keywordTwoButton {
            keyword = votingList[VotingViewController.pushCount].keywordList[1]
        } else if sender == originView.keywordThreeButton {
            keyword = votingList[VotingViewController.pushCount].keywordList[2]
        } else {
            keyword = votingList[VotingViewController.pushCount].keywordList[3]
        }
        
        for button in keywordButtons {
            button.isEnabled = (button == sender)
            if sender != button {
                button.setTitleColor(.grayscales700, for: .normal)
            }
        }
        
        view.addSubview(keywordMiddleText)
        keywordMiddleText.snp.makeConstraints {
            $0.center.equalTo(keywordMiddleBackground)
        }
        
        keywordButtonClick = true
        keywordButtonTouch = false
        let identify = AMPIdentify()
            .add("user_message_sent", value: NSNumber(value: 1))
        guard let identify = identify else {return}
        Amplitude.instance().identify(identify)
    }
    
    @objc
    func suffleButtonClicked() {
        if nameButtonClick {
            originView.suffleButton.isEnabled = false
            originView.suffleButton.isEnabled = true
            view.showToast(message: StringLiterals.Voting.VoteToast.suffle)
        } else {
            suffleCount += 1
            let questionId = votingList[VotingViewController.pushCount].questionId
            Amplitude.instance().logEvent("click_vote_shuffle", withEventProperties: ["question_id": questionId, "count_shuffle":"shuffle\(suffleCount)"])
        }
    }
    
    @objc
    func skipButtonClicked() {
        if keywordButtonClick {
            originView.skipButton.isEnabled = false
            originView.skipButton.isEnabled = true
            view.showToast(message: StringLiterals.Voting.VoteToast.skip)
        } else {
            let identify = AMPIdentify()
                .add("user_vote_skip", value: NSNumber(value: 1))
            guard let identify = identify else {return}
            Amplitude.instance().identify(identify)
            let questionId = votingList[VotingViewController.pushCount].questionId
            Amplitude.instance().logEvent("click_vote_skip", withEventProperties: ["question_id": questionId])
            setNextViewController()
        }
    }
    
    @objc
    func showToast() {
        view.showToast(message: StringLiterals.Voting.VoteToast.moreFriend)
    }
}
