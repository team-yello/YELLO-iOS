//
//  OnboardingEndViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

class OnboardingEndViewController: BaseViewController {
    // MARK: - Variables
    // MARK: Component
    let baseView = OnboardingEndView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
    }
    
    // MARK: Custom Function
    private func addTarget() {
        baseView.goToYelloButton.addTarget(self, action: #selector(yelloButtondidTap), for: .touchUpInside)
    }
    
    private func postUserInfo() {
        let user = User.shared
        let requestDTO = SignUpRequestDTO(social: user.social, uuid: user.uuid, email: user.email, profileImage: user.profileImage, groupID: user.groupId, groupAdmissionYear: user.groupAdmissionYear, name: user.name, yelloID: user.yelloId, gender: user.gender, friends: [])
 
            NetworkService.shared.onboardingService.postUserInfo(requestDTO: requestDTO) { result in
                switch result {
                case .success(let data):
                    guard let data = data.data else {
                        print("no data")
                        return
                    }
                    print("성공!✅✅✅✅✅✅✅")
                    dump(data)
                    
                default:
                    return
                }
            }
            
    }
    
    // MARK: Objc Function
    @objc func yelloButtondidTap() {
        /// 온보딩 이후 rootViewController 변경
        let yelloTabBarController = YELLOTabBarController()
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        postUserInfo()
       UserDefaults.standard.set(true, forKey: "isLoggedIn")
       sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: yelloTabBarController)
    }
    
}
