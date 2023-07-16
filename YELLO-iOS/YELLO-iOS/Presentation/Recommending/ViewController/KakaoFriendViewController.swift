//
//  KakaoFriendViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

final class KakaoFriendViewController: UIViewController {
    
    // MARK: - Variables
    // MARK: Component
    private let kakaoFriendView = KakaoFriendView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        recommendingKakaoFriend()
    }
}

// MARK: - extension
extension KakaoFriendViewController {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        view.backgroundColor = .black
    }
    
    private func setLayout() {
        let tabbarHeight = 60 + safeAreaBottomInset()
        
        view.addSubview(kakaoFriendView)
        kakaoFriendView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(tabbarHeight)
        }
    }
}

// MARK: - Network
extension KakaoFriendViewController {
    func recommendingKakaoFriend() {
        let queryDTO = RecommendingRequestQueryDTO(page: 0)
        let requestDTO = RecommendingFriendRequestDTO(friendKakaoId: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"])
        NetworkService.shared.recommendingService.recommendingKakaoFriend(queryDTO: queryDTO, requestDTO: requestDTO) { response in
            switch response {
            case .success:
                print("통신 성공")
            default:
                print("network fail")
                return
            }
        }
    }
}
