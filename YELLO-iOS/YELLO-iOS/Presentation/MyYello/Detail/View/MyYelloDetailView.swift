//
//  MyYelloDetailView.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import Amplitude
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
    var useTicketView = UseTicketView()
    var getFullNameView = GetFullNameView()
    var indexNumber: Int = -1
    var nameIndex: Int = -1
    
    lazy var instagramButton = InstagramButton(frame: CGRect(x: 0, y: 0, width: 60.adjusted, height: 60.adjusted))
    let instagramLabel = UILabel()
    lazy var instagramView = UIView()
    
    lazy var keywordButton = HintButton(state: .keyword)
    lazy var senderButton = MyYelloButton(state: .noTicket)
    
    let logoImageView = UIImageView()
    let groupImageView = UIImageView()
    let instagramIDLabel = UILabel()
    
    // MARK: Property
    weak var handleInstagramButtonDelegate: HandleInstagramButtonDelegate?
    var haveTicket: Bool = false {
        didSet {
            if haveTicket {
                senderButton.setButtonState(state: .yesTicket)
                senderButton.keyCountLabel.text = String(self.ticketCount)
                if isTicketUsed {
                    senderButton.setButtonState(state: .useTicket)
                }
                if nameIndex == -3 {
                    senderButton.setButtonState(state: .noTicket)
                }
            } else {
                senderButton.setButtonState(state: .noTicket)
                if isTicketUsed {
                    senderButton.setButtonState(state: .useTicket)
                }
            }
        }
    }
    var isTicketUsed: Bool = false {
        didSet {
            if isKeywordUsed == true {
                senderButton.setButtonState(state: .useTicket)
                keywordButton.isHidden = true
                senderButton.snp.makeConstraints {
                    $0.top.equalTo(instagramView.snp.bottom).offset(77.adjustedHeight)
                }
                if self.nameIndex == -3 {
                    senderButton.setButtonState(state: .noTicket)
                }
            }
        }
    }
    
    var isPlus: Bool = false
    var ticketCount: Int = 0 {
        didSet {
            if ticketCount == 0 {
                haveTicket = false
            } else {
                haveTicket = true
            }
        }
    }
    
    var isRead: Bool = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                if self.indexNumber != -1 {
                    MyYelloListView.myYelloModelDummy[self.indexNumber].isRead = self.isRead
                }
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
                
                if isTicketUsed {
                    keywordButton.isHidden = true
                    senderButton.snp.makeConstraints {
                        $0.top.equalTo(instagramView.snp.bottom).offset(77.adjustedHeight)
                    }
                }
                
                self.detailKeywordView.keywordLabel.isHidden = false
                self.detailKeywordView.questionLabel.isHidden = true
                if self.indexNumber != -1 {
                    MyYelloListView.myYelloModelDummy[indexNumber].isHintUsed = self.isKeywordUsed
                }
            }
        }
    }
    
    var isSenderUsed: Bool = false {
        didSet {
            if self.isSenderUsed == true {
                keywordButton.isHidden = true
                senderButton.snp.makeConstraints {
                    $0.top.equalTo(instagramView.snp.bottom).offset(77.adjustedHeight)
                }
                
                instagramView.snp.makeConstraints {
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
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Detail.female, lineHeight: 16.adjustedHeight)
            $0.font = .uiLabelLarge
            $0.textColor = .white
            $0.isHidden = true
        }
        
        instagramView.do {
            $0.isHidden = true
        }
        
        instagramButton.do {
            $0.backgroundColor = UIColor(white: 1.0, alpha: 0.35)
            $0.makeCornerRound(radius: 30.adjusted)
            $0.layer.cornerCurve = .continuous
            $0.setImage(ImageLiterals.MyYello.imgInstagram, for: .normal)
            $0.addTarget(self, action: #selector(instagramButtonTapped), for: .touchUpInside)
        }
        
        instagramLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Detail.instagram, lineHeight: 20.adjustedHeight)
            $0.textColor = .white
            $0.font = .uiBodySmall
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
            $0.setTextWithLineHeight(text: StringLiterals.MyYello.Detail.instagramID, lineHeight: 20.adjustedHeight)
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
                         instagramView,
                         keywordButton,
                         senderButton)
        
        instagramView.addSubviews(instagramButton,
                                  instagramLabel)
        
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
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(154.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        instagramView.snp.makeConstraints {
            $0.top.equalTo(detailKeywordView.snp.bottom).offset(33.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(84.adjustedHeight)
            $0.width.equalTo(89.adjustedWidth)
        }
        
        instagramButton.snp.makeConstraints {
            $0.width.height.equalTo(60.adjusted)
            $0.top.centerX.equalToSuperview()
        }
        
        instagramLabel.snp.makeConstraints {
            $0.top.equalTo(instagramButton.snp.bottom).offset(4.adjustedHeight)
            $0.width.equalTo(89.adjustedWidth)
            $0.centerX.bottom.equalToSuperview()
        }
        
        keywordButton.snp.makeConstraints {
            $0.top.equalTo(instagramView.snp.bottom).offset(33.adjustedHeight)
            $0.height.equalTo(54.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
        }
        
        senderButton.snp.makeConstraints {
            $0.top.equalTo(keywordButton.snp.bottom).offset(8.adjustedHeight)
            $0.height.equalTo(62.adjusted)
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
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
        instagramView.isHidden = true
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
            $0.width.equalTo(84.adjustedWidth)
            $0.height.equalTo(25.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        instagramIDLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(6.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
    }
    
    func endInstagram() {
        myYelloDetailNavigationBarView.isHidden = false
        instagramView.isHidden = false
        senderButton.isHidden = false
        
        logoImageView.isHidden = true
        groupImageView.isHidden = true
        instagramIDLabel.isHidden = true
        
        if isSenderUsed == true || isTicketUsed == true && isKeywordUsed == true {
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
        Amplitude.instance().logEvent("click_open_keyword")
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
        if self.isPlus {
            usePointView.titleLabel.text = "0" + StringLiterals.MyYello.Alert.senderPoint
        } else {
            usePointView.titleLabel.text = "300" + StringLiterals.MyYello.Alert.senderPoint
        }
        usePointView.confirmButton.setTitle(StringLiterals.MyYello.Alert.senderButton, for: .normal)
        Amplitude.instance().logEvent("click_open_firstletter")
    }
    
    func showUseTicketAlert() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        useTicketView.removeFromSuperview()
        useTicketView = UseTicketView()
        useTicketView.ticketLabel.text = String(self.ticketCount)
        useTicketView.frame = viewController.view.bounds
        useTicketView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        useTicketView.handleConfirmTicketButtonDelegate = self
        Amplitude.instance().logEvent("click_open_fullname")
        viewController.view.addSubview(useTicketView)
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
            $0.top.equalTo(getHintView.titleLabel.snp.bottom).offset(4.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
    }
    
    func showGetFullNameAlert() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        getFullNameView.removeFromSuperview()
        getFullNameView = GetFullNameView()
        getFullNameView.frame = viewController.view.bounds
        getFullNameView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.view.addSubview(getFullNameView)
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
        if currentPoint < 100 && isPlus == false {
            showLackAlert()
        } else {
            if isKeywordUsed == true {
                if currentPoint < 300 && isPlus == false {
                    showLackAlert()
                } else {
                    showUseSenderPointAlert()
                }
            } else {
                if currentPoint < 100 {
                    showLackAlert()
                } else {
                    showUsePointAlert()
                    Amplitude.instance().logEvent("click_open_keyword")
                }
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
                
                Amplitude.instance().logEvent("view_open_keyword")
                
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
                    
                    if self.isPlus {
                        Amplitude.instance().logEvent("view_open_firstletter", withEventProperties: ["subscription type":"sub_yes"])
                    } else {
                        Amplitude.instance().logEvent("view_open_firstletter", withEventProperties: ["subscription type":"sub_no"])
                    }
                    
                }
                self.nameIndex = data.nameIndex
                if self.indexNumber != -1 {
                    MyYelloListView.myYelloModelDummy[self.indexNumber].nameHint = data.nameIndex
                }
                
                dump(data)
                print("이름 통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
    
    func myYelloDetailFullName(voteId: Int) {
        NetworkService.shared.myYelloService.myYelloDetailFullName(voteId: voteId) { response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                
                let initial = data.name
                self.initialName = initial
                self.detailSenderView.senderLabel.text = initial
                self.getFullNameView.hintLabel.text = initial
                self.getFullNameView.ticketLabel.text = String(self.ticketCount - 1)
                self.isTicketUsed = true
                self.senderButton.setButtonState(state: .useTicket)
                
                if self.indexNumber != -1 {
                    MyYelloListView.myYelloModelDummy[self.indexNumber].nameHint = -2
                }
                
                
                if !self.isKeywordUsed {
                    Amplitude.instance().logEvent("view_open_fullnamefirst")
                } else {
                    Amplitude.instance().logEvent("view_open_fullname")
                }
                
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
            Amplitude.instance().logEvent("click_modal_keyword_yes")
            self.isKeywordUsed.toggle()
        } else {
            showGetSenderHintAlert()
            myYelloDetailName(voteId: voteIdNumber)
            self.isSenderUsed = true
            
            if !isPlus {
                self.currentPoint -= 300
                Amplitude.instance().logEvent("click_modal_firstletter_yes")
            } else {
                self.myYelloDetailNavigationBarView.pointLabel.text = String(self.currentPoint)
                self.getHintView.pointLabel.text = String(self.currentPoint)
                self.pointLackView.pointLabel.text = String(self.currentPoint)
            }
        }
        
        self.myYelloDetailNavigationBarView.pointLabel.text = String(self.currentPoint)
        self.usePointView.pointLabel.text = String(self.currentPoint)
    }
}

extension MyYelloDetailView: HandleConfirmTicketButtonDelegate {
    func confirmTicketButtonTapped() {
        useTicketView.isFullnameFirst = !isKeywordUsed
        showGetFullNameAlert()
        myYelloDetailFullName(voteId: voteIdNumber)
    }
}
