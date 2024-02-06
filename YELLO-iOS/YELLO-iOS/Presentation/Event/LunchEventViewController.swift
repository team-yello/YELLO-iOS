//
//  LunchEventViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2/6/24.
//

import Foundation

final class LunchEventViewController: BaseViewController {
    
    private let originView = LunchEventView()
    
    override func loadView() {
        self.view = originView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 점심시간 이벤트 서버통신
        getLunchEvent()
        tabBarController?.tabBar.isHidden = false
    }
    
}

extension LunchEventViewController {
    private func getLunchEvent() {
        
    }
}
