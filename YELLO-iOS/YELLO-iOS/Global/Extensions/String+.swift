//
//  String+.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import Foundation

extension String {
    
    /// 한글만 포함하는지 확인
    func isContainKorean() -> Bool {
        let pattern = "^[가-힣]+$"
        guard self.range(of: pattern, options: .regularExpression) != nil else { return false}
        return true
    }
    
    /// 아이디인지 확인 :  알파벳과 온점(.), 밑줄(_) 만 포함하는 정규식
    func isId() -> Bool {
        let pattern = "^[0-9a-z._]+$"
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: self.utf16.count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
}
