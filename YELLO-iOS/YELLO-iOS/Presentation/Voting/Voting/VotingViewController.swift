//
//  VotingViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

import Amplitude
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
  
    let nameStackView = UIStackView()
    let nameHead = UILabel()
    var nameMiddleBackground = UIView(frame: CGRect(x: 0, y: 0, width: 70.adjusted, height: 34.adjusted))

    let nameMiddleText = UILabel()
    let nameFoot = UILabel()
    
    var nameTextOne = UILabel()
    var nameTextTwo = UILabel()
    var nameTextThree = UILabel()
    var nameTextFour = UILabel()
    
    let keywordStackView = UIStackView()
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
            }
            originView.skipButton.setTitleColor(UIColor(hex: "191919", alpha: 0.4), for: .normal)
            originView.skipButton.setImage(ImageLiterals.Voting.icSkipLocked, for: .normal)
        }
    }
    
    // name, keyword 버튼이 모두 클릭되었을 때 동작
    var bothButtonClicked: Bool = false {
        didSet {
            guard bothButtonClicked && !oldValue else { return }
            self.setNextViewController()
            
            let allNameButtons = [self.originView.nameOneButton, self.originView.nameTwoButton, self.originView.nameThreeButton, self.originView.nameFourButton]
            let allKeywordButtons = [self.originView.keywordOneButton, self.originView.keywordTwoButton, self.originView.keywordThreeButton, self.originView.keywordFourButton]
            
            // 모든 버튼 비활성화
            allNameButtons.forEach { $0.isEnabled = false }
            allKeywordButtons.forEach { $0.isEnabled = false }
            
            // 0.6초 후에 다시 활성화
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                allNameButtons.forEach { $0.isEnabled = true }
                allKeywordButtons.forEach { $0.isEnabled = true }
            }
            
            if VotingViewController.pushCount <= 8 {
                
                DispatchQueue.global(qos: .background).async {
                    let existingPoints: Int = UserDefaults.standard.integer(forKey: "UserPlusPoint")
                    let newPoints = existingPoints + self.votingList[VotingViewController.pushCount].questionPoint
                    UserDefaults.standard.set(newPoints, forKey: "UserPlusPoint")
                }
                
                var myColorIndex = (Color.shared.startIndex ?? 0) + VotingViewController.pushCount
                if myColorIndex > 12 {
                    myColorIndex = myColorIndex - 12
                }
                votingAnswer.append(VoteAnswerList(friendId: friendID, questionId: votingList[VotingViewController.pushCount].questionId, keywordName: keyword, colorIndex: myColorIndex))
                let previousData = loadUserData() ?? []
                let combinedData = previousData + votingAnswer
                saveUserData(combinedData)
            }
        }
    }
    
    var suffleCount = 0 {
        didSet {
            if suffleCount > 3 {
                originView.suffleButton.isEnabled = false
            } else {
                if suffleCount < 3 {
                    originView.suffleNum.text = String(3 - suffleCount) + "/3"
                }
                if suffleCount == 3 {
                    originView.suffleNum.text = "0/3"
                    originView.suffleIcon.image = ImageLiterals.Voting.icSuffleLocked
                    originView.suffleText.textColor = UIColor(hex: "191919", alpha: 0.4)
                    originView.suffleNum.textColor = UIColor(hex: "191919", alpha: 0.4)
                }
                originView.suffleButton.isEnabled = false
                // 친구 1~3명일 때 suffle button 누르면 분기처리
                NetworkService.shared.votingService.getVotingSuffle { result in
                    switch result {
                    case .success(let data):
                        guard let data = data.data else { return }
                        if data.count == 4 {
                            let first = data[0].friendName + "\n@" + data[0].friendYelloId
                            let second = data[1].friendName + "\n@" + data[1].friendYelloId
                            let third = data[2].friendName + "\n@" + data[2].friendYelloId
                            let fourth = data[3].friendName + "\n@" + data[3].friendYelloId
                            
                            self.votingList[VotingViewController.pushCount].friendId[0] = data[0].friendId
                            self.votingList[VotingViewController.pushCount].friendId[1] = data[1].friendId
                            self.votingList[VotingViewController.pushCount].friendId[2] = data[2].friendId
                            self.votingList[VotingViewController.pushCount].friendId[3] = data[3].friendId
                            
                            self.setNameText(first: first, second: second, third: third, fourth: fourth)
                        } else if data.count == 1 {
                            let first = data[0].friendName + "\n@" + data[0].friendYelloId
                            self.votingList[VotingViewController.pushCount].friendId[0] = data[0].friendId
                            self.setNameText(first: first, second: "", third: "", fourth: "")
                        } else if data.count == 2 {
                            let first = data[0].friendName + "\n@" + data[0].friendYelloId
                            let second = data[1].friendName + "\n@" + data[1].friendYelloId
                            self.votingList[VotingViewController.pushCount].friendId[0] = data[0].friendId
                            self.votingList[VotingViewController.pushCount].friendId[1] = data[1].friendId
                            self.setNameText(first: first, second: second, third: "", fourth: "")
                        } else if data.count == 3 {
                            let first = data[0].friendName + "\n@" + data[0].friendYelloId
                            let second = data[1].friendName + "\n@" + data[1].friendYelloId
                            let third = data[2].friendName + "\n@" + data[2].friendYelloId
                            self.votingList[VotingViewController.pushCount].friendId[0] = data[0].friendId
                            self.votingList[VotingViewController.pushCount].friendId[1] = data[1].friendId
                            self.votingList[VotingViewController.pushCount].friendId[2] = data[2].friendId
                            self.setNameText(first: first, second: second, third: third, fourth: "")
                        }
                        self.originView.suffleButton.isEnabled = true
                    default:
                        print("network failure")
                        return
                    }
                }
            }
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Amplitude.instance().logEvent("view_vote_question", withEventProperties: ["vote_step": VotingViewController.pushCount])
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
            $0.spacing = 10.adjusted
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
            $0.spacing = 10.adjusted
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
            $0.edges.equalToSuperview()
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
