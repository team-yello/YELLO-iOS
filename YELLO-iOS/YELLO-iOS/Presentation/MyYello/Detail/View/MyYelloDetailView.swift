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
    var nameIndex: Int = 0
    
    lazy var instagramButton = UIButton()
    lazy var keywordButton = UIButton()
    lazy var senderButton = UIButton()
    
    let logoImageView = UIImageView()
    let logoLabel = UILabel()
    let groupImageView = UIImageView()
    
    // MARK: Property
    weak var handleInstagramButtonDelegate: HandleInstagramButtonDelegate?
    var isRead: Bool = false {
        didSet {
            MyYelloListView.myYelloModelDummy[indexNumber].isRead = self.isRead
        }
    }
    var isKeywordUsed: Bool = false {
        didSet {
            if self.isKeywordUsed == true {
                keywordButton.setTitle(StringLiterals.MyYello.Detail.sendButton, for: .normal)
                detailKeywordView.keywordLabel.isHidden = false
                detailKeywordView.questionLabel.isHidden = true
            }
        }
    }
    
    var isSenderUsed: Bool = false {
        didSet {
            if self.isSenderUsed == true {
                keywordButton.isHidden = true
                senderButton.snp.makeConstraints {
                    $0.bottom.equalToSuperview().inset(94.adjustedHeight)
                }
                instagramButton.snp.makeConstraints {
                    $0.bottom.equalTo(senderButton.snp.top).offset(-24.adjustedHeight)
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
        self.backgroundColor = .black
        
        genderLabel.do {
            $0.setTextWithLineHeight(text: "", lineHeight: 16)
            $0.font = .uiLabelLarge
            $0.textColor = .white
        }
        
        instagramButton.do {
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 8
            $0.titleLabel?.font = .uiBody03
            $0.setTitleColor(.white, for: .normal)
            $0.setImage(ImageLiterals.MyYello.imgInstagram, for: .normal)
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 4)
            $0.setTitle(StringLiterals.MyYello.Detail.instagram, for: .normal)
            $0.addTarget(self, action: #selector(instagramButtonTapped), for: .touchUpInside)
        }
        
        keywordButton.do {
            $0.backgroundColor = UIColor(hex: "FFFFFF", alpha: 0.35)
            $0.layer.cornerRadius = 8
            $0.titleLabel?.font = .uiBodyMedium
            $0.setTitleColor(.black, for: .normal)
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 4)
            $0.setTitle(StringLiterals.MyYello.Detail.keywordButton, for: .normal)
            $0.addTarget(self, action: #selector(keywordButtonTapped), for: .touchUpInside)
        }
        
        senderButton.do {
            $0.backgroundColor = .yelloMain500
            $0.layer.cornerRadius = 8
            $0.titleLabel?.font = .uiSubtitle03
            $0.setTitleColor(.black, for: .normal)
            $0.setImage(ImageLiterals.MyYello.icLock, for: .normal)
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 4)
            $0.setTitle(StringLiterals.MyYello.Detail.senderButton, for: .normal)
        }
        
        logoImageView.do {
            $0.image = ImageLiterals.MyYello.imgLogo
        }
        
        logoLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Detail.logoTitle, lineHeight: 16)
            $0.font = .uiLabelLarge
            $0.textColor = .white
        }
        
        groupImageView.do {
            $0.image = ImageLiterals.MyYello.imgYelloGroup
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
            $0.bottom.equalTo(keywordButton.snp.top).offset(-24.adjustedHeight)
            $0.height.equalTo(20)
            $0.width.equalTo(129)
            $0.centerX.equalToSuperview()
        }
        
        keywordButton.snp.makeConstraints {
            $0.bottom.equalTo(senderButton.snp.top).inset(-10.adjustedHeight)
            $0.height.equalTo(54)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        senderButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(38.adjustedHeight)
            $0.height.equalTo(54)
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
        logoLabel.isHidden = false
        groupImageView.isHidden = false
        
        self.addSubviews(logoImageView,
                         logoLabel,
                         groupImageView)
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(detailKeywordView.snp.bottom).offset(87.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        logoLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(10.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        groupImageView.snp.makeConstraints {
            $0.top.equalTo(logoLabel.snp.bottom).offset(52.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
    }
    
    func endInstagram() {
        myYelloDetailNavigationBarView.isHidden = false
        instagramButton.isHidden = false
        senderButton.isHidden = false
        
        logoImageView.isHidden = true
        logoLabel.isHidden = true
        groupImageView.isHidden = true
        
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
                self.nameIndex = data.nameIndex
                
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
