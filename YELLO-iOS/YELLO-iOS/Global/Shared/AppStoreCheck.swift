//
//  AppStoreCheck.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/20.
//

import UIKit

class AppStoreCheck {
    
    // 현재 버전 : 타겟 -> 일반 -> Version
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    // 개발자가 내부적으로 확인하기 위한 용도 : 타겟 -> 일반 -> Build
    static let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    static let appStoreOpenUrlString = "itms-apps://itunes.apple.com/app/apple-store/6451451050"
    
    // 앱 스토어 최신 정보 확인
    func latestVersion(completion: @escaping (String?) -> Void) {
        let appleID = "6451451050"
        guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(appleID)&country=kr") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                  let results = json["results"] as? [[String: Any]],
                  let appStoreVersion = results[0]["version"] as? String else {
                completion(nil)
                return
            }
            
            completion(appStoreVersion)
        }.resume()
    }
    
    // 앱 스토어로 이동 -> urlStr 에 appStoreOpenUrlString 넣으면 이동
    func openAppStore() {
        guard let url = URL(string: AppStoreCheck.appStoreOpenUrlString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
