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
            UIView.transition(with: self.navigationController!.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
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
        
        switch VotingViewController.pushCount {
        case 0:
            self.originView.yelloProgressBackGroundOne.image = nil
            self.originView.yelloProgressBackGroundTwo.image = nil
            self.originView.yelloProgressBackGroundThree.image = ImageLiterals.Voting.imgProgress1
            self.originView.yelloProgressBackGroundFour.image = ImageLiterals.Voting.imgProgress2
        case 1:
            self.originView.yelloProgressBackGroundOne.image = nil
            self.originView.yelloProgressBackGroundTwo.image = ImageLiterals.Voting.imgProgress1
            self.originView.yelloProgressBackGroundThree.image = ImageLiterals.Voting.imgProgress3
            self.originView.yelloProgressBackGroundFour.image = ImageLiterals.Voting.imgProgress4
        case 2:
            self.originView.yelloProgressBackGroundOne.image = ImageLiterals.Voting.imgProgress1
            self.originView.yelloProgressBackGroundTwo.image = ImageLiterals.Voting.imgProgress2
            self.originView.yelloProgressBackGroundThree.image = ImageLiterals.Voting.imgProgress4
            self.originView.yelloProgressBackGroundFour.image = ImageLiterals.Voting.imgProgress5
        case 3:
            self.originView.yelloProgressBackGroundOne.image = ImageLiterals.Voting.imgProgress2
            self.originView.yelloProgressBackGroundTwo.image = ImageLiterals.Voting.imgProgress3
            self.originView.yelloProgressBackGroundThree.image = ImageLiterals.Voting.imgProgress5
            self.originView.yelloProgressBackGroundFour.image = ImageLiterals.Voting.imgProgress6
        case 4:
            self.originView.yelloProgressBackGroundOne.image = ImageLiterals.Voting.imgProgress3
            self.originView.yelloProgressBackGroundTwo.image = ImageLiterals.Voting.imgProgress4
            self.originView.yelloProgressBackGroundThree.image = ImageLiterals.Voting.imgProgress6
            self.originView.yelloProgressBackGroundFour.image = ImageLiterals.Voting.imgProgress7
        case 5:
            self.originView.yelloProgressBackGroundOne.image = ImageLiterals.Voting.imgProgress4
            self.originView.yelloProgressBackGroundTwo.image = ImageLiterals.Voting.imgProgress5
            self.originView.yelloProgressBackGroundThree.image = ImageLiterals.Voting.imgProgress7
            self.originView.yelloProgressBackGroundFour.image = ImageLiterals.Voting.imgProgress8
            
        case 6:
            self.originView.yelloProgressBackGroundOne.image = ImageLiterals.Voting.imgProgress5
            self.originView.yelloProgressBackGroundTwo.image = ImageLiterals.Voting.imgProgress6
            self.originView.yelloProgressBackGroundThree.image = ImageLiterals.Voting.imgProgress8
            self.originView.yelloProgressBackGroundFour.image = ImageLiterals.Voting.imgProgress9
        case 7:
            self.originView.yelloProgressBackGroundOne.image = ImageLiterals.Voting.imgProgress6
            self.originView.yelloProgressBackGroundTwo.image = ImageLiterals.Voting.imgProgress7
            self.originView.yelloProgressBackGroundThree.image = ImageLiterals.Voting.imgProgress9
            self.originView.yelloProgressBackGroundFour.image = ImageLiterals.Voting.imgProgress10
        case 8:
            self.originView.yelloProgressBackGroundOne.image = ImageLiterals.Voting.imgProgress7
            self.originView.yelloProgressBackGroundTwo.image = ImageLiterals.Voting.imgProgress8
            self.originView.yelloProgressBackGroundThree.image = ImageLiterals.Voting.imgProgress10
            self.originView.yelloProgressBackGroundFour.image = nil
        case 9:
            self.originView.yelloProgressBackGroundOne.image = ImageLiterals.Voting.imgProgress8
            self.originView.yelloProgressBackGroundTwo.image = ImageLiterals.Voting.imgProgress9
            self.originView.yelloProgressBackGroundThree.image = nil
            self.originView.yelloProgressBackGroundFour.image = nil
        default:
            break
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
                
        let nameButtons = [originView.nameOneButton, originView.nameTwoButton, originView.nameThreeButton, originView.nameFourButton]
        
        let nameTexts = [nameTextOne, nameTextTwo, nameTextThree, nameTextFour]
        
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
            friendID = votingList[VotingViewController.pushCount - 1]?.friendId[index] ?? 0
        }
        
        view.addSubview(nameMiddleText)
        nameMiddleText.snp.makeConstraints {
            $0.center.equalTo(nameMiddleBackground)
        }
        
        nameButtonClick = true
    }
    
    @objc
    func keywordClicked(_ sender: UIButton) {
        if keywordButtonClick {
            view.showToast(message: StringLiterals.Voting.VoteToast.cancel)
        }
        
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
