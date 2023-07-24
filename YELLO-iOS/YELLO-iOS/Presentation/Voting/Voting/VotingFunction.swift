//
//  Voting.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/11.
//

import UIKit

import SnapKit
import Then

extension VotingViewController {
    /// 10개 투표지의 style을 dummy에 따라 설정
    func setVotingView() {
        let dummy = VotingDummy.dummy()
        let gradientView = UIView(frame: view.bounds)
        gradientView.applyGradientBackground(
            topColor: UIColor(hex: Color.shared.selectedTopColors[VotingViewController.pushCount]),
            bottomColor: UIColor(hex: Color.shared.selectedBottomColors[VotingViewController.pushCount]))
        view.insertSubview(gradientView, at: 0)
        
        self.originView.yelloBalloon.image = dummy[VotingViewController.pushCount].yelloBalloon
        self.originView.yelloProgress.image =
        dummy[VotingViewController.pushCount].yelloProgress
        self.originView.numOfPageLabel.text = String(VotingViewController.pushCount + 1)
        
        setNameText(
            first: votingList[VotingViewController.pushCount]?.friendList[0] ?? "",
            second: votingList[VotingViewController.pushCount]?.friendList[1] ?? "",
            third: votingList[VotingViewController.pushCount]?.friendList[2] ?? "",
            fourth: votingList[VotingViewController.pushCount]?.friendList[3] ?? ""
        )
        
        originView.keywordOneButton.setTitle(votingList[VotingViewController.pushCount]?.keywordList[0] ?? "", for: .normal)
        originView.keywordTwoButton.setTitle(votingList[VotingViewController.pushCount]?.keywordList[1] ?? "", for: .normal)
        originView.keywordThreeButton.setTitle(votingList[VotingViewController.pushCount]?.keywordList[2] ?? "", for: .normal)
        originView.keywordFourButton.setTitle(votingList[VotingViewController.pushCount]?.keywordList[3] ?? "", for: .normal)
        
        nameHead.text = votingList[VotingViewController.pushCount]?.nameHead
        nameFoot.text = votingList[VotingViewController.pushCount]?.nameFoot
        keywordHead.text = votingList[VotingViewController.pushCount]?.keywordHead
        keywordFoot.text = votingList[VotingViewController.pushCount]?.keywordFoot
        
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
        nameTextTwo = UILabel.createTwoLineLabel(text: second,
                                                 firstLineFont: firstLineFont,
                                                 firstLineColor: firstLineColor,
                                                 secondLineFont: secondLineFont,
                                                 secondLineColor: secondLineColor)
        
        nameTextThree.removeFromSuperview()
        nameTextThree = UILabel.createTwoLineLabel(text: third,
                                                   firstLineFont: firstLineFont,
                                                   firstLineColor: firstLineColor,
                                                   secondLineFont: secondLineFont,
                                                   secondLineColor: secondLineColor)
    
        nameTextFour.removeFromSuperview()
        nameTextFour = UILabel.createTwoLineLabel(text: fourth,
                                                  firstLineFont: firstLineFont,
                                                  firstLineColor: firstLineColor,
                                                  secondLineFont: secondLineFont,
                                                  secondLineColor: secondLineColor)
        
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
        // pushCount가 10 이상이면 투표 끝난 것이므로 포인트뷰컨으로 push
        if VotingViewController.pushCount >= 10 {
            let viewController = VotingPointViewController()
            viewController.votingAnswer = votingAnswer
            saveUserData(votingAnswer)
            viewController.myPoint = myPoint
            viewController.votingPlusPoint = votingPlusPoint
            self.navigationController?.pushViewController(viewController, animated: false)
        } else {
            let viewController = VotingViewController()
            viewController.votingList = votingList
            viewController.votingAnswer = votingAnswer
            saveUserData(votingAnswer)
            viewController.myPoint = myPoint
            viewController.votingPlusPoint = votingPlusPoint
            UIView.transition(with: self.navigationController!.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                // 전환 시 스르륵 바뀌는 애니메이션 적용
                self.navigationController?.pushViewController(viewController, animated: false)
            })
        }
    }
}

// MARK: - UINavigationControllerDelegate

extension VotingViewController: UINavigationControllerDelegate {
    /// 뷰 컨트롤러가 푸시될 때마다 호출
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        if VotingViewController.pushCount < 10 {
            setVotingView()
        }
        
        let images = [nil, ImageLiterals.Voting.imgProgress1, ImageLiterals.Voting.imgProgress2, ImageLiterals.Voting.imgProgress3, ImageLiterals.Voting.imgProgress4, ImageLiterals.Voting.imgProgress5, ImageLiterals.Voting.imgProgress6, ImageLiterals.Voting.imgProgress7, ImageLiterals.Voting.imgProgress8, ImageLiterals.Voting.imgProgress9, ImageLiterals.Voting.imgProgress10]

        let imageViews = [self.originView.yelloProgressBackGroundOne, self.originView.yelloProgressBackGroundTwo, self.originView.yelloProgressBackGroundThree, self.originView.yelloProgressBackGroundFour]

        let progressBackGroundsImages = [
            [nil, nil, 1, 2],
            [nil, 1, 3, 4],
            [1, 2, 4, 5],
            [2, 3, 5, 6],
            [3, 4, 6, 7],
            [4, 5, 7, 8],
            [5, 6, 8, 9],
            [6, 7, 9, 10],
            [7, 8, 10, nil],
            [8, 9, nil, nil]
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

        // 현재 뷰 컨트롤러가 자기 자신인 경우에만 pushCount를 증가
        if viewController == self {
            VotingViewController.pushCount += 1
        } else {
            // 다른 뷰 컨트롤러로 이동하는 경우 pushCount를 초기화
            VotingViewController.pushCount = 0
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
            friendID = votingList[VotingViewController.pushCount - 1]?.friendId[0] ?? 0
        } else if sender == originView.nameTwoButton {
            friendID = votingList[VotingViewController.pushCount - 1]?.friendId[1] ?? 0
        } else if sender == originView.nameThreeButton {
            friendID = votingList[VotingViewController.pushCount - 1]?.friendId[2] ?? 0
        } else {
            friendID = votingList[VotingViewController.pushCount - 1]?.friendId[3] ?? 0
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
            keyword = votingList[VotingViewController.pushCount - 1]?.keywordList[0] ?? ""
        } else if sender == originView.keywordTwoButton {
            keyword = votingList[VotingViewController.pushCount - 1]?.keywordList[1] ?? ""
        } else if sender == originView.keywordThreeButton {
            keyword = votingList[VotingViewController.pushCount - 1]?.keywordList[2] ?? ""
        } else {
            keyword = votingList[VotingViewController.pushCount - 1]?.keywordList[3] ?? ""
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
    }
    
    @objc
    func suffleButtonClicked() {
        if nameButtonClick {
            originView.suffleButton.isEnabled = false
            originView.suffleButton.isEnabled = true
            view.showToast(message: StringLiterals.Voting.VoteToast.suffle)
        } else {
            suffleCount += 1
        }
    }
    
    @objc
    func skipButtonClicked() {
        if eitherButtonClicked {
            originView.skipButton.isEnabled = false
            originView.skipButton.isEnabled = true
            view.showToast(message: StringLiterals.Voting.VoteToast.skip)
        } else {
            setNextViewController()
        }
    }
}
