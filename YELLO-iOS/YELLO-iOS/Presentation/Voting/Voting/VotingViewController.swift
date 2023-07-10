//
//  VotingViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

import SnapKit
import Then

final class VotingViewController: BaseViewController {
    
    private let originView = BaseVotingMainView()
    
    var nameTextOne = UILabel()
    var nameTextTwo = UILabel()
    var nameTextThree = UILabel()
    var nameTextFour = UILabel()
    
    static var pushCount = 0
    static var suffleCount = 0
    
    override func loadView() {
        self.view = originView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        setSuffleButton()
    }
    
    override func setStyle() {
        
        let firstLineFont = UIFont.uiBodyMedium
        let firstLineColor = UIColor.white
        let secondLineFont = UIFont.uiLabelSmall
        let secondLineColor = UIColor.grayscales600
        
        nameTextOne = createTwoLineLabel(text: StringLiterals.Voting.VoteName.one,
                                         firstLineFont: firstLineFont,
                                         firstLineColor: firstLineColor,
                                         secondLineFont: secondLineFont,
                                         secondLineColor: secondLineColor)
        
        nameTextTwo = createTwoLineLabel(text: StringLiterals.Voting.VoteName.two,
                                         firstLineFont: firstLineFont,
                                         firstLineColor: firstLineColor,
                                         secondLineFont: secondLineFont,
                                         secondLineColor: secondLineColor)
        
        nameTextThree = createTwoLineLabel(text: StringLiterals.Voting.VoteName.three,
                                           firstLineFont: firstLineFont,
                                           firstLineColor: firstLineColor,
                                           secondLineFont: secondLineFont,
                                           secondLineColor: secondLineColor)
        
        nameTextFour = createTwoLineLabel(text: StringLiterals.Voting.VoteName.four,
                                          firstLineFont: firstLineFont,
                                          firstLineColor: firstLineColor,
                                          secondLineFont: secondLineFont,
                                          secondLineColor: secondLineColor)
        
        originView.nameOne.do {
            $0.addTarget(self, action: #selector(nameButtonClicked), for: .touchUpInside)
        }
        
        originView.nameTwo.do {
            $0.addTarget(self, action: #selector(nameButtonClicked), for: .touchUpInside)
        }
        
        originView.nameThree.do {
            $0.addTarget(self, action: #selector(nameButtonClicked), for: .touchUpInside)
        }
        
        originView.nameFour.do {
            $0.addTarget(self, action: #selector(nameButtonClicked), for: .touchUpInside)
        }
        
        originView.keywordOne.do {
            $0.setTitle(StringLiterals.Voting.VoteKeyword.one, for: .normal)
            $0.addTarget(self, action: #selector(keywordClicked), for: .touchUpInside)
        }
        
        originView.keywordTwo.do {
            $0.setTitle(StringLiterals.Voting.VoteKeyword.two, for: .normal)
            $0.addTarget(self, action: #selector(keywordClicked), for: .touchUpInside)
        }
        
        originView.keywordThree.do {
            $0.setTitle(StringLiterals.Voting.VoteKeyword.three, for: .normal)
            $0.addTarget(self, action: #selector(keywordClicked), for: .touchUpInside)
        }
        
        originView.keywordFour.do {
            $0.setTitle(StringLiterals.Voting.VoteKeyword.four, for: .normal)
            $0.addTarget(self, action: #selector(keywordClicked), for: .touchUpInside)
        }
        
        originView.suffleButton.do {
            $0.addTarget(self, action: #selector(suffleCountClicked), for: .touchUpInside)
        }
        
        originView.skipButton.do {
            $0.addTarget(self, action: #selector(skipButtonClicked), for: .touchUpInside)
        }
        
    }
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        originView.nameOne.addSubview(nameTextOne)
        originView.nameTwo.addSubview(nameTextTwo)
        originView.nameThree.addSubview(nameTextThree)
        originView.nameFour.addSubview(nameTextFour)
        
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
        
        originView.yelloBalloon.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 4.adjusted)
        }
        
        originView.yelloProgress.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 60.adjusted)
        }
        
        originView.numOfPage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 40.adjusted)
        }
        
        originView.questionBackground.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(statusBarHeight + 132.adjusted)
        }
        
    }
    
    @objc
    func nameButtonClicked(_ sender: UIButton) {
        // 클릭한 버튼의 레이블 색상 변경
        if sender == originView.nameOne {
            updateLabelAppearance(nameTextOne)
        } else if sender == originView.nameTwo {
            updateLabelAppearance(nameTextTwo)
        } else if sender == originView.nameThree {
            updateLabelAppearance(nameTextThree)
        } else if sender == originView.nameFour {
            updateLabelAppearance(nameTextFour)
        }
    }
    
    @objc
    func keywordClicked(_ sender: UIButton) {
        // 클릭한 버튼의 레이블 색상 변경
        sender.setTitleColor(.yelloMain500, for: .normal)
    }
    
    @objc
    func suffleCountClicked() {
        VotingViewController.suffleCount += 1
        setSuffleButton()
    }
    
    @objc
    func skipButtonClicked() {
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

extension VotingViewController {
    private func setVotingView() {
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
        self.originView.numOfPage.text = String(VotingViewController.pushCount + 1)
    }
    
    private func setSuffleButton() {
        if VotingViewController.suffleCount < 3 {
            originView.suffleNum.text = String(3 - VotingViewController.suffleCount) + "/3"
        }
        
        if VotingViewController.suffleCount == 3 {
            originView.suffleButton.isEnabled = false
            originView.suffleIcon.image = ImageLiterals.Voting.icSuffleLocked
            originView.suffleText.textColor = UIColor(hex: "191919", alpha: 0.4)
            originView.suffleNum.textColor = UIColor(hex: "191919", alpha: 0.4)
            originView.suffleNum.text = "0/3"
        }
    }
    
}
