//
//  VotingSharingViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

final class BaseInvitingViewController: BaseViewController {

    private let originView = BaseInvitingView()
    
    override func setStyle() {
        view.backgroundColor = .black
        
        originView.closeButton.do {
            $0.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        
        view.addSubview(originView)
        originView.snp.makeConstraints {
            $0.width.equalTo(300.adjustedWidth)
            $0.height.equalTo(374.adjustedHeight)
            $0.center.equalToSuperview()
        }
        
    }
    
    @objc
    func closeButtonClicked() {
        self.dismiss(animated: true)
    }

}
