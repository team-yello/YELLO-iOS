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
    static var pushCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: "VotingViewController.pushCount")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "VotingViewController.pushCount")
        }
    }
    var votingList: [VotingData] = []
    var votingAnswer: [VoteAnswerList] = []
    var friendID: Int = 0
    var keyword: String = ""
    var myPoint = 0
    var votingPlusPoint = 0
    
    let originView = BaseVotingMainView()
  
    private let nameStackView = UIStackView()
    let nameHead = UILabel()
    var nameMiddleBackground = UIView(frame: CGRect(x: 0, y: 0, width: 70.adjusted, height: 34.adjusted))

    let nameMiddleText = UILabel()
    let nameFoot = UILabel()
    
    var nameTextOne = UILabel()
    var nameTextTwo = UILabel()
    var nameTextThree = UILabel()
    var nameTextFour = UILabel()
    
    private let keywordStackView = UIStackView()
    let keywordHead = UILabel()
    var keywordMiddleBackground = UIView(frame: CGRect(x: 0, y: 0, width: 150.adjusted, height: 34.adjusted))
    let keywordMiddleText = UILabel()
    let keywordFoot = UILabel()
    var nameButtonTouch = false
    var keywordButtonTouch = false
    
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                self.setNextViewController()
            }
            if VotingViewController.pushCount <= 10 {
                
                DispatchQueue.global(qos: .background).async {
                    let existingPoints: Int = UserDefaults.standard.integer(forKey: "UserPlusPoint")
                    let newPoints = existingPoints + self.votingList[VotingViewController.pushCount - 1].questionPoint
                    UserDefaults.standard.set(newPoints, forKey: "UserPlusPoint")
                }
                
                votingAnswer.append(VoteAnswerList(friendId: friendID, questionId: votingList[VotingViewController.pushCount - 1].questionId, keywordName: keyword, colorIndex: VotingViewController.pushCount - 1))
            }
        }
    }
    
    var suffleCount = 0 {
        didSet {
            NetworkService.shared.votingService.getVotingSuffle { result in
                switch result {
                case .success(let data):
                    guard let data = data.data else { return }
                    
                    let first = data[0].friendName + "\n@" + data[0].friendYelloId
                    let second = data[1].friendName + "\n@" + data[1].friendYelloId
                    let third = data[2].friendName + "\n@" + data[2].friendYelloId
                    let fourth = data[3].friendName + "\n@" + data[3].friendYelloId
                    
                    self.votingList[VotingViewController.pushCount - 1].friendId[0] = data[0].friendId
                    self.votingList[VotingViewController.pushCount - 1].friendId[1] = data[1].friendId
                    self.votingList[VotingViewController.pushCount - 1].friendId[2] = data[2].friendId
                    self.votingList[VotingViewController.pushCount - 1].friendId[3] = data[3].friendId
                    
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

        Color.shared.restoreFromUserDefaults()
        votingList = loadVotingData() ?? []
        myPoint = UserDefaults.standard.integer(forKey: "UserPoint")
        setBackground()
        setBackgroundColor()
        navigationController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Private Function
    
    private func setBackground() {
        let maxNameLength = votingList[VotingViewController.pushCount].friendList.compactMap { $0.components(separatedBy: "\n").first?.count }.max() ?? 0
        let nameLength = (maxNameLength * 14).adjusted + 28.adjusted
        
        let maxKeywordLength = votingList[VotingViewController.pushCount].keywordList.compactMap { $0.count }.max() ?? 0
        let keywordLength = (maxKeywordLength * 14).adjusted + 28.adjusted
        
        nameMiddleBackground = UIView(frame: CGRect(x: 0, y: 0, width: nameLength, height: 34.adjusted))
        keywordMiddleBackground = UIView(frame: CGRect(x: 0, y: 0, width: keywordLength, height: 34.adjusted))
        
        nameMiddleBackground.do {
            $0.backgroundColor = .grayscales900
            $0.layer.cornerRadius = 8
            $0.addDottedBorder()
        }
        
        keywordMiddleBackground.do {
            $0.backgroundColor = .grayscales900
            $0.layer.cornerRadius = 8
            $0.addDottedBorder()
        }
        
        nameStackView.addArrangedSubviews(nameHead, nameMiddleBackground, nameFoot)
        keywordStackView.addArrangedSubviews(keywordHead, keywordMiddleBackground, keywordFoot)
        
        nameMiddleBackground.snp.makeConstraints {
            $0.width.equalTo(nameLength)
            $0.height.equalTo(34.adjusted)
        }
        
        nameMiddleText.snp.makeConstraints {
            $0.width.equalTo(nameLength)
            $0.height.equalTo(30.adjusted)
        }
        
        keywordMiddleBackground.snp.makeConstraints {
            $0.width.equalTo(keywordLength)
            $0.height.equalTo(34.adjusted)
        }
        keywordMiddleText.snp.makeConstraints {
            $0.width.equalTo(keywordLength)
            $0.height.equalTo(30.adjusted)
        }
    }
    
    private func setBackgroundColor() {
        if VotingViewController.pushCount == 0 {
            Color.shared.startIndex = Int.random(in: 0...11)
            Color.shared.selectedTopColors = selectTopColors(startIndex: Color.shared.startIndex ?? 0)
            Color.shared.selectedBottomColors = selectBottomColors(startIndex: Color.shared.startIndex ?? 0)
            Color.shared.saveToUserDefaults()
        }
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
        
        nameStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(36.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        keywordStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(36.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
}
