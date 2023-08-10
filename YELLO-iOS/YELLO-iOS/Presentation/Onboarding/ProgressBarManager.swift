//
//  ProgressBarManager.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/04.
//

import Foundation

class ProgressBarManager {
    static let shared = ProgressBarManager()
    let progressBarView = YelloProgressBarView()
    
    var progress: Double = 0.0 
    
    func updateProgress(step: CGFloat) {
        if progress < 1.0 {
            progress = step / 6.0 // 각 뷰마다 1/6씩 채워짐
            progressBarView.ratio = progress
        }
        
        NotificationCenter.default.post(name: Notification.Name("ProgressBarUpdated"), object: nil)
    }
    
    func resetProgress() {
        progress = 0.0
        NotificationCenter.default.post(name: Notification.Name("ProgressBarUpdated"), object: nil)
    }
}
