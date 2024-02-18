//
//  User.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/19.
//

import Foundation

// MARK: - Enum
enum UserGroupType {
    case univ
    case high
    case middle
    case SOPT
}

struct UserManager {
    static var shared = UserManager()
    
    var social: String = "KAKAO"
    var uuid: String = ""
    var email: String = ""
    var deviceToken: String = ""
    var profileImage: String = StringLiterals.Recommending.Title.defaultProfileImageLink
    var groupId: Int = 1
    var groupType: UserGroupType = .univ
    var groupAdmissionYear: Int = 0
    var groupName: String = ""
    var subGroupName: String = ""
    var name: String = ""
    var yelloId: String = ""
    var gender: String = ""
    var friends: [Int] = []
    var kakaoFriends: [String] = []
    var recommendId: String = ""
    var adUUID = ""
    var userPoint: Int = 0 
    var userTicketCount: Int = 0 
    
    var isResigned: Bool = false
    var isFirstUser: Bool = false
    var isNeedModName: Bool = false
    var isYelloPlus: Bool = false
    
    var countVotingSkip = 0
    var countVoting = 0
    var countVotingCycle = 0
    
    private init() {}
}

func updateUserInfo(_ data: ProfileUserResponseDTO) {
    UserManager.shared.name = data.name
    UserManager.shared.profileImage = data.profileImageURL
    UserManager.shared.gender = data.gender
    UserManager.shared.email = data.email
    UserManager.shared.groupId = data.groupID
    UserManager.shared.groupName = data.groupName
    UserManager.shared.subGroupName = data.subGroupName
    UserManager.shared.groupAdmissionYear = data.groupAdmissionYear
    UserManager.shared.yelloId = data.yelloID
    UserManager.shared.uuid = data.uuid
    
    switch data.groupType {
    case "UNIVERSITY" :
        UserManager.shared.groupType = .univ
    case "HIGH_SCHOOL":
        UserManager.shared.groupType = .high
    case "MIDDLE_SCHOOL":
        UserManager.shared.groupType = .middle
    case "SOPT":
        UserManager.shared.groupType = .SOPT
    default:
        UserManager.shared.groupType = .univ
    }
}
