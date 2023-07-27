//
//  MyYelloDetailViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyYelloDetailViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Constants
    let myYelloDetailView = MyYelloDetailView()
    let dummy = myYelloBackgroundColorDummy
    let hexDummy = myYelloBackgroundColorStringDummy
    var colorIndex: Int = 0
    var isYelloButtonTapped: Bool = false {
        didSet {
            let votingStartViewController = YELLOTabBarController()
            self.navigationController?.navigationBar.isHidden = true
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: votingStartViewController)
        }
    }
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setAddTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
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
        let paymentViewController = PaymentViewController()
        navigationController?.pushViewController(paymentViewController, animated: true)
    }
    
    private func setBackgroundView() {
        if colorIndex == 1 || colorIndex == 3 || colorIndex == 7 {
            myYelloDetailView.myYelloDetailNavigationBarView.backButton.setImage(ImageLiterals.MyYello.icArrowLeft, for: .normal)
            myYelloDetailView.myYelloDetailNavigationBarView.pointImageView.image = ImageLiterals.MyYello.icPointBlack
            myYelloDetailView.myYelloDetailNavigationBarView.pointLabel.textColor = .black
            myYelloDetailView.detailSenderView.sendLabel.textColor = .black
            myYelloDetailView.genderLabel.textColor = .black
            myYelloDetailView.instagramButton.setTitleColor(.black, for: .normal)
        }
        
        let gradientView = CAGradientLayer()
        gradientView.frame = view.bounds
        if dummy.isEmpty {
            gradientView.colors = [UIColor(hex: "6437FF"), UIColor(hex: "A892FF")]
        } else {
                gradientView.colors = [self.dummy[self.colorIndex].backgroundColorTop.cgColor, self.dummy[self.colorIndex].backgroundColorBottom.cgColor]
        }
        
        gradientView.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientView.endPoint = CGPoint(x: 1.0, y: 1.0)
        myYelloDetailView.layer.insertSublayer(gradientView, at: 0)
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
                }
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
        if let storyShareURL = URL(string: "instagram-stories://share?source_application=" + Config.metaAppID) {
            
            if UIApplication.shared.canOpenURL(storyShareURL) {
                let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
                
                let renderImage = renderer.image { _ in
                    view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
                }
                
                let topColor = "#" + hexDummy[colorIndex].backgroundColorTop
                let bottomColor = "#" + hexDummy[colorIndex].backgroundColorBottom
                
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
