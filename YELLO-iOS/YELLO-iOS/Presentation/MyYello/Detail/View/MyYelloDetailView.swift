//
//  MyYelloDetailView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

// MARK: - Protocol
protocol HandleInstagramButtonDelegate: AnyObject {
    func instagramButtonTapped()
}

final class MyYelloDetailView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    let myYelloDetailNavigationBarView = MyYelloDetailNavigationBarView()
    let detailSenderView = DetailSenderView()
    let genderLabel = UILabel()
    let detailKeywordView = DetailKeywordView()
    var pointLackView = PointLackView()
    var usePointView = UsePointView()
    var getHintView = GetHintView()
    var indexNumber: Int = 0
    var nameIndex: Int = -1
    
    lazy var instagramButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    lazy var keywordButton = HintButton(state: .keyword)
    lazy var senderButton = MyYelloButton(state: .yesTicket)
    
    let logoImageView = UIImageView()
    let groupImageView = UIImageView()
    let instagramIDLabel = UILabel()
    
    // MARK: Property
    weak var handleInstagramButtonDelegate: HandleInstagramButtonDelegate?
    var haveTicket: Bool = true {
        didSet {
            if haveTicket {
                senderButton.setButtonState(state: .yesTicket)
            } else {
                senderButton.setButtonState(state: .noTicket)
            }
        }
    }
    
    var isPlus: Bool = true
    var isRead: Bool = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                MyYelloListView.myYelloModelDummy[self.indexNumber].isRead = self.isRead
            }
        }
    }
    var isKeywordUsed: Bool = false {
        didSet {
            if self.isKeywordUsed == true {
                if isPlus {
                    keywordButton.setButtonState(state: .plus)
                } else {
                    keywordButton.setButtonState(state: .initial)
                }
                
                detailKeywordView.keywordLabel.isHidden = false
                detailKeywordView.questionLabel.isHidden = true
                MyYelloListView.myYelloModelDummy[indexNumber].isHintUsed = self.isKeywordUsed
            }
        }
    }
    
    var isSenderUsed: Bool = false {
        didSet {
            if self.isSenderUsed == true {
                keywordButton.isHidden = true
                senderButton.snp.makeConstraints {
                    $0.top.equalTo(instagramButton.snp.bottom).offset(77.adjustedHeight)
                }
                instagramButton.snp.makeConstraints {
                    $0.top.equalTo(detailKeywordView.snp.bottom).offset(44.adjustedHeight)
                }
            }
        }
    }
    
    var currentPoint: Int = 0 {
        didSet {
            self.myYelloDetailNavigationBarView.pointLabel.text = String(self.currentPoint)
            self.getHintView.pointLabel.text = String(self.currentPoint)
            self.pointLackView.pointLabel.text = String(self.currentPoint)
        }
    }
    
    var voteIdNumber: Int = 0
    var initialName: String = ""
    
    // MARK: - Function
    // MARK: Layout Helpers
    override func setStyle() {
        self.backgroundColor = .grayscales900
        
        detailSenderView.do {
            $0.isHidden = true
        }
        
        detailKeywordView.do {
            $0.isHidden = true
        }
        
        genderLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Detail.female, lineHeight: 16)
            $0.font = .uiLabelLarge
            $0.textColor = .white
            $0.isHidden = true
        }
        
        instagramButton.do {
            $0.backgroundColor = UIColor(white: 1.0, alpha: 0.35)
            $0.makeCornerRound(radius: 31)
            $0.layer.cornerCurve = .continuous
            $0.setImage(ImageLiterals.MyYello.imgInstagram, for: .normal)
            $0.addTarget(self, action: #selector(instagramButtonTapped), for: .touchUpInside)
            $0.isHidden = true
        }
        
        keywordButton.do {
            $0.addTarget(self, action: #selector(keywordButtonTapped), for: .touchUpInside)
            $0.isHidden = true
        }
        
        senderButton.do {
            $0.isHidden = true
        }
        
        logoImageView.do {
            $0.image = ImageLiterals.MyYello.imgLogo
            $0.contentMode = .scaleAspectFill
        }
        
        groupImageView.do {
            $0.image = ImageLiterals.MyYello.imgYelloGroup
        }
        
        instagramIDLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Detail.instagramID, lineHeight: 20)
            $0.font = .uiInstagram
            $0.textColor = .white
            $0.alpha = 0.6
        }
    }
    
    override func setLayout() {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 20
        
        self.addSubviews(myYelloDetailNavigationBarView,
                         detailSenderView,
                         genderLabel,
                         detailKeywordView,
                         instagramButton,
                         keywordButton,
                         senderButton)
        
        myYelloDetailNavigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets).offset(statusBarHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(48.adjustedHeight)
        }
        
        detailSenderView.snp.makeConstraints {
            $0.top.equalTo(myYelloDetailNavigationBarView.snp.bottom).offset(35.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(detailSenderView.snp.bottom).offset(8.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        detailKeywordView.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(42.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(154)
            $0.centerX.equalToSuperview()
        }
        
        instagramButton.snp.makeConstraints {
            $0.top.equalTo(detailKeywordView.snp.bottom).offset(44.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        
        keywordButton.snp.makeConstraints {
            $0.top.equalTo(instagramButton.snp.bottom).offset(46.adjustedHeight)
            $0.height.equalTo(54)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        senderButton.snp.makeConstraints {
            $0.top.equalTo(keywordButton.snp.bottom).offset(8.adjustedHeight)
            $0.height.equalTo(62.adjusted)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

// MARK: - extension
extension MyYelloDetailView {
    
    // MARK: Objc Function
    @objc private func instagramButtonTapped() {
        setInstagramUI()
        handleInstagramButtonDelegate?.instagramButtonTapped()
        endInstagram()
    }
    
    // MARK: Custom Function
    func setInstagramUI() {
        myYelloDetailNavigationBarView.isHidden = true
        instagramButton.isHidden = true
        keywordButton.isHidden = true
        senderButton.isHidden = true
        
        logoImageView.isHidden = false
        groupImageView.isHidden = false
        instagramIDLabel.isHidden = false
        
        self.addSubviews(logoImageView,
                         groupImageView,
                         instagramIDLabel)
        
        groupImageView.snp.makeConstraints {
            $0.top.equalTo(detailKeywordView.snp.bottom).offset(10.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(groupImageView.snp.bottom).offset(128.adjustedHeight)
            $0.width.equalTo(84)
            $0.height.equalTo(25)
            $0.centerX.equalToSuperview()
        }
        
        instagramIDLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(6.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
    }
    
    func endInstagram() {
        myYelloDetailNavigationBarView.isHidden = false
        instagramButton.isHidden = false
        senderButton.isHidden = false
        
        logoImageView.isHidden = true
        groupImageView.isHidden = true
        instagramIDLabel.isHidden = true
        
        if isSenderUsed == true {
            keywordButton.isHidden = true
        } else {
            keywordButton.isHidden = false
        }
    }
    
    func showLackAlert() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        pointLackView.removeFromSuperview()
        pointLackView = PointLackView()
        pointLackView.frame = viewController.view.bounds
        pointLackView.pointLabel.text = String(self.currentPoint)
        pointLackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.addSubview(pointLackView)
    }
    
    func showUsePointAlert() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        usePointView.removeFromSuperview()
        usePointView = UsePointView()
        usePointView.pointLabel.text = String(self.currentPoint)
        usePointView.frame = viewController.view.bounds
        usePointView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        usePointView.handleConfirmButtonDelegate = self
        viewController.view.addSubview(usePointView)
    }
    
    func showUseSenderPointAlert() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        usePointView.removeFromSuperview()
        usePointView = UsePointView()
        usePointView.pointLabel.text = String(self.currentPoint)
        usePointView.frame = viewController.view.bounds
        usePointView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        usePointView.handleConfirmButtonDelegate = self
        viewController.view.addSubview(usePointView)
        usePointView.titleLabel.text = "300" + StringLiterals.MyYello.Alert.senderPoint
        usePointView.confirmButton.setTitle(StringLiterals.MyYello.Alert.senderButton, for: .normal)
    }
    
    func showGetSenderHintAlert() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        getHintView.removeFromSuperview()
        getHintView = GetHintView()
        getHintView.frame = viewController.view.bounds
        getHintView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.addSubview(getHintView)
        getHintView.titleLabel.text = StringLiterals.MyYello.Alert.senderTitle
        
        getHintView.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(getHintView.titleLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        getHintView.pointView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(18.adjusted)
            $0.top.equalTo(getHintView.hintLabel.snp.bottom).offset(30.adjusted)
            $0.height.equalTo(52)
        }
    }
    
    func showGetHintAlert() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        getHintView.removeFromSuperview()
        getHintView = GetHintView()
        getHintView.frame = viewController.view.bounds
        getHintView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.addSubview(getHintView)
    }
    
    // MARK: Objc Function
    @objc private func keywordButtonTapped() {
        if currentPoint < 100 {
            showLackAlert()
        } else {
            if isKeywordUsed == true {
                if currentPoint < 300 {
                    showLackAlert()
                } else {
                    showUseSenderPointAlert()
                }
            } else {
                showUsePointAlert()
            }
        }
    }
    
    // MARK: - Network
    func myYelloDetailKeyword(voteId: Int) {
        NetworkService.shared.myYelloService.myYelloDetailKeyword(voteId: voteId) { response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                
                self.detailKeywordView.keywordLabel.isHidden = false
                self.detailKeywordView.questionLabel.isHidden = true
                self.detailKeywordView.keywordLabel.text = data.answer
                self.getHintView.hintLabel.text = data.answer
                
                dump(data)
                print("키워드 통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
    
    func myYelloDetailName(voteId: Int) {
        NetworkService.shared.myYelloService.myYelloDetailName(voteId: voteId) { response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                
                if let initial = self.getFirstInitial(data.name as NSString, index: 0) {
                    self.initialName = initial
                    self.detailSenderView.senderLabel.text = initial
                    self.getHintView.hintLabel.text = initial
                }
//                self.nameIndex = data.nameIndex
                MyYelloListView.myYelloModelDummy[self.indexNumber].nameHint = data.nameIndex
                
                dump(data)
                print("이름 통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
    
    func getFirstInitial(_ str: NSString, index: Int) -> String? {
        let name = str
        var initialName: String = ""
        
        for i in 0..<1 {
            let oneChar: UniChar = name.character(at: i)
            if oneChar >= 0xAC00 && oneChar <= 0xD7A3 {
                var firstCodeValue = ((oneChar - 0xAC00)/28)/21
                firstCodeValue += 0x1100
                initialName = initialName.appending(String(format: "%C", firstCodeValue))
            } else {
                initialName = initialName.appending(String(format: "%C", oneChar))
            }
        }
        return initialName
    }
}

// MARK: HandleConfirmButtonDelegate
extension MyYelloDetailView: HandleConfirmButtonDelegate {
    func confirmButtonTapped() {
        if self.isKeywordUsed == false {
            showGetHintAlert()
            myYelloDetailKeyword(voteId: voteIdNumber)
            
            self.currentPoint -= 100
            self.isKeywordUsed.toggle()
        } else {
            showGetSenderHintAlert()
            myYelloDetailName(voteId: voteIdNumber)
            self.isSenderUsed = true
            self.currentPoint -= 300
        }
        
        self.myYelloDetailNavigationBarView.pointLabel.text = String(self.currentPoint)
        self.usePointView.pointLabel.text = String(self.currentPoint)
    }
}
