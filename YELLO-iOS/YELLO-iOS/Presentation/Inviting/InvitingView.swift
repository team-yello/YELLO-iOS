//
//  BaseSharingView.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/07.
//

import UIKit

import SnapKit
import Then
import KakaoSDKShare

final class InvitingView: BaseView {
    
    let contentsView = UIView()

    // 컴포넌트 위치 순서대로
    let closeButton = UIButton()

    let titleLabel = UILabel()
    let textLabel = UILabel()
    
    let backGroundView = UIView()
    let recommender = UILabel()
    let recommenderID = UILabel()
    
    lazy var kakaoButton = UIButton()
    lazy var copyButton = UIButton()
    
    // MARK: - Style
    
    override func setStyle() {
        self.backgroundColor = .black.withAlphaComponent(0.5)
        
        contentsView.makeCornerRound(radius: 10.adjustedHeight)
        contentsView.backgroundColor = .white
        
        closeButton.do {
            $0.setTitle("닫기", for: .normal)
            $0.setImage(ImageLiterals.InvitingPopUp.icClose, for: .normal)
            $0.setTitleColor(.grayscales600, for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.titleLabel?.font = .uiLabelLarge
            $0.contentHorizontalAlignment = .center
            $0.semanticContentAttribute = .forceRightToLeft
            $0.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Inviting.unLockedTitle, lineHeight: 24)
            $0.textColor = .black
            $0.font = .uiHeadline04
        }
        
        textLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Inviting.unLockedText, lineHeight: 20)
            $0.numberOfLines = 2
            $0.textColor = .grayscales600
            $0.font = .uiBody03
            $0.asColor(targetString: "바로 투표", color: .black)
        }
        
        backGroundView.do {
            $0.backgroundColor = .grayscales50
            $0.makeCornerRound(radius: 8.adjustedHeight)
        }
        
        recommender.do {
            $0.setTextWithLineHeight(text: "내 추천인 코드", lineHeight: 20)
            $0.textColor = .purpleSub500
            $0.font = .uiBody04
        }
        
        recommenderID.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 32)
            $0.textColor = .black
            $0.font = .uiExtraLarge
        }
        
        kakaoButton.do {
            $0.setImage(ImageLiterals.InvitingPopUp.icKakaoShare, for: .normal)
            $0.addTarget(self, action: #selector(kakaoButtonClicked), for: .touchUpInside)
        }
        
        copyButton.do {
            $0.setImage(ImageLiterals.InvitingPopUp.icLinkCopy, for: .normal)
            $0.addTarget(self, action: #selector(copyButtonClicked), for: .touchUpInside)
        }
    }
    
    // MARK: - Layout
    
    override func setLayout() {
        self.addSubview(contentsView)
        
        contentsView.addSubviews(closeButton,
                         titleLabel,
                         textLabel,
                         backGroundView,
                         kakaoButton,
                         copyButton)
        
        backGroundView.addSubviews(recommender,
                                   recommenderID)
        
        contentsView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(300.adjustedWidth)
            $0.height.equalTo(374.adjustedHeight)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14.adjustedHeight)
            $0.trailing.equalToSuperview().inset(14.adjustedWidth)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        backGroundView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(14.adjustedWidth)
            $0.top.equalTo(textLabel.snp.bottom).offset(20.adjustedHeight)
            $0.height.equalTo(108.adjustedHeight)
        }
        
        recommender.snp.makeConstraints {
            $0.top.equalToSuperview().inset(37.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        recommenderID.snp.makeConstraints {
            $0.top.equalTo(recommender.snp.bottom).offset(2.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        kakaoButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(100.adjustedWidth)
            $0.bottom.equalToSuperview().inset(50.adjustedHeight)
        }
        
        copyButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(100.adjustedWidth)
            $0.bottom.equalToSuperview().inset(50.adjustedHeight)
        }
    }
}

extension InvitingView {
    
    func updateText(title: String, text: String, targetString: String) {
        titleLabel.setTextWithLineHeight(text: title, lineHeight: 24)
        textLabel.setTextWithLineHeight(text: text, lineHeight: 20)
        textLabel.asColor(targetString: targetString, color: .black)
    }
    
    @objc
    func closeButtonClicked() {
        self.isHidden = true
        self.removeFromSuperview()
    }
    
    @objc
    func kakaoButtonClicked() {
//        let templateId = 95890
        let templateId = 96906
        guard let filteredString = self.recommenderID.text else { return }
        let recommenderID = String(filteredString.dropFirst())
        UIPasteboard.general.string = recommenderID
        
        // 카카오톡 설치여부 확인
        if ShareApi.isKakaoTalkSharingAvailable() {
            // 카카오톡으로 카카오톡 공유 가능
            ShareApi.shared.shareCustom(templateId: Int64(templateId),
                                        templateArgs: ["KEY": "\(recommenderID)"]) {(sharingResult, error) in
                if let error = error {
                    print(error)
                } else {
                    print("shareCustom() success.")
                    if let sharingResult = sharingResult {
                        UIApplication.shared.open(sharingResult.url, options: [:], completionHandler: nil)
                    }
                }
            }
        } else {
            // 카카오톡 미설치: 웹 공유 사용 권장
            if ShareApi.shared.makeCustomUrl(templateId: Int64(templateId),
                                             templateArgs: ["${KEY}": "제목입니다."]) != nil {
                print("error")
            }
        }
    }
    
    @objc
    func copyButtonClicked() {
        guard let recommender = self.recommenderID.text else { return }
        let filteredID = String(recommender.dropFirst())
        let recommenderID = "추천인코드: " + filteredID + "\n\n우리 같이 YELL:O 해요!\nAndroid: https://play.google.com/store/apps/details?id=com.el.yello&hl=ko&gl=KR\niOS: https://apps.apple.com/app/id6451451050"
        UIPasteboard.general.string = recommenderID
        print(UIPasteboard.general.string ?? "")
        
        self.showToast(message: StringLiterals.Inviting.toastMessage)
    }
    
    // MARK: - Network
    func profileUserYelloId() {
        NetworkService.shared.profileService.profileUser { response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                self.copyButton.isEnabled = false
                self.kakaoButton.isEnabled = false
                self.recommenderID.text = "@" + data.yelloId
                self.copyButton.isEnabled = true
                self.kakaoButton.isEnabled = true
                
                print("통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }

}
