//
//  KakaoConnectViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/15.
//

import UIKit

class KakaoConnectViewController: BaseViewController {
    
    let baseView = KakaoConnectView()

    override func loadView() {
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
    }
    
    func addTarget() {
        print("타겟 성공!✅✅✅✅✅✅✅")
        baseView.kakaoConnectButton.addTarget(self, action: #selector(connectButtonDidTap), for: .touchUpInside)
    }
    
    @objc func connectButtonDidTap() {
        navigationController?.pushViewController(SchoolSearchViewController(), animated: true)
    }
    
}
