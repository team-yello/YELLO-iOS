//
//  Voting.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/11.
//

import UIKit

extension VotingViewController {
    func createTwoLineLabel(text: String, firstLineFont: UIFont, firstLineColor: UIColor, secondLineFont: UIFont, secondLineColor: UIColor) -> UILabel {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: text)
        
        // 첫 번째 줄 속성 적용
        attributedText.addAttribute(.font, value: firstLineFont, range: NSRange(location: 0, length: 3))
        attributedText.addAttribute(.foregroundColor, value: firstLineColor, range: NSRange(location: 0, length: 3))
        
        // 두 번째 줄 속성 적용
        attributedText.addAttribute(.font, value: secondLineFont, range: NSRange(location: 3, length: text.count - 3))
        attributedText.addAttribute(.foregroundColor, value: secondLineColor, range: NSRange(location: 3, length: text.count - 3))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        
        label.attributedText = attributedText
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }
    
    func updateLabelAppearance(_ label: UILabel) {
        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        attributedString.addAttributes([.foregroundColor: UIColor.yelloMain500, .font: UIFont.uiBodyMedium], range: NSRange(location: 0, length: 3))
        attributedString.addAttributes([.foregroundColor: UIColor.grayscales600, .font: UIFont.uiLabelSmall], range: NSRange(location: 3, length: attributedString.length - 3))
        label.attributedText = attributedString
    }
    
    func setVotingView() {
        let dummy = VotingDummy.dummy()
        
        let gradientView = CAGradientLayer()
        gradientView.frame = view.bounds
        gradientView.colors = [dummy[VotingViewController.pushCount].backgroundColorTop.cgColor, dummy[VotingViewController.pushCount].backgroundColorBottom.cgColor]
        
        gradientView.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientView.endPoint = CGPoint(x: 1.0, y: 1.0)
        view.layer.insertSublayer(gradientView, at: 0)
        
        self.originView.yelloBalloon.image = dummy[VotingViewController.pushCount].yelloBalloon
        self.originView.yelloProgress.image =
        dummy[VotingViewController.pushCount].yelloProgress
        self.originView.numOfPageLabel.text = String(VotingViewController.pushCount + 1)
    }
    
    func setNextViewController() {
        var viewController = UIViewController()
        // pushCount가 10 이상이면 투표 끝난 것이므로 포인트뷰컨으로 push
        if VotingViewController.pushCount >= 10 {
            viewController = VotingPointViewController()
            self.navigationController?.pushViewController(viewController, animated: false)
        } else {
            viewController = VotingViewController()
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
        nameButtonClick = true
        if nameCount > 0 {
            view.showToast(message: StringLiterals.Voting.VoteToast.cancel)
        }
        nameCount += 1
        
        let nameButtons = [originView.nameOneButton, originView.nameTwoButton, originView.nameThreeButton, originView.nameFourButton]
        
        let nameTexts = [nameTextOne, nameTextTwo, nameTextThree, nameTextFour]
        
        for (index, button) in nameButtons.enumerated() {
            button.isEnabled = (button == sender)
            
            if button.isEnabled {
                let selectedText = nameTexts[index]
                updateLabelAppearance(selectedText)
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
    }
    
    @objc
    func keywordClicked(_ sender: UIButton) {
        keywordButtonClick = true
        if keywordCount > 0 {
            view.showToast(message: StringLiterals.Voting.VoteToast.cancel)
        }
        keywordCount += 1

        sender.setTitleColor(.yelloMain500, for: .normal)
        keywordMiddleText.text = sender.titleLabel?.text

        let keywordButtons = [originView.keywordOneButton, originView.keywordTwoButton, originView.keywordThreeButton, originView.keywordFourButton]

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
    }
    
    @objc
    func suffleButtonClicked() {
        if nameButtonClick {
            originView.suffleButton.isEnabled = false
            view.showToast(message: StringLiterals.Voting.VoteToast.suffle)
            originView.suffleButton.isEnabled = true
        } else {
            suffleCount += 1
        }
    }
    
    @objc
    func skipButtonClicked() {
        if eitherButtonClicked {
            originView.skipButton.isEnabled = false
            view.showToast(message: StringLiterals.Voting.VoteToast.skip)
            originView.skipButton.isEnabled = true
        } else {
            setNextViewController()
        }
    }
}
