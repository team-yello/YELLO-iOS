//
//  ProgressBarManager.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/04.
//

import Foundation
import UIKit

class ProgressBarManager {
    static let shared = ProgressBarManager()
    let progressBarView = YelloProgressBarView()
    
    var progress: Double = 0.0
    
    private var stepDictionary: [UIViewController: Double] = [:]
        
        func updateProgress(for viewController: UIViewController, step: Int) {
            stepDictionary[viewController] = Double(step)
            updateProgressBar()
        }
        
        private func updateProgressBar() {
            if let currentViewController = getCurrentViewController() {
                if let step = stepDictionary[currentViewController] {
                    progressBarView.ratio = step / 6.0
                }
            }
        }
        
        private func getCurrentViewController() -> UIViewController? {
            // 현재 화면에 보이는 최상위 뷰 컨트롤러 반환
            return UIApplication.shared.keyWindow?.visibleViewController
        }
    
    func resetProgress() {
        progress = 0.0
        progressBarView.ratio = progress
    }
}
