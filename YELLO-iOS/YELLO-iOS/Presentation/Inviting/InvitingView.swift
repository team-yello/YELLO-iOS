//
//  BaseSharingView.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/07.
//

import UIKit

import Amplitude
import SnapKit
import Then
import KakaoSDKShare

final class InvitingView: BaseView {
    
    var rootViewController = ""
    
    let contentsView = UIView()

    // 컴포넌트 위치 순서대로
    let closeButton = CloseButton()

    let titleLabel = UILabel()
    let textLabelOne = UILabel()
    let textLabelTwo = UILabel()
    let textLabelThree = UILabel()
    let textLabelFour = UILabel()
    
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
            $0.setTextWithLineHeight(text: StringLiterals.Inviting.title, lineHeight: 24.adjustedHeight)
            $0.textColor = .black
            $0.font = .uiHeadline04
        }
        
        textLabelOne.do {
            $0.text = StringLiterals.Inviting.firstText
            $0.textColor = .grayscales600
            $0.font = .uiLabelLarge
        }
        
        textLabelTwo.do {
            $0.text = StringLiterals.Inviting.secondText
            $0.textColor = .white
            $0.textAlignment = .center
            $0.backgroundColor = .purpleSub500
            $0.font = .uiLabelLarge
        }
        
        textLabelThree.do {
            $0.text = StringLiterals.Inviting.thirdText
            $0.textColor = .grayscales600
            $0.font = .uiLabelLarge
        }
        
        textLabelFour.do {
            $0.text = StringLiterals.Inviting.fourthText
            $0.textColor = .white
            $0.textAlignment = .center
            $0.backgroundColor = .purpleSub500
            $0.font = .uiLabelLarge
        }
        
        backGroundView.do {
            $0.backgroundColor = .grayscales100
            $0.makeCornerRound(radius: 8.adjustedHeight)
        }
        
        recommender.do {
            $0.text = "내 추천인 코드"
            $0.textColor = .grayscales600
            $0.font = .uiLabelLarge
        }
        
        recommenderID.do {
            $0.text = " "
            $0.textColor = .purpleSub500
            $0.font = .uiLittleLage
        }
        
        kakaoButton.do {
            $0.setImage(ImageLiterals.InvitingPopUp.icKakaoShare, for: .normal)
            $0.imageView?.contentMode = .scaleAspectFill
            $0.addTarget(self, action: #selector(kakaoButtonClicked), for: .touchUpInside)
        }
        
        copyButton.do {
            $0.setImage(ImageLiterals.InvitingPopUp.icLinkCopy, for: .normal)
            $0.imageView?.contentMode = .scaleAspectFill
            $0.addTarget(self, action: #selector(copyButtonClicked), for: .touchUpInside)
        }
    }
    
    // MARK: - Layout
    
    override func setLayout() {
        self.addSubview(contentsView)
        
        contentsView.addSubviews(closeButton,
                                 titleLabel,
                                 textLabelOne,
                                 textLabelTwo,
                                 textLabelThree,
                                 textLabelFour,
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
            $0.top.equalToSuperview().inset(38.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        textLabelOne.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(16.adjustedHeight)
        }
        
        textLabelTwo.snp.makeConstraints {
            $0.top.equalTo(textLabelOne.snp.bottom).offset(1.adjusted)
            $0.leading.trailing.equalToSuperview().inset(70.adjusted)
            $0.height.equalTo(20.adjustedHeight)
        }
        
        textLabelThree.snp.makeConstraints {
            $0.top.equalTo(textLabelTwo.snp.bottom).offset(14.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(16.adjustedHeight)
        }
        
        textLabelFour.snp.makeConstraints {
            $0.top.equalTo(textLabelThree.snp.bottom).offset(3.adjusted)
            $0.leading.trailing.equalToSuperview().inset(94.adjusted)
            $0.height.equalTo(20.adjustedHeight)
        }
        
        backGroundView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(14.adjustedWidth)
            $0.bottom.equalToSuperview().inset(102.adjustedHeight)
            $0.height.equalTo(80.adjustedHeight)
        }
        
        recommender.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        recommenderID.snp.makeConstraints {
            $0.top.equalTo(recommender.snp.bottom).offset(3.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        kakaoButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(94.adjustedWidth)
            $0.bottom.equalToSuperview().inset(36.adjustedHeight)
            $0.size.equalTo(48.adjusted)
        }
        
        copyButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(94.adjustedWidth)
            $0.bottom.equalToSuperview().inset(36.adjustedHeight)
            $0.size.equalTo(48.adjusted)
        }
    }
}

extension InvitingView {
    
    @objc
    func closeButtonClicked() {
        self.isHidden = true
        self.removeFromSuperview()
    }
    
    @objc
    func kakaoButtonClicked() {
        let templateId = Config.kakaoTempleteId
        
        guard let filteredString = self.recommenderID.text else { return }
        let recommenderID = String(filteredString.dropFirst())
        UIPasteboard.general.string = recommenderID
        updateEvent()
        // 카카오톡 설치여부 확인
        if ShareApi.isKakaoTalkSharingAvailable() {
            // 카카오톡으로 카카오톡 공유 가능
            ShareApi.shared.shareCustom(templateId: Int64(templateId) ?? 0,
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
            if ShareApi.shared.makeCustomUrl(templateId: Int64(templateId) ?? 0,
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
        updateEvent()
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
                self.recommenderID.text = "@" + data.yelloID
                self.copyButton.isEnabled = true
                self.kakaoButton.isEnabled = true
                
                print("통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
    
    func updateEvent() {
        var keyValue = ""
        
        switch rootViewController {
        case "KakaoFriendViewController":
            keyValue = "recommend_kakao_nofriend"
        case "kakao":
            keyValue = "recommend_kakao_yesfriend"
        case "SchoolFriendViewController":
            keyValue = "recommend_school_nofriend"
        case "school":
            keyValue = "recommend_school_yesfriend"
        case "AroundViewController":
            keyValue = "timeline_0friend"
        case "VotingLockedViewController":
            keyValue = "vote_4down"
        case "VotingTimerViewController":
            keyValue = "timeline_0friend"
        default:
            return
        }
        
        print("✅✅키값은 이거야!!\(keyValue)")
        
        Amplitude.instance().logEvent("click_invite_link", withEventProperties: ["invite_view": keyValue])
        let identify = AMPIdentify()
            .add("user_invite", value: NSNumber(value: 1))
        guard let identify = identify else {return}
        Amplitude.instance().identify(identify)
        
    }

}
