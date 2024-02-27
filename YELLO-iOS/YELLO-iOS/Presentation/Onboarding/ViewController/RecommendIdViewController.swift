//
//  RecommendIdViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit
import Amplitude
import FirebaseCrashlytics

class RecommendIdViewController: OnboardingBaseViewController {
    // MARK: - Variables
    // MARK: Constants
    let maxLength = 20
    
    // MARK: Property
    var isExisted = false
    private var didPostUserInfo = false
    private var isFail = false
    
    // MARK: Component
    let pushViewController = PushSettingViewController()
    let baseView = RecommendIdView()
    let text = ""
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        step = 5
        isSkipable = true
        nextViewController = pushViewController
        super.viewDidLoad()
        setDelegate()
        addTarget()
    }
    
    // MARK: Layout Helper
    override func setStyle() {
        navigationBarView.backButton.isHidden = true
        
        nextButton.do {
            $0.setTitle("완료", for: .normal)
            $0.setButtonEnable(state: false)
        }
    }
    
    override func setLayout() {
        view.addSubview(baseView)
        baseView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    func setDelegate() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange(_:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: baseView.recommendIdTextField.textField)
        baseView.recommendIdTextField.textField.delegate = self
    }
    
    func addTarget() {
        nextButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        baseView.recommendIdTextField.textField.cancelButton.addTarget(self, action: #selector(idCancelTapped), for: .touchUpInside)
    }
    
    func checkButtonEnable() {
        let idTextFieldView = baseView.recommendIdTextField
        let idText = baseView.recommendIdTextField.textField.text ?? ""
        let isValidId = idText.isId()
        
        if !isExisted {
            idTextFieldView.textField.setButtonState(state: .error)
            idTextFieldView.helperLabel.setLabelStyle(text: "존재하지 않는 아이디에요", State: .error)
            nextButton.setButtonEnable(state: false)
            return
        } else {
            idTextFieldView.textField.setButtonState(state: .cancel)
            idTextFieldView.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.Recommand.recommandHelper, State: .normal)
        }
        
        let isButtonEnabled = !(idText.isEmpty) && isValidId && isExisted
        if isButtonEnabled {
            baseView.recommendIdTextField.textField.setButtonState(state: .done)
            baseView.recommendIdTextField.helperLabel.setLabelStyle(text: StringLiterals.Onboarding.Recommand.recommandHelper, State: .normal)
        }
        nextButton.setButtonEnable(state: isButtonEnabled)
    }
    
    func checkIdValid(text: String) {
        let queryDTO = IdValidRequestQueryDTO(yelloId: text)
        
        NetworkService.shared.onboardingService.getCheckDuplicate(queryDTO: queryDTO) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if data.data {
                        /// id 중복 조회 시, 중복되는 경우
                        self?.isExisted = true
                    } else {
                        /// id 중복 조회 시, 중복되지 않은 경우
                        self?.isExisted = false
                        self?.checkButtonEnable()
                    }
                    self?.checkButtonEnable()
                }
            default:
                DispatchQueue.main.async {
                    self?.checkButtonEnable()
                }
            }
        }
    }
    
    private func postUserInfo() {
        let user = UserManager.shared
        
        if user.gender == "" {
            UserManager.shared.gender = "FEMALE"
            Crashlytics.crashlytics().log("성별값이 올바르지 않습니다. 기본값으로 설정합니다.")
        }
        
        let requestDTO = SignUpRequestDTO(social: user.social, uuid: user.uuid, deviceToken: user.deviceToken, email: user.email, profileImage: user.profileImage, groupID: user.groupId, groupAdmissionYear: user.groupAdmissionYear, name: user.name, yelloID: user.yelloId, gender: user.gender, friends: user.friends, recommendID: user.recommendId)
        
        NetworkService.shared.onboardingService.postUserInfo(requestDTO: requestDTO) { [self] result in
            switch result {
            case .success(let data):
                guard let data = data.data else {
                    print("no data")
                    return
                }
                dump(data)
                KeychainHandler.shared.accessToken = data.accessToken
                UserDefaults.standard.setValue(true, forKey: "isLoggined")
                setAcessToken(accessToken: data.accessToken)
                setRefreshToken(refreshToken: data.refreshToken)
                print("유저 토큰 저장 완료: acess \(KeychainHandler.shared.accessToken) \n refresh \(KeychainHandler.shared.refreshToken)")
                setUsername(username: data.yelloID)
                Amplitude.instance().logEvent("complete_onboarding_finish")
                
                let currentDate = Date()
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let formattedDate = dateFormatter.string(from: currentDate)
                
                var userProperties: [AnyHashable : Any] = [:]
                userProperties["user_id"] = UserManager.shared.yelloId
                userProperties["user_name"] = UserManager.shared.name
                userProperties["user_sex"] = UserManager.shared.gender
                userProperties["user_grade"] = UserManager.shared.groupAdmissionYear
                userProperties["user_recommend"] = UserManager.shared.recommendId.isEmpty ? "yes" : "no"
                userProperties["user_signup_date"] = formattedDate
                Amplitude.instance().setUserProperties(userProperties)
                self.didPostUserInfo = true
                self.navigationController?.pushViewController(pushViewController, animated: false)
            case .requestErr(let data):
                self.isFail = true
                self.view.showToast(message: "오류가 발생했습니다. 잠시후 다시 시도해주세요.")
                Crashlytics.crashlytics().setUserID(UserManager.shared.yelloId)
                Crashlytics.crashlytics().log("dto: \(requestDTO) \n message: \(data.message)")
                return
            default:
                self.isFail = true
                self.view.showToast(message: "알 수 없는 오류가 발생하였습니다.")
                return
            }
        }
    }
    
    override func setUser() {
        if let text = baseView.recommendIdTextField.textField.text {
            UserManager.shared.recommendId = text
        }
    }
    
    // MARK: Objc Function
    @objc func idCancelTapped() {
        baseView.recommendIdTextField.helperLabel.setLabelStyle(text: "추천인의 아이디를 입력해주세요.", State: .normal)
        nextButton.setButtonEnable(state: false)
    }
    
    @objc func textDidChange(_ notification: Notification) {
        guard let text = baseView.recommendIdTextField.textField.text else { return }
        checkIdValid(text: text)
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                
                if text.count > maxLength {
                    textField.resignFirstResponder()
                }
                
                // 초과되는 텍스트 제거
                if text.count >= maxLength {
                    let index = text.index(text.startIndex, offsetBy: maxLength)
                    let newString = text[text.startIndex..<index]
                    textField.text = String(newString)
                }
            }
        }
        checkButtonEnable()
    }
    
    override func didTapButton(sender: UIButton) {
        setUser()
        
        if isFail {
            self.view.showToast(message: "알 수 없는 오류가 발생하였습니다.")
            return
        }
        if sender == skipButton {
            UserManager.shared.recommendId = ""
            Amplitude.instance().logEvent("click_onboarding_recommend", withEventProperties: ["rec_exist": "pass"] )
        } else if sender == nextButton {
            Amplitude.instance().logEvent("click_onboarding_recommend", withEventProperties: ["rec_exist": "next"] )
        }
        postUserInfo()
    }
}

// MARK: - extension
// MARK: UITextFieldDelegate
extension RecommendIdViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
        
        // 최대 글자수 이상을 입력한 이후에는 중간에 다른 글자를 추가할 수 없게끔 작동
        if text.count >= maxLength && range.length == 0 && range.location < maxLength {
            return false
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        baseView.recommendIdTextField.textField.setButtonState(state: .cancel)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        baseView.recommendIdTextField.textField.setButtonState(state: .id)
        guard let text = baseView.recommendIdTextField.textField.text else { return }
        checkIdValid(text: text)
        checkButtonEnable()
    }
    
}
