//
//  User.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/19.
//

import Foundation

struct User {
    static var shared = User()
    
    var social: String = ""
    var uuid: String = ""
    var email: String = ""
    var profileImage: String = ""
    var groupId: Int = 0
    var groupAdmissionYear: Int = 0
    var name: String = ""
    var yelloId: String = ""
    var gender: String = ""
    var friends: [Int] = []
    var recommendId: String = ""
    
    private init() {}
}

