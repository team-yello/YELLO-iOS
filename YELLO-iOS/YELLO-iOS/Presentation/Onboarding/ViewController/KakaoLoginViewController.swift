//
//  KakaoLoginViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/15.
//

import UIKit

class KakaoLoginViewController: BaseViewController {
    
    let baseView = KakaoLoginView()
    
    override func loadView() {
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
    }

    func addTarget() {
        baseView.kakaoButton.addTarget(self, action: #selector(kakaoLoginButtonDidTap), for: .touchUpInside)
    }
    
    @objc func kakaoLoginButtonDidTap() {
        navigationController?.pushViewController(KakaoConnectViewController(), animated: true)
    }
    
}
