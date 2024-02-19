//
//  Timer.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2/19/24.
//

import UIKit

extension PaymentPlusViewController {
    
    func dateFormatter(_ createdAtDate: String)  {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let currentDateString = dateFormatter.string(from: currentDate)
        
        guard let date = dateFormatter.date(from: currentDateString) else { return }
        let secondsSince1970 = date.timeIntervalSince1970
        
        guard let afterDate = dateFormatter.date(from: createdAtDate) else { return }
        let afterSecondsSince1970 = afterDate.timeIntervalSince1970 + 3600
        
        var duration = afterSecondsSince1970 - secondsSince1970
        
        if duration < 0 {
            duration = 0
        }
        
        start(duration: duration)
    }
    
    private func start(duration: TimeInterval) {
        DispatchQueue.main.async {
            // timer
            self.countdownTimer?.invalidate()
            let startDate = Date()
            self.countdownTimer = Timer.scheduledTimer(
                withTimeInterval: 1,
                repeats: true,
                block: { [weak self] _ in
                    
                    let elapsedSeconds = round(abs(startDate.timeIntervalSinceNow))
                    let remainingSeconds = max(duration - elapsedSeconds, 0)
                    guard remainingSeconds > 0 else {
                        self?.stop()
                        return
                    }
                    self?.remainingSeconds = remainingSeconds
                }
            )
        }
    }
    
    private func stop() {
        self.countdownTimer?.invalidate()
    }
}
