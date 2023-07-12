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
    
    let originView = BaseVotingMainView()
    
    var nameCount: Int = 0
    var keywordCount: Int = 0
    
    private let nameStackView = UIStackView()
    private let nameHead = UILabel()
    let nameMiddleBackground = UIView(frame: CGRect(x: 0, y: 0, width: 86.adjusted, height: 34.adjusted))

    let nameMiddleText = UILabel()
    private let nameFoot = UILabel()
    
    var nameTextOne = UILabel()
    var nameTextTwo = UILabel()
    var nameTextThree = UILabel()
    var nameTextFour = UILabel()
    
    private let keywordStackView = UIStackView()
    private let keywordHead = UILabel()
    let keywordMiddleBackground = UIView(frame: CGRect(x: 0, y: 0, width: 150.adjusted, height: 34.adjusted))
    let keywordMiddleText = UILabel()
    private let keywordFoot = UILabel()
    
    var nameButtonClick: Bool = false {
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
    
    var keywordButtonClick: Bool = false {
        didSet {
            if nameButtonClick && keywordButtonClick {
                bothButtonClicked = true
            } else if nameButtonClick || keywordButtonClick {
                eitherButtonClicked = true
            }
        }
    }
    
    // name, keyword 중 하나의 버튼이 클릭되었을 때 동작
    var eitherButtonClicked: Bool = false {
        didSet {
            originView.skipButton.setTitleColor(UIColor(hex: "191919", alpha: 0.4), for: .normal)
            originView.skipButton.setImage(ImageLiterals.Voting.icSkipLocked, for: .normal)
        }
    }
    
    // name, keyword 버튼이 모두 클릭되었을 때 동작
    var bothButtonClicked: Bool = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.setNextViewController()
            }
        }
    }
    
    var suffleCount = 0 {
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
        
        nameTextOne = UILabel.createTwoLineLabel(text: StringLiterals.Voting.VoteName.one,
                                         firstLineFont: firstLineFont,
                                         firstLineColor: firstLineColor,
                                         secondLineFont: secondLineFont,
                                         secondLineColor: secondLineColor)
        
        nameTextTwo = UILabel.createTwoLineLabel(text: StringLiterals.Voting.VoteName.two,
                                         firstLineFont: firstLineFont,
                                         firstLineColor: firstLineColor,
                                         secondLineFont: secondLineFont,
                                         secondLineColor: secondLineColor)
        
        nameTextThree = UILabel.createTwoLineLabel(text: StringLiterals.Voting.VoteName.three,
                                           firstLineFont: firstLineFont,
                                           firstLineColor: firstLineColor,
                                           secondLineFont: secondLineFont,
                                           secondLineColor: secondLineColor)
        
        nameTextFour = UILabel.createTwoLineLabel(text: StringLiterals.Voting.VoteName.four,
                                          firstLineFont: firstLineFont,
                                          firstLineColor: firstLineColor,
                                          secondLineFont: secondLineFont,
                                          secondLineColor: secondLineColor)
        
        originView.nameOneButton.do {
            $0.addTarget(self, action: #selector(nameButtonClicked), for: .touchUpInside)
        }
        
        originView.nameTwoButton.do {
            $0.addTarget(self, action: #selector(nameButtonClicked), for: .touchUpInside)
        }
        
        originView.nameThreeButton.do {
            $0.addTarget(self, action: #selector(nameButtonClicked), for: .touchUpInside)
        }
        
        originView.nameFourButton.do {
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
            $0.layer.cornerRadius = 8
            $0.addDottedBorder()
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
            $0.layer.cornerRadius = 8
            $0.addDottedBorder()
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
        
        originView.keywordOneButton.do {
            $0.setTitle(StringLiterals.Voting.VoteKeyword.one, for: .normal)
            $0.addTarget(self, action: #selector(keywordClicked), for: .touchUpInside)
        }
        
        originView.keywordTwoButton.do {
            $0.setTitle(StringLiterals.Voting.VoteKeyword.two, for: .normal)
            $0.addTarget(self, action: #selector(keywordClicked), for: .touchUpInside)
        }
        
        originView.keywordThreeButton.do {
            $0.setTitle(StringLiterals.Voting.VoteKeyword.three, for: .normal)
            $0.addTarget(self, action: #selector(keywordClicked), for: .touchUpInside)
        }
        
        originView.keywordFourButton.do {
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
        view.addSubview(originView)
        
        originView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(667.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        originView.nameOneButton.addSubview(nameTextOne)
        originView.nameTwoButton.addSubview(nameTextTwo)
        originView.nameThreeButton.addSubview(nameTextThree)
        originView.nameFourButton.addSubview(nameTextFour)
        
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
    }
}
