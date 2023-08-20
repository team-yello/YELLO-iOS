//
//  AppStoreCheck.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/20.
//

import Foundation

enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}

class AppStoreCheck {
    static func isUpdateAvailable(completion: @escaping (Bool?, Error?) -> Void) throws -> URLSessionDataTask {
        guard let info = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String, // 현재 버전
            let identifier = info["CFBundleIdentifier"] as? String,
            let url = URL(string: "http://itunes.apple.com/kr/lookup?bundleId=\(identifier)") else {
                throw VersionError.invalidBundleInfo
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let error = error { throw error }
                guard let data = data else { throw VersionError.invalidResponse }
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
                guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String else {
                    throw VersionError.invalidResponse
                }
                let verFloat = NSString.init(string: version).floatValue
                let currentVerFloat = NSString.init(string: currentVersion).floatValue
                completion(verFloat > currentVerFloat, nil) // 현재 버전이 앱스토어 버전보다 큰지를 Bool값으로 반환
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
        return task
    }
}
