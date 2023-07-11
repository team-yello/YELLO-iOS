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
    
    private var nameCount: Int = 0
    private var keywordCount: Int = 0
    
    private var nameTextOne = UILabel()
    private var nameTextTwo = UILabel()
    private var nameTextThree = UILabel()
    private var nameTextFour = UILabel()
    
    static var pushCount = 0
    
    private var nameButtonClick: Bool = false {
        didSet {
            if nameButtonClick && keywordButtonClick {
                bothButtonClicked = true
            } else if nameButtonClick || keywordButtonClick {
                eitherButtonClicked = true
            }
            originView.suffleIcon.image = ImageLiterals.Voting.icSuffleLocked
            originView.suffleText.textColor = UIColor(hex: "191919", alpha: 0.4)
            originView.suffleNum.textColor = UIColor(hex: "191919", alpha: 0.4)
        }
    }
    
    private var keywordButtonClick: Bool = false {
        didSet {
            if nameButtonClick && keywordButtonClick {
                bothButtonClicked = true
            } else if nameButtonClick || keywordButtonClick {
                eitherButtonClicked = true
            }
        }
    }
    
    // name, keyword 중 하나의 버튼이 클릭되었을 때 동작
    private var eitherButtonClicked: Bool = false {
        didSet {
            originView.skipButton.setTitleColor(UIColor(hex: "191919", alpha: 0.4), for: .normal)
            originView.skipButton.setImage(ImageLiterals.Voting.icSkipLocked, for: .normal)
        }
    }
    
    // name, keyword 버튼이 모두 클릭되었을 때 동작
    private var bothButtonClicked: Bool = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.setNextViewController()
            }
        }
    }
    
    private var suffleCount = 0 {
        didSet {
            if suffleCount < 3 {
                originView.suffleNum.text = String(3 - suffleCount) + "/3"
            }
            
            if suffleCount == 3 {
                originView.suffleButton.isEnabled = false
                originView.suffleIcon.image = ImageLiterals.Voting.icSuffleLocked
                originView.suffleText.textColor = UIColor(hex: "191919", alpha: 0.4)
                originView.suffleNum.textColor = UIColor(hex: "191919", alpha: 0.4)
                originView.suffleNum.text = "0/3"
            }
            
        }
    }

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
            $0.addTarget(self, action: #selector(suffleButtonClicked), for: .touchUpInside)
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
        nameButtonClick = true
        if nameCount > 0 {
            view.showToast(message: StringLiterals.Voting.VoteToast.cancel)
        }
        nameCount += 1

        if sender == originView.nameOne {
            updateLabelAppearance(nameTextOne)
            
            originView.nameTwo.isEnabled = false
            originView.nameThree.isEnabled = false
            originView.nameFour.isEnabled = false

            nameTextTwo.textColor = .grayscales700
            nameTextThree.textColor = .grayscales700
            nameTextFour.textColor = .grayscales700
                        
        } else if sender == originView.nameTwo {
            updateLabelAppearance(nameTextTwo)
            
            originView.nameOne.isEnabled = false
            originView.nameThree.isEnabled = false
            originView.nameFour.isEnabled = false
            
            nameTextOne.textColor = .grayscales700
            nameTextThree.textColor = .grayscales700
            nameTextFour.textColor = .grayscales700
        } else if sender == originView.nameThree {
            updateLabelAppearance(nameTextThree)
            
            originView.nameOne.isEnabled = false
            originView.nameTwo.isEnabled = false
            originView.nameFour.isEnabled = false
            
            nameTextOne.textColor = .grayscales700
            nameTextTwo.textColor = .grayscales700
            nameTextFour.textColor = .grayscales700
        } else if sender == originView.nameFour {
            updateLabelAppearance(nameTextFour)

            originView.nameOne.isEnabled = false
            originView.nameTwo.isEnabled = false
            originView.nameThree.isEnabled = false
            
            nameTextOne.textColor = .grayscales700
            nameTextTwo.textColor = .grayscales700
            nameTextThree.textColor = .grayscales700
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
        
        if sender == originView.keywordOne {
            originView.keywordTwo.isEnabled = false
            originView.keywordThree.isEnabled = false
            originView.keywordFour.isEnabled = false

            originView.keywordTwo.setTitleColor(.grayscales700, for: .normal)
            originView.keywordThree.setTitleColor(.grayscales700, for: .normal)
            originView.keywordFour.setTitleColor(.grayscales700, for: .normal)
            
        } else if sender == originView.keywordTwo {
            originView.keywordOne.isEnabled = false
            originView.keywordThree.isEnabled = false
            originView.keywordFour.isEnabled = false

            originView.keywordOne.setTitleColor(.grayscales700, for: .normal)
            originView.keywordThree.setTitleColor(.grayscales700, for: .normal)
            originView.keywordFour.setTitleColor(.grayscales700, for: .normal)
            
        } else if sender == originView.keywordThree {
            originView.keywordOne.isEnabled = false
            originView.keywordTwo.isEnabled = false
            originView.keywordFour.isEnabled = false

            originView.keywordOne.setTitleColor(.grayscales700, for: .normal)
            originView.keywordTwo.setTitleColor(.grayscales700, for: .normal)
            originView.keywordFour.setTitleColor(.grayscales700, for: .normal)
            
        } else if sender == originView.keywordFour {
            originView.keywordOne.isEnabled = false
            originView.keywordTwo.isEnabled = false
            originView.keywordThree.isEnabled = false

            originView.keywordOne.setTitleColor(.grayscales700, for: .normal)
            originView.keywordTwo.setTitleColor(.grayscales700, for: .normal)
            originView.keywordThree.setTitleColor(.grayscales700, for: .normal)
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
    
    private func setNextViewController() {
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
