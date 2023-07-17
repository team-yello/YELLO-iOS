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
    var votingList: [VotingData?] = []
    var votingAnswer: [VoteAnswerList] = []
    var friendID: Int = 0
    var keyword: String = ""
    var myPoint = 0
    var votingPlusPoint = 0
    
    let originView = BaseVotingMainView()
  
    private let nameStackView = UIStackView()
    let nameHead = UILabel()
    let nameMiddleBackground = UIView(frame: CGRect(x: 0, y: 0, width: 86.adjusted, height: 34.adjusted))

    let nameMiddleText = UILabel()
    let nameFoot = UILabel()
    
    var nameTextOne = UILabel()
    var nameTextTwo = UILabel()
    var nameTextThree = UILabel()
    var nameTextFour = UILabel()
    
    private let keywordStackView = UIStackView()
    let keywordHead = UILabel()
    let keywordMiddleBackground = UIView(frame: CGRect(x: 0, y: 0, width: 150.adjusted, height: 34.adjusted))
    let keywordMiddleText = UILabel()
    let keywordFoot = UILabel()
    
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
            if VotingViewController.pushCount <= 10 {
                myPoint += votingList[VotingViewController.pushCount - 1]?.questionPoint ?? 0
                votingPlusPoint += votingList[VotingViewController.pushCount - 1]?.questionPoint ?? 0
                
                votingAnswer.append(VoteAnswerList(friendId: friendID, questionId: votingList[VotingViewController.pushCount - 1]?.questionId ?? 0, keywordName: keyword, colorIndex: VotingViewController.pushCount - 1))
            }
        }
    }
    
    var suffleCount = 0 {
        didSet {
            NetworkService.shared.votingService.getVotingSuffle { result in
                switch result {
                case .success(let data):
                    guard let data = data.data else { return }
                    
                    let first = data[0].friendName + "\n" + data[0].friendYelloId
                    let second = data[1].friendName + "\n" + data[1].friendYelloId
                    let third = data[2].friendName + "\n" + data[2].friendYelloId
                    let fourth = data[3].friendName + "\n" + data[3].friendYelloId
                    
                    self.setNameText(first: first, second: second, third: third, fourth: fourth)
                
                default:
                    print("network failure")
                    return
                }
            }
            
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
            $0.addTarget(self, action: #selector(keywordClicked), for: .touchUpInside)
        }
        
        originView.keywordTwoButton.do {
            $0.addTarget(self, action: #selector(keywordClicked), for: .touchUpInside)
        }
        
        originView.keywordThreeButton.do {
            $0.addTarget(self, action: #selector(keywordClicked), for: .touchUpInside)
        }
        
        originView.keywordFourButton.do {
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
        
        originView.questionBackground.addSubviews(nameStackView, keywordStackView)
        
        nameStackView.addArrangedSubviews(nameHead, nameMiddleBackground, nameFoot)
        keywordStackView.addArrangedSubviews(keywordHead, keywordMiddleBackground, keywordFoot)
        
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
