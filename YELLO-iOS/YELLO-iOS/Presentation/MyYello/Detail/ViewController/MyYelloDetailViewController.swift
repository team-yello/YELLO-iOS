//
//  MyYelloDetailViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import Amplitude
import SnapKit
import Then

struct MyYelloBackgroundColorStringDummy {
    let backgroundColorTop: String
    let backgroundColorBottom: String
}

final class MyYelloDetailViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Constants
    let myYelloDetailView = MyYelloDetailView()
    var colorIndex: Int = 1
    
    var myYelloBackgroundColorStringDummy: [MyYelloBackgroundColorStringDummy] =
    [MyYelloBackgroundColorStringDummy(backgroundColorTop: BackGroundColor.BackgroundColorTop.one,
                                       backgroundColorBottom: BackGroundColor.BackgroundColorBottom.one),
     MyYelloBackgroundColorStringDummy(backgroundColorTop: BackGroundColor.BackgroundColorTop.two,
                                       backgroundColorBottom: BackGroundColor.BackgroundColorBottom.two),
     MyYelloBackgroundColorStringDummy(backgroundColorTop: BackGroundColor.BackgroundColorTop.three,
                                       backgroundColorBottom: BackGroundColor.BackgroundColorBottom.three),
     MyYelloBackgroundColorStringDummy(backgroundColorTop: BackGroundColor.BackgroundColorTop.four,
                                       backgroundColorBottom: BackGroundColor.BackgroundColorBottom.four),
     MyYelloBackgroundColorStringDummy(backgroundColorTop: BackGroundColor.BackgroundColorTop.five,
                                       backgroundColorBottom: BackGroundColor.BackgroundColorBottom.five),
     MyYelloBackgroundColorStringDummy(backgroundColorTop: BackGroundColor.BackgroundColorTop.six,
                                       backgroundColorBottom: BackGroundColor.BackgroundColorBottom.six),
     MyYelloBackgroundColorStringDummy(backgroundColorTop: BackGroundColor.BackgroundColorTop.seven,
                                       backgroundColorBottom: BackGroundColor.BackgroundColorBottom.seven),
     MyYelloBackgroundColorStringDummy(backgroundColorTop: BackGroundColor.BackgroundColorTop.eight,
                                       backgroundColorBottom: BackGroundColor.BackgroundColorBottom.eight),
     MyYelloBackgroundColorStringDummy(backgroundColorTop: BackGroundColor.BackgroundColorTop.nine,
                                       backgroundColorBottom: BackGroundColor.BackgroundColorBottom.nine),
     MyYelloBackgroundColorStringDummy(backgroundColorTop: BackGroundColor.BackgroundColorTop.ten,
                                       backgroundColorBottom: BackGroundColor.BackgroundColorBottom.ten),
     MyYelloBackgroundColorStringDummy(backgroundColorTop: BackGroundColor.BackgroundColorTop.eleven,
                                       backgroundColorBottom: BackGroundColor.BackgroundColorBottom.eleven),
     MyYelloBackgroundColorStringDummy(backgroundColorTop: BackGroundColor.BackgroundColorTop.tweleve,
                                       backgroundColorBottom: BackGroundColor.BackgroundColorBottom.tweleve)]
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setAddTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Amplitude.instance().logEvent("view_open_message")
        myYelloDetailView.openedView()
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(popViewController(_:)), name: NSNotification.Name("popView"), object: nil)
        
    }
    
    // MARK: Layout Helpers
    override func setStyle() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        myYelloDetailView.isRead = true
    }
    
    override func setLayout() {
        view.addSubviews(myYelloDetailView)
        
        myYelloDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - extension
extension MyYelloDetailViewController {
    
    // MARK: Custom Function
    private func setDelegate() {
        myYelloDetailView.myYelloDetailNavigationBarView.handleBackButtonDelegate = self
        myYelloDetailView.handleInstagramButtonDelegate = self
    }
    
    // MARK: objc Function
    private func setAddTarget() {
        myYelloDetailView.senderButton.addTarget(self, action: #selector(senderButtonTapped), for: .touchUpInside)
        myYelloDetailView.pointLackView = PointLackView()
    }
    
    @objc private func senderButtonTapped() {
        if myYelloDetailView.haveTicket {
            myYelloDetailView.showUseTicketAlert()
        } else {
            let paymentPlusViewController = PaymentPlusViewController()
            if myYelloDetailView.isKeywordUsed && !(myYelloDetailView.isPlus) && !(myYelloDetailView.isSenderUsed) {
                Amplitude.instance().logEvent("click_go_shop", withEventProperties: ["shop_button": "cta_keyword_nosub"])
            } else if myYelloDetailView.isKeywordUsed && myYelloDetailView.isPlus && !(myYelloDetailView.isSenderUsed) {
                Amplitude.instance().logEvent("click_go_shop", withEventProperties: ["shop_button": "cta_keyword_sub"])
            } else if myYelloDetailView.isSenderUsed {
                Amplitude.instance().logEvent("click_go_shop", withEventProperties: ["shop_button": "cta_firstletter"])
            } else if !myYelloDetailView.isKeywordUsed && !myYelloDetailView.isSenderUsed {
                Amplitude.instance().logEvent("click_go_shop", withEventProperties: ["shop_button": "cta_nothing"])
            }
            
            navigationController?.pushViewController(paymentPlusViewController, animated: true)
        }
    }
    
    func setBackgroundView() {
        if colorIndex == 2 || colorIndex == 5 || colorIndex == 6 {
            myYelloDetailView.myYelloDetailNavigationBarView.backButton.setImage(ImageLiterals.MyYello.icArrowLeft, for: .normal)
            myYelloDetailView.myYelloDetailNavigationBarView.pointImageView.image = ImageLiterals.MyYello.icPointBlack
            myYelloDetailView.myYelloDetailNavigationBarView.pointLabel.textColor = .black
            myYelloDetailView.detailSenderView.sendLabel.textColor = .black
            myYelloDetailView.genderLabel.textColor = .black
            myYelloDetailView.senderButton.findLabel.textColor = .black
            myYelloDetailView.instagramButton.setTitleColor(.black, for: .normal)
        }
        
        let gradientView = UIView(frame: view.bounds)
        if colorIndex <= 0 || colorIndex >= 13 {
            colorIndex = 5
        }
        
        gradientView.applyGradientBackground(
            topColor: UIColor(hex: myYelloBackgroundColorStringDummy[colorIndex - 1].backgroundColorTop),
            bottomColor: UIColor(hex: myYelloBackgroundColorStringDummy[colorIndex - 1].backgroundColorBottom))
        myYelloDetailView.insertSubview(gradientView, at: 0)
    }
    
    // MARK: - Network
    func myYelloDetail(voteId: Int) {
        NetworkService.shared.myYelloService.myYelloDetail(voteId: voteId) { response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                
                self.colorIndex = data.colorIndex
                self.myYelloDetailView.currentPoint = data.currentPoint
                self.myYelloDetailView.detailSenderView.isHidden = false
                self.myYelloDetailView.detailKeywordView.isHidden = false
                self.myYelloDetailView.genderLabel.isHidden = false
                self.myYelloDetailView.instagramButton.isHidden = false
                self.myYelloDetailView.keywordButton.isHidden = false
                self.myYelloDetailView.senderButton.isHidden = false
                self.setBackgroundView()
                
                if data.senderGender == "MALE" {
                    self.myYelloDetailView.genderLabel.text = StringLiterals.MyYello.Detail.male
                } else {
                    self.myYelloDetailView.genderLabel.text = StringLiterals.MyYello.Detail.female
                }
                
                if data.vote.nameHead == nil {
                    self.myYelloDetailView.detailKeywordView.nameKeywordLabel.text = "너" + (data.vote.nameFoot ?? "")
                } else {
                    self.myYelloDetailView.detailKeywordView.nameKeywordLabel.text = (data.vote.nameHead ?? "") + " 너" + (data.vote.nameFoot ?? "")
                }
                
                self.myYelloDetailView.detailKeywordView.keywordHeadLabel.text = (data.vote.keywordHead ?? "")
                self.myYelloDetailView.detailKeywordView.keywordLabel.text = data.vote.keyword
                self.myYelloDetailView.detailKeywordView.keywordFootLabel.text = (data.vote.keywordFoot ?? "")
                
                self.myYelloDetailView.isKeywordUsed = data.isAnswerRevealed
                
                if data.nameHint == 0 {
                    self.myYelloDetailView.isSenderUsed = true
                    if let initial = self.getFirstInitial(data.senderName as NSString, index: 0) {
                        self.myYelloDetailView.detailSenderView.senderLabel.text = initial
                    }
                } else if data.nameHint == 1 {
                    self.myYelloDetailView.isSenderUsed = true
                    if let initial = self.getSecondInitial(data.senderName as NSString, index: 1) {
                        self.myYelloDetailView.detailSenderView.senderLabel.text = initial
                    }
                } else if data.nameHint == -3 {
                    self.myYelloDetailView.isSenderUsed = true
                    self.myYelloDetailView.detailSenderView.senderLabel.text = data.senderName
                    self.myYelloDetailView.isKeywordUsed = true
                    self.myYelloDetailView.senderButton.setButtonState(state: .noTicket)
                    self.myYelloDetailView.keywordButton.isHidden = true
                    self.myYelloDetailView.haveTicket = false
                    self.myYelloDetailView.senderButton.snp.makeConstraints {
                        $0.top.equalTo(self.myYelloDetailView.instagramButton.snp.bottom).offset(77.adjustedHeight)
                    }
                } else if data.nameHint == -2 {
                    self.myYelloDetailView.isTicketUsed = true
                    self.myYelloDetailView.detailSenderView.senderLabel.text = data.senderName
                    self.myYelloDetailView.isKeywordUsed = data.isAnswerRevealed
                }
                
                // DTO 추가
                if data.isSubscribe {
                    self.myYelloDetailView.isPlus = true
                }
                
                self.myYelloDetailView.ticketCount = data.ticketCount
                
                dump(data)
                print("통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
    
    // MARK: Custom Function
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
    
    func getSecondInitial(_ str: NSString, index: Int) -> String? {
        let name = str
        var initialName: String = ""
        
        for i in 1..<2 {
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
    
    @objc
    func popViewController(_ notification: Notification) {
        tabBarController?.tabBar.items?[2].imageInsets = UIEdgeInsets(top: -23, left: 0, bottom: 0, right: 0)
        tabBarController?.selectedIndex = 2
        popView()
    }
}

// MARK: HandleBackButtonDelegate
extension MyYelloDetailViewController: HandleBackButtonDelegate {
    func popView() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: HandleInstagramButtonDelegate
extension MyYelloDetailViewController: HandleInstagramButtonDelegate {
    @objc func instagramButtonTapped() {
        
        if myYelloDetailView.isKeywordUsed && !(myYelloDetailView.isPlus) {
            Amplitude.instance().logEvent("click_instagram", withEventProperties: ["insta_view": "keyword"])
        } else if myYelloDetailView.isSenderUsed {
            Amplitude.instance().logEvent("click_instagram", withEventProperties: ["insta_view": "firstletter"])
        } else if !myYelloDetailView.isKeywordUsed && !myYelloDetailView.isSenderUsed {
            Amplitude.instance().logEvent("click_instagram", withEventProperties: ["insta_view": "message"])
        }
        
        if let storyShareURL = URL(string: "instagram-stories://share?source_application=" + Config.metaAppID) {
            
            if UIApplication.shared.canOpenURL(storyShareURL) {
                let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
                
                let renderImage = renderer.image { _ in
                    view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
                }
                
                let topColor = "#" + myYelloBackgroundColorStringDummy[colorIndex - 1].backgroundColorTop
                let bottomColor = "#" + myYelloBackgroundColorStringDummy[colorIndex - 1].backgroundColorBottom
                
                guard let imageData = renderImage.pngData() else {return}
                let pasteboardItems: [String: Any] = [
                    "com.instagram.sharedSticker.backgroundImage": imageData,
                    "com.instagram.sharedSticker.backgroundTopColor": topColor, "com.instagram.sharedSticker.backgroundBottomColor": bottomColor
                ]
                let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300)]
                UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
                UIApplication.shared.open(storyShareURL, options: [:], completionHandler: nil)
            } else {
                let url = URL(string: "https://apps.apple.com/kr/app/instagram/id389801252")!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
