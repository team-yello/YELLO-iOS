//
//  Config.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import Foundation

enum Config {
    
    enum Keys {
        enum Plist {
            static let baseURL = "BASE_URL"
            static let metaAppID = "META_APP_ID"
            static let kakaoAppKey = "KAKAO_APP_KEY"
            static let amplitudeKey = "AMPLITUDE_KEY"
            static let kakaoTempleteId = "KAKAO_TEMPLATE_ID"
            static let apiKey = "API_KEY"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot found.")
        }
        return dict
    }()
}

extension Config {
    
    static let baseURL: String = {
        guard let key = Config.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("Base URL is not set in plist for this configuration.")
        }
        return key
    }()
    
    static let metaAppID: String = {
        guard let key = Config.infoDictionary[Keys.Plist.metaAppID] as? String else {
            fatalError("metaAppID is not set in plist for this configuration.")
        }
        return key
    }()
    
    static let kakaoAppKey: String = {
        guard let key = Config.infoDictionary[Keys.Plist.kakaoAppKey] as? String else {
            fatalError("kakao is not set in plist for this configuration.")
        }
        return key
    }()
    
    static let amplitude: String = {
        guard let key = Config.infoDictionary[Keys.Plist.amplitudeKey] as? String else {
            fatalError("amplitude is not set in plist for this configuration.")
        }
        return key
    }()
    
    static let kakaoTempleteId: String = {
        guard let key = Config.infoDictionary[Keys.Plist.kakaoTempleteId] as? String else {
            fatalError("kakaoTempleteId is not set in plist for this configuration.")
        }
        return key
    }()
    
    static let key: String = {
        guard let key = Config.infoDictionary[Keys.Plist.kakaoTempleteId] as? String else {
            fatalError("apiKey is not set in plist for this configuration.")
        }
        return key
    }()
}
