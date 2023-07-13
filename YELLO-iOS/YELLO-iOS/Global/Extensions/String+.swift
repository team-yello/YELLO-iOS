//
//  String+.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import Foundation

extension String {
    func isContainNumberAndAlphabet() -> Bool {
            let pattern = "^[0-9a-zA-Z]*$"
        guard self.range(of: pattern, options: .regularExpression) != nil else { return false}
            return true
        }
    
    func isContainEnglish() -> Bool {
            let pattern = "[A-Za-z]+"
        guard self.range(of: pattern, options: .regularExpression) != nil else { return false}
            return true
        }
}
