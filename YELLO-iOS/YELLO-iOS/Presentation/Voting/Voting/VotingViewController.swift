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
    
    static var pushCount = 0
    
    private let originView = BaseVotingMainView()
    
    private var nameCount: Int = 0
    private var keywordCount: Int = 0
    
    private let nameStackView = UIStackView()
    private let nameHead = UILabel()
    private let nameMiddleBackground = UIView()
    private let nameMiddleText = UILabel()
    private let nameFoot = UILabel()
    
    private var nameTextOne = UILabel()
    private var nameTextTwo = UILabel()
    private var nameTextThree = UILabel()
    private var nameTextFour = UILabel()
    
    private let keywordStackView = UIStackView()
    private let keywordHead = UILabel()
    private let keywordMiddleBackground = UIView()
    private let keywordMiddleText = UILabel()
    private let keywordFoot = UILabel()
    
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
    
    // MARK: - Life Cycle
    
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
    
    // MARK: - Style
    
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
        
        nameStackView.do {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .center
            $0.spacing = 10
        }
        
        nameHead.do {
            $0.text = "나는"
            $0.textColor = .white
            $0.font = .uiLarge
        }
        
        nameMiddleBackground.do {
            $0.backgroundColor = .grayscales900
            $0.makeBorder(width: 1, color: .grayscales700)
            $0.makeCornerRound(radius: 8)
        }
        
        nameMiddleText.do {
            $0.textColor = .black
            $0.font = .uiBodyLarge
            $0.textAlignment = .center
            $0.numberOfLines = 1
            $0.backgroundColor = .yelloMain500
            $0.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -60)
        }
        
        nameFoot.do {
            $0.text = "이/(가)"
            $0.textColor = .white
            $0.font = .uiLarge
        }
        
        keywordStackView.do {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .center
            $0.spacing = 10
        }
        
        keywordHead.do {
            $0.text = ""
            $0.textColor = .white
            $0.font = .uiLarge
        }
        
        keywordMiddleBackground.do {
            $0.backgroundColor = .grayscales900
            $0.makeBorder(width: 1, color: .grayscales700)
            $0.makeCornerRound(radius: 8)
        }
        
        keywordMiddleText.do {
            $0.textColor = .black
            $0.font = .uiBodyLarge
            $0.textAlignment = .center
            $0.backgroundColor = .yelloMain500
            $0.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -60)
        }
        
        keywordFoot.do {
            $0.text = "닮은 것 같아"
            $0.textColor = .white
            $0.font = .uiLarge
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
    
    // MARK: - Layout
    
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
        
        originView.questionBackground.addSubviews(nameStackView, keywordStackView)
        
        nameStackView.addArrangedSubviews(nameHead, nameMiddleBackground, nameFoot)
        keywordStackView.addArrangedSubviews(keywordHead, keywordMiddleBackground, keywordFoot)
        
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
        
        nameStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(36.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        nameMiddleBackground.snp.makeConstraints {
            $0.width.equalTo(86.adjusted)
            $0.height.equalTo(34.adjusted)
        }
        
        nameMiddleText.snp.makeConstraints {
            $0.width.equalTo(82.adjusted)
            $0.height.equalTo(30.adjusted)
        }
        
        keywordStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(36.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        keywordMiddleBackground.snp.makeConstraints {
            $0.width.equalTo(150.adjusted)
            $0.height.equalTo(34.adjusted)
        }
        
        keywordMiddleText.snp.makeConstraints {
            $0.width.equalTo(144.adjusted)
            $0.height.equalTo(30.adjusted)
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
    
    // MARK: - Objc Function
    
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
            
            nameMiddleText.text = nameTextOne.text
            
        } else if sender == originView.nameTwo {
            updateLabelAppearance(nameTextTwo)
            
            originView.nameOne.isEnabled = false
            originView.nameThree.isEnabled = false
            originView.nameFour.isEnabled = false
            
            nameTextOne.textColor = .grayscales700
            nameTextThree.textColor = .grayscales700
            nameTextFour.textColor = .grayscales700
            
            nameMiddleText.text = nameTextTwo.text
            
        } else if sender == originView.nameThree {
            updateLabelAppearance(nameTextThree)
            
            originView.nameOne.isEnabled = false
            originView.nameTwo.isEnabled = false
            originView.nameFour.isEnabled = false
            
            nameTextOne.textColor = .grayscales700
            nameTextTwo.textColor = .grayscales700
            nameTextFour.textColor = .grayscales700
            
            nameMiddleText.text = nameTextThree.text
            
        } else if sender == originView.nameFour {
            updateLabelAppearance(nameTextFour)
            
            originView.nameOne.isEnabled = false
            originView.nameTwo.isEnabled = false
            originView.nameThree.isEnabled = false
            
            nameTextOne.textColor = .grayscales700
            nameTextTwo.textColor = .grayscales700
            nameTextThree.textColor = .grayscales700
            
            nameMiddleText.text = nameTextFour.text
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

        let keywordButtons = [originView.keywordOne, originView.keywordTwo, originView.keywordThree, originView.keywordFour]

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

// MARK: - private function

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
