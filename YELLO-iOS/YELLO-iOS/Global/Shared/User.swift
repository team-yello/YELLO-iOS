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
    var deviceToken: String = ""
    var profileImage: String = ""
    var groupId: Int = 0
    var groupAdmissionYear: Int = 0
    var name: String = ""
    var yelloId: String = ""
    var gender: String = ""
    var friends: [Int] = []
    var kakaoFriends: [String] = []
    var recommendId: String = ""
    
    var isResigned: Bool = false
    var isFirstUser: Bool = false
    
    var countVotingSkip = 0
    var countVoting = 0
    var countVotingCycle = 0
    
    private init() {}
}
